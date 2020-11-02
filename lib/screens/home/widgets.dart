import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/home/functions.dart';
import 'package:jay_fm_flutter/util/admob_service.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';

/// Parent widget of live tab contents
Widget liveTabDetails(AppState state, BuildContext context) {
  final double _playButtonDiameter = 200;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        children: [
          Text(
            "LIVE PLAYING",
            style: defaultTextStyle(state, TextStyle(fontSize: 16)),
          ),
          Text("Jay Fm", style: defaultTextStyle(state)),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Container(
              height: _playButtonDiameter,
              width: _playButtonDiameter,
              child: RawMaterialButton(
                  onPressed: () {
                    playPodcast(state, context, mainPodcastUrl);
                  },
                  fillColor: state.colors.mainButtonsColor,
                  shape: CircleBorder(),
                  elevation: 10.0,
                  child: livePlayButton(state, _playButtonDiameter))),
          
        ],
      ),
      state.bannerAd
    ],
  );
}

/// Play button in the middle of live tab
Widget livePlayButton(AppState state, double playButtonDiameter) {
  return Center(
    child: switchCase2(state.playState, {
      PodcastState.PAUSED: Icon(
        Icons.play_arrow,
        color: state.colors.mainIconsColor,
        size: playButtonDiameter / 2,
      ),
      PodcastState.PLAYING: Icon(
        Icons.pause,
        color: state.colors.mainIconsColor,
        size: playButtonDiameter / 2,
      ),
      PodcastState.STOPPED: Icon(
        Icons.play_arrow,
        color: state.colors.mainIconsColor,
        size: playButtonDiameter / 2,
      ),
      PodcastState.LOADING: SizedBox(
        height: playButtonDiameter / 2,
        width: playButtonDiameter / 2,
        child: CircularProgressIndicator(),
      ),
      PodcastState.BUFFERING: SizedBox(
        height: playButtonDiameter / 2,
        width: playButtonDiameter / 2,
        child: CircularProgressIndicator(),
      ),
      PodcastState.READY: Icon(
        Icons.play_arrow,
        color: state.colors.mainIconsColor,
        size: playButtonDiameter / 2,
      ),
      PodcastState.ERRORED: Icon(
        Icons.play_arrow,
        color: state.colors.mainIconsColor,
        size: playButtonDiameter / 2,
      ),
    }),
  );
}

/// Parent widget of browse tab contents
Widget browseTabDetails(AppState state, BuildContext context) {
  List<Widget> podcastTileList = getPodcastList(state, context);

  final List<Widget> _tabViews = [
    Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return podcastTileList[index];
        },
        itemCount: podcastTileList.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
      ),
    ),
    Container(),
  ];

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 15),
          child: Text(
            "Browse",
            style: defaultTextStyle(state, TextStyle(fontSize: 25)),
          ),
        ),
        Flexible(
          child: DefaultTabController(
            length: _tabViews.length,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox.expand(
                      child: TabBarView(children: _tabViews),
                    ),
                  ),
                  SizedBox(
                    height: topBarHeight,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.black.withOpacity(0.3),
                      tabs: [
                        browseBarTab(
                            "PODCASTS",
                            defaultTextStyle(
                                state, TextStyle(fontSize: 10.0))),
                        browseBarTab(
                            "FUN-TO-MENTAL",
                            defaultTextStyle(
                                state, TextStyle(fontSize: 10.0))),
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
  );
}

/// Parent widget of latest tab contents(depreciated)
Widget latestTabDetails(GlobalAppColors colors) {
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

/// Parent widget of saved tab contents
Widget savedTabDetails(AppState state) {
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
              style: defaultTextStyle(state, TextStyle(fontSize: 25)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 700,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, i) {
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
  return SizedBox(
    height: topBarHeight,
    child: Center(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}

/// Tab bar used in browser page
Widget browseBarTab(String text, TextStyle textStyle) {
  return Text(
    text,
    style: textStyle,
  );
}

Widget tabViewBackground(Widget viewContents, AppState state) {
  return Container(
    color: state.colors.mainBackgroundColor,
    child: viewContents,
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
