import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/util/colors.dart';
import 'package:jay_fm_flutter/util/widget/widget.dart';

class DetailsPage extends StatelessWidget {
  String title;

  DetailsPage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jayFmFancyBlack,
      appBar: AppBar(
        backgroundColor: jayFmFancyBlack,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10),
        color: jayFmFancyBlack,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 25, color: Colors.white),
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
