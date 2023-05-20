import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucidplustest/viewmodel/login_provider.dart';
import 'package:provider/provider.dart';

class loginPage extends StatelessWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    LoginProvider loginProvider= Provider.of<LoginProvider>(context, listen: true);
    final FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
        body:
        SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: hieght/2.4),
                  const Text("Login"),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: loginProvider.PhoneNo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder:OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.grey[200]!, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.grey[200]!, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        //   focusedBorder: customFocusBorder,
                        hintText: 'Mobile Number',
                        hintStyle: const TextStyle(fontSize: 16),
                        // enabledBorder: customFocusBorder,
                        //   border: customFocusBorder,
                        // filled: true,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                      width: width,height: hieght/14,
                      decoration: BoxDecoration(
                        gradient:
                        const LinearGradient(
                            colors: [ Color(0xff04a201), Color(0xffbdeeb1)]),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ElevatedButton(
                        onPressed: ()  {

                          loginProvider.sendotp(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                        ), child:
                      // loginProvider.isloading == false ?
                      const Text("Login")
                      //       :const CircularProgressIndicator(
                      //   color: Colors.white,
                      // ),

                      )

                  ),


                ],),
            ),
        ),
        );
    }
}

