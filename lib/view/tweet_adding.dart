import 'package:flutter/material.dart';
import 'package:lucidplustest/constant/function.dart';
import 'package:lucidplustest/view/home_screen.dart';
import 'package:provider/provider.dart';
import '../constant/constant.dart';
import '../viewmodel/login_provider.dart';
import '../viewmodel/tweetprovider.dart';

class Tweet_Adding extends StatelessWidget {
  String id,from;
   Tweet_Adding({Key? key,required this.id,required this.from}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: height / 2,
              ),

               Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Consumer<TweetProvider>(builder: (context, value, child) {
                    return TextFormField(
                      autofocus: false,
                      maxLength: 280,
                      keyboardType: TextInputType.text,
                      controller: value.tweetcontroller,
                      decoration: InputDecoration(
                        helperText: '',
                        hintText: 'Enter Your Tweet',
                        contentPadding: const EdgeInsets.all(11),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Tweet";
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ),

              Consumer<TweetProvider>(
                builder: (context,value,child) {
                  return ElevatedButton(
                      onPressed: () {
                        final FormState? forme = _formKey.currentState;
                        if (forme!.validate()) {
                          value.addData(id,from);
                          finish(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(elevation: 10, backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                      ),
                      child: const Text("Submit Your Tweet"));
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
