import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';

Widget liveTabDetails() {
  final double _playButtonDiameter = 200;

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "LIVE PLAYING",
              style: TextStyle(fontSize: 16),
            ),
            Text("Jay Fm"),
            Padding(
              padding: EdgeInsets.only(top: 8),
            ),
            Ink(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: jayFmFancyBlack),
              child: InkWell(
                onTap: () {
                  print("Play tapped");
                },
                child: Container(
                  height: _playButtonDiameter,
                  width: _playButtonDiameter,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: jayFmOrange,
                      size: _playButtonDiameter / 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text("AUDIO QUALITY"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Radio(
                      onChanged: (value) {},
                      groupValue: null,
                      value: null,
                    ),
                    Text("LOW")
                  ],
                ),
                Column(
                  children: [
                    Radio(
                      groupValue: null,
                      onChanged: (Null value) {},
                      value: null,
                    ),
                    Text("MED")
                  ],
                ),
                Column(
                  children: [
                    Radio(
                      groupValue: null,
                      onChanged: (Null value) {},
                      value: null,
                    ),
                    Text("HIGH")
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

/// Provide the browse page as a tab widget
Widget browseTabDetails() {
  final List<Widget> _tabViews = [
    Container(),
    Container(),
    tabViewBackground(savedTabDetails()),
  ];

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
            child: DefaultTabController(
              length: _tabViews.length,
              child: Container(
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: TabBarView(children: _tabViews),
                    ),
                    SizedBox(
                      height: topBarHeight,
                      child: TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.black.withOpacity(0.3),
                        tabs: [
                          browseBarTab("ENTERTAINMENT", Colors.black),
                          browseBarTab("CURRENT AFFAIRS", Colors.black),
                          browseBarTab("IDEOLOGY", Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

/// Provide the latest page as a widget(depriciated)
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

/// Provide the saved page as a widget
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

/// Generate a generic vertical scrollable view
Widget genericVerticalScrollableTabDetails() {
  return Container(
    child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          height: 700,
          child: ListView.builder(itemBuilder: (context, i) {
            return baseItemCard(i, "Saved Podcast", context);
          }),
        )),
  );
}

/// Main application tab bar
/// 
/// Accepts the tab text [text]
/// Acceppts th tab text color [textColor]
Widget topBarTab(String text, Color textColor) {
  return Text(text, style: TextStyle(color: textColor),);
}

/// Tab bar used in browser page
Widget browseBarTab(String text, Color borderColor) {
  return Text(
    text,
    style: TextStyle(color: Colors.black, fontSize: 10),
  );
}

Widget tabViewBackground(Widget viewContents) {
  return SizedBox.expand(
    child: Container(
      color: jayFmBlue,
      child: CustomPaint(
        // painter: HomePainter(),
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

    paint.color = jayFmBlue;

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
