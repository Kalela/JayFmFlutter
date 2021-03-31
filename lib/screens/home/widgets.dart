import 'package:JayFm/models/audio_meta_data.dart';
import 'package:JayFm/models/now_playing_state.dart';
import 'package:JayFm/util/audio_player_task.dart';
import 'package:JayFm/util/functions.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/podcast.dart';
import 'package:JayFm/services/admob_service.dart';
import 'package:JayFm/res/colors.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/screens/home/functions.dart';
import 'package:JayFm/services/podcasts_service/podcasts_service.dart';
import 'package:JayFm/services/player_service/player_service.dart';
import 'package:JayFm/util/global_widgets.dart';
import 'package:just_audio/just_audio.dart';

JayFmPlayerService get audioPlayerService =>
    GetIt.instance<JayFmPlayerService>();
PodcastsService get podcastService => GetIt.instance<PodcastsService>();
AdMobService get admobService => GetIt.instance<AdMobService>();

/// Parent widget of live tab contents
Widget liveTabDetails(AppState state, BuildContext context) {
  final double _playButtonDiameter = 200;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(padding: EdgeInsets.only(top: 0)),
      StreamBuilder<QueueState>(
          stream: queueStateStream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                snapshot?.data?.mediaItem != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text(
                              snapshot.data.mediaItem.title == 'Jay FM LIVE'
                                  ? "LIVE PLAYING"
                                  : "NOW PLAYING",
                              style: defaultTextStyle(state,
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(snapshot.data.mediaItem.artist,
                                  style: defaultTextStyle(state)),
                            )),
                          ])
                    : Column(
                        children: [
                          Text(
                            "LIVE RADIO",
                            style: defaultTextStyle(state,
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          Text("Jay Fm Live", style: defaultTextStyle(state)),
                        ],
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                playButton(state, _playButtonDiameter),
              ],
            );
          }),
      admobService.getBannerAd(context)
    ],
  );
}

Widget playButton(AppState state, double _playButtonDiameter) {
  return Container(
    height: _playButtonDiameter,
    width: _playButtonDiameter,
    child: StreamBuilder<QueueState>(
        stream: queueStateStream,
        builder: (context, queueStateSnapshot) {
          return RawMaterialButton(
            onPressed: () async {
              var playlist = ConcatenatingAudioSource(children: [
                AudioSource.uri(
                  Uri.parse(mainPodcastUrl),
                  tag: AudioMetadata(
                      presenters: "Jay FM",
                      artwork:
                          "https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded_nologo/1257463/1257463-1544431099377-b5cff27e66947.jpg",
                      title: "Jay FM LIVE",
                      url: mainPodcastUrl),
                )
              ]);

              QueueState queueState = queueStateSnapshot.data;

              checkAudioPlayProcess(queueState, playlist, 0);
            },
            fillColor: state.colors.mainButtonsColor,
            shape: CircleBorder(),
            elevation: 10.0,
            child: Center(
              child: Container(
                child: PlayerStateIconBuilder(
                    _playButtonDiameter,
                    MediaItem(
                        id: mainPodcastUrl,
                        album: "Jay FM",
                        title: "Jay FM LIVE"),
                    state),
              ),
            ),
          );
        }),
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
            stream: podcastService.streamController.savedPodcasts,
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
                        return Dismissible(
                          key: Key(snapshot.data[index].name),
                          background: Container(
                            color: jayFmMaroon,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Icon(Icons.delete),
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Container(
                                  child: Icon(Icons.delete),
                                  padding: EdgeInsets.only(right: 10),
                                ),
                              ],
                            ),
                          ),
                          onDismissed: (direction) {
                            podcastService.deletePodcast(snapshot.data[index]);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${snapshot.data[index].name} dismissed")));
                          },
                          child: ListTile(
                            title: Text(snapshot.data[index].name,
                                style: TextStyle(
                                    color: state.colors.mainTextColor)),
                            onTap: () {
                              openPodcastEpisodes(
                                  context, snapshot.data[index]);
                            },
                          ),
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
