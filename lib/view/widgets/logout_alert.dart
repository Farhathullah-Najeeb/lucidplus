import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucidplustest/constant/constant.dart';

import '../../constant/function.dart';
import '../login_screen.dart';

logOutAlert(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    scrollable: true,
    title: Container(
      child: const Text(
        "Are you sure?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    content: Container(
      // height: 50,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextButton(
                      child: Text('YES', style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        auth.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>loginPage()));
                      }),
                ),
                Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextButton(
                      child: Text(
                        'NO',
                        style: TextStyle(color: basewhite),
                      ),
                      onPressed: () {
                        finish(context);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
