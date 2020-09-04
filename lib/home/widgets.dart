import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/details/details.dart';
import 'package:jay_fm_flutter/util/colors.dart';
import 'package:jay_fm_flutter/util/values.dart';
import 'package:jay_fm_flutter/util/widget/widget.dart';

Widget liveTabDetails() {
  return Container(
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              "Line Up",
              style: TextStyle(fontSize: 25),
            ),
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
  );
}

Widget browseTabDetails() {
  return Container(
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              "Browse Categories",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 700,
            child: ListView.builder(itemBuilder: (context, i) {
              return baseItemCard(i, "Category Podcasts", context);
            }),
          )
        ],
      ),
    ),
  );
}

Widget latestTabDetails() {
  return Container(
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              "Latest Podcasts",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 700,
            child: ListView.builder(itemBuilder: (context, i) {
              return baseItemCard(i, "Podcast Name", context);
            }),
          )
        ],
      ),
    ),
  );
}

Widget savedTabDetails() {
  return Container(
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              "Saved Podcasts",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 700,
            child: ListView.builder(itemBuilder: (context, i) {
              return baseItemCard(i, "Saved Podcast", context);
            }),
          )
        ],
      ),
    ),
  );
}

Widget topBarTab(String text, Color borderColor) {
  return Column(
    children: <Widget>[
      ClipOval(
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: jayFmFancyBlack,
          ),
          child: Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(text),
            ),
          ),
        ),
      ),
      Text(
        text,
        style: TextStyle(color: Colors.black),
      )
    ],
  );
}

Widget tabViewBackground(Widget viewContents) {
  return SizedBox.expand(
    child: Container(
      color: jayFmBlue,
      child: CustomPaint(
        painter: HomePainter(),
        child: Container(
            padding: EdgeInsets.only(top: topBarHeight), child: viewContents),
      ),
    ),
  );
}

class HomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();

    paint.color = jayFmOrange;

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.25);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
