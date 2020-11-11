import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/services/podcast_stream_controller.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/home/functions.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer get audioPlayer => GetIt.instance<AudioPlayer>();
PodcastStreamController get savedPodcastController =>
    GetIt.instance<PodcastStreamController>();

/// Parent widget of live tab contents
Widget liveTabDetails(AppState state, BuildContext context) {
  final double _playButtonDiameter = 200;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(padding: EdgeInsets.only(top: 0)),
      StreamBuilder<Map<String, dynamic>>(
          stream: audioPlayer.nowPlaying,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  snapshot.data['title'] == 'Jay Fm Live'
                      ? "LIVE PLAYING"
                      : "NOW PLAYING",
                  style: defaultTextStyle(state,
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Text(snapshot.data['title'].split(": ")[0],
                    style: defaultTextStyle(state)),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Container(
                    height: _playButtonDiameter,
                    width: _playButtonDiameter,
                    child: RawMaterialButton(
                        onPressed: () {
                          playAudio(context, mainPodcastUrl);
                          setNowPlayingInfo(title: "Jay Fm Live");
                        },
                        fillColor: state.colors.mainButtonsColor,
                        shape: CircleBorder(),
                        elevation: 10.0,
                        child: Center(
                            child: playerStateIconBuilder(
                                state, _playButtonDiameter, mainPodcastUrl)))),
              ],
            );
          }),
      state.bannerAd //TODO: Return this
    ],
  );
}

/// Parent widget of browse tab contents
Widget browseTabDetails(AppState state, BuildContext context) {
  List<Widget> podcastTileList = getPodcastList(state, context);

  final List<Widget> _tabViews = [
    allPodcastsListView(podcastTileList),
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
            style: defaultTextStyle(state, textStyle: TextStyle(fontSize: 25)),
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
                            defaultTextStyle(state,
                                textStyle: TextStyle(fontSize: 10.0))),
                        browseBarTab(
                            "FUN-TO-MENTAL",
                            defaultTextStyle(state,
                                textStyle: TextStyle(fontSize: 10.0))),
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

/// Parent widget of saved tab contents
Widget savedTabDetails(AppState state) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 15),
          child: Text(
            "Saved Podcasts",
            style: defaultTextStyle(state, textStyle: TextStyle(fontSize: 25)),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Flexible(
          child: StreamBuilder<List<Podcast>>(
            stream: savedPodcastController.savedPodcasts,
            initialData: [],
            // ignore: missing_return
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.active:
                  if (snapshot.data.length > 0) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name,
                              style:
                                  TextStyle(color: state.colors.mainTextColor)),
                          onTap: () {
                            openPodcastEpisodes(context, snapshot.data[index]);
                          },
                        );
                      },
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 15),
                      child: Text(
                        "No podcasts saved for quick access",
                        style: defaultTextStyle(state),
                      ),
                    );
                  }
                  break;
                case ConnectionState.done:
                  break;
              }
            },
          ),
        )
      ],
    ),
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
