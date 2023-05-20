import 'package:flutter/material.dart';
import 'package:lucidplustest/constant/function.dart';
import 'package:lucidplustest/view/tweet_adding.dart';
import 'package:lucidplustest/view/widgets/logout_alert.dart';
import 'package:lucidplustest/viewmodel/tweetprovider.dart';
import 'package:provider/provider.dart';
import '../constant/constant.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TweetProvider get = Provider.of<TweetProvider>(context, listen: false);
    get.getdataa();
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            get.tweetcontroller.clear();
            callNext(
                Tweet_Adding(
                  id: '',
                  from: '',
                ),
                context);
          },
          label: const Text(
            "Enter your tweet",
            style: TextStyle(color: Colors.black),
          )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Center(
            child: Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            "TWEETS",
            style: TextStyle(color: Colors.black),
          ),
        )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logOutAlert(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: height*.03,
            ),
            Consumer<TweetProvider>(builder: (context, value, child) {
              return SizedBox(
                height: height,
                width: width,
                child: ListView.builder(
                    itemCount: value.userDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = value.userDataList[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onLongPress: () {
                              deleteAndeditTweet(context, item.id.toString());
                            },
                            child: Container(
                              height: height / 7,
                              width: width / 1.1,
                              decoration: BoxDecoration(
                                color: basewhite,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 1.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: width/1.4,child: Text(item.tweet.toString())),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        value.editTweet(item.id.toString());
                                        callNext(
                                            Tweet_Adding(
                                              id: item.id.toString(),
                                              from: 'edit',
                                            ),
                                            context);
                                      },
                                      icon: const Icon(Icons.edit_calendar_outlined))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }

  deleteAndeditTweet(BuildContext context, String id) {
    AlertDialog alert = AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Center(
        child: Text(
          "Do you want to delete this staff",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      ),
      content: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<TweetProvider>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      child: TextButton(
                          child: const Text(
                            'NO',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            finish(context);
                          }),
                    ),
                    Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      child: TextButton(
                          child: const Text('YES',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            value.deleteTweet(context, id);
                          }),
                    ),
                  ],
                );
              }),
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
}
