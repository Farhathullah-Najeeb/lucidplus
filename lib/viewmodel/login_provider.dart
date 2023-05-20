import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lucidplustest/view/home_screen.dart';

import '../constant/function.dart';
import '../view/otp_screen.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController otp_verify = TextEditingController();
  TextEditingController PhoneNo = TextEditingController();
  String VerificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool isloading = false;

  sendotp(BuildContext context) async {
    isloading = true;
          print("same value found");
          await auth.verifyPhoneNumber(
            phoneNumber: "+91${PhoneNo.text}",
            verificationCompleted: (PhoneAuthCredential credential) async {
              await auth.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == "invalid-phone-number") {
                print("provided phone number is invalid");
              }
            },
            codeSent: (String verificationId, int? resendToken) {
              VerificationId = verificationId;
              log("Verification Id : $verificationId");
              // bool isloading = false;
              notifyListeners();
              PhoneNo.clear();
              otp_verify.clear();
              callNextReplacement(const SubmitOtp(), context);
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
            timeout: const Duration(seconds: 60),
          );
        }

  verify(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationId, smsCode: otp_verify.text);
    await auth.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        callNextReplacement(const Home_Screen(), context);
      } else {
        if (kDebugMode) {
          print("6546");
        }
      }
    });
  }
}
