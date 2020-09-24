import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/util/constants.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  String title;

  DetailsPage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jayFmBlue,
      appBar: AppBar(
        backgroundColor: jayFmFancyBlack,
        iconTheme: IconThemeData(color: Colors.grey),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.check_circle),
                        Text(choice),
                      ],
                    ));
              }).toList();
            },
            onSelected: popUpChoiceAction,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10),
        color: jayFmBlue,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 25, color: jayFmFancyBlack),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 700,
                child: ListView.builder(itemBuilder: (context, i) {
                  return baseItemCard(i, "Day", context);
                }),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        color: Colors.black,
        child: nowPlayingFooter(jayFmMaroon, Colors.grey, jayFmOrange),
      ),
    );
  }
}
