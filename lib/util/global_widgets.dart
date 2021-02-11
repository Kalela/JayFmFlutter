import 'dart:io';

import 'package:JayFm/models/audio_meta_data.dart';
import 'package:JayFm/res/colors.dart';
import 'package:JayFm/screens/now_playing/now_playing_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/res/strings.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/util/functions.dart';
import 'package:just_audio/just_audio.dart';
import 'package:JayFm/services/player_service/player_service.dart';

JayFmPlayerService get audioPlayerService =>
    GetIt.instance<JayFmPlayerService>();

/// The now playing footer(typically goes into scaffold bottom)
class NowPlayingFooter extends HookWidget {
  final AppState state;

  NowPlayingFooter(this.state);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState>(
      stream: audioPlayerService.audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        return StreamBuilder<PlayerState>(
            stream: audioPlayerService.audioPlayer.playerStateStream,
            builder: (context, playerStateSnapshot) {
              if (!snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.all(10),
                  color: jayFmMaroon,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Container(
                          child: Image.asset(
                              'assets/images/about-you-placeholder.jpg'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final state2 = snapshot.data;
              final metadata = state2.currentSource.tag as AudioMetadata;

              if (state2?.sequence?.isEmpty ?? true)
                return Container(
                  padding: EdgeInsets.all(10),
                  color: jayFmMaroon,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Container(
                          child: Image.asset(
                              'assets/images/about-you-placeholder.jpg'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                );

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NowPlayingPage(),
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: jayFmMaroon,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: Container(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Image.asset(
                                          'assets/images/about-you-placeholder.jpg'),
                                      imageUrl: metadata.artwork,
                                      errorWidget: (context, error, stack) =>
                                          Image.asset(
                                              'assets/images/about-you-placeholder.jpg'),
                                    ),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          metadata.title,
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          metadata.presenters,
                                          style: TextStyle(
                                              fontSize: 15, color: jayFmOrange),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          metadata != null && playerStateSnapshot.data != null
                              ? GestureDetector(
                                  onTap: metadata != null &&
                                          playerStateSnapshot.data != null
                                      ? playerStateSnapshot.data.playing
                                          ? audioPlayerService.audioPlayer.pause
                                          : audioPlayerService.audioPlayer.play
                                      : null,
                                  child: PlayerStateIconBuilder(
                                    80,
                                    metadata,
                                    state,
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    )),
              );
            });
      },
    );
  }
}

/// The drawer pop up menu
Widget drawerPopUpMenu({AppState state, BuildContext context}) {
  return Container(
    color: state.colors.mainBackgroundColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // ignore: missing_required_param
        DrawerHeader(
          decoration: BoxDecoration(
              color: state.colors.mainIconsColor.withOpacity(0.5),
              image:
                  DecorationImage(image: AssetImage('assets/images/logo.png'))),
        ),
        Column(
            children: choices.map((String choice) {
          return ListTile(
            onTap: () {
              setThemeState(context, choice);
            },
            leading: Icon(
              // Use empty choice to render custom widget
              Icons.check_circle,
              color: switchCase2(state.colors.mainBackgroundColor, {
                jayFmFancyBlack: choice == darkTheme
                    ? state.colors.mainIconsColor
                    : Colors.grey,
                jayFmBlue: choice == lightTheme
                    ? state.colors.mainIconsColor
                    : Colors.grey
              }),
            ),
            title: Text(
              choice,
              style: TextStyle(color: state.colors.mainTextColor),
            ),
          );
        }).toList()),
        Divider(
          color: state.colors.mainTextColor,
        ),
        audioQuality(state, context),
        Divider(color: state.colors.mainTextColor),
        Padding(padding: EdgeInsets.only(top: 50)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Text(
                "Contact us; we just love the attention",
                style: defaultTextStyle(state),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        launchApp("https://wa.me/+254711412301/?text=");
                      } else {
                        launchApp(
                            "https://api.whatsapp.com/send?phone=+254711412301");
                      }
                    },
                    child: Image.asset(
                      "assets/images/whatsapp.png",
                      scale: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchApp(
                          'mailto:jayfm002@gmail.com?subject=Jay Fm App&body=Your%20thoughts...');
                    },
                    child: Image.asset(
                      "assets/images/gmail.png",
                      scale: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchApp(
                          "https://www.instagram.com/jay_fm_/");
                    },
                    child: Image.asset(
                      "assets/images/ig.png",
                      scale: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Center(
          child: Text(
            "\u00a9 Jay Fun Media",
            style: defaultTextStyle(state),
          ),
        )
      ],
    ),
  );
}

/// Custom scaffold widget for use throughout the application
class SharedScaffold extends Scaffold {
  SharedScaffold(
      {Widget body,
      AppBar appBar,
      dynamic bottomSheet,
      @required BuildContext context,
      @required AppState state,
      Drawer drawer})
      : super(
            body: body,
            appBar: appBar,
            bottomSheet: bottomSheet,
            drawer: Drawer(
              child: drawerPopUpMenu(context: context, state: state),
            ));
}

/// Audio quality widget
Widget audioQuality(AppState state, BuildContext context) {
  return Column(
    children: [
      Text("AUDIO QUALITY", style: defaultTextStyle(state)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Radio(
                onChanged: (value) {
                  setPodcastQuality(context, value);
                },
                groupValue: state.podcastQuality,
                value: PodcastQuality.LOW,
              ),
              Text("LOW", style: defaultTextStyle(state))
            ],
          ),
          Column(
            children: [
              Radio(
                groupValue: state.podcastQuality,
                onChanged: (value) {
                  setPodcastQuality(context, value);
                },
                value: PodcastQuality.MED,
              ),
              Text("MED", style: defaultTextStyle(state))
            ],
          ),
          Column(
            children: [
              Radio(
                groupValue: state.podcastQuality,
                onChanged: (value) {
                  setPodcastQuality(context, value);
                },
                value: PodcastQuality.HIGH,
              ),
              Text("HIGH", style: defaultTextStyle(state))
            ],
          )
        ],
      ),
    ],
  );
}

/// Returns a list tile of podcasts wrapped in a container.
/// These are the static available podcasts
Widget allPodcastsListView(List<Widget> tileList) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: ListView.separated(
      itemBuilder: (context, index) {
        return tileList[index];
      },
      itemCount: tileList.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
    ),
  );
}

/// Show toast message
// showToastMessage(String message) {
//   Fluttertoast.showToast(msg: message);
// }

class PlayerStateIconBuilder extends StatelessWidget {
  final double _playButtonDiameter;
  final AudioMetadata data;
  final AppState state;

  PlayerStateIconBuilder(this._playButtonDiameter, this.data, this.state);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayerService.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        return StreamBuilder<SequenceState>(
          stream: audioPlayerService.audioPlayer.sequenceStateStream,
          builder: (context, sequenceSnapshot) {
            if (snapshot.data == null) {
              return Icon(
                Icons.play_arrow,
                color: state.colors.mainIconsColor,
                size: _playButtonDiameter / 2,
              );
            }

            if (snapshot.data.playing) {
              final metadata =
                  sequenceSnapshot.data.currentSource.tag as AudioMetadata;
              if (snapshot.data.processingState == ProcessingState.loading ||
                  snapshot.data.processingState == ProcessingState.buffering) {
                if (data.title == metadata.title &&
                    data.presenters == metadata.presenters) {
                  return SizedBox(
                    height: _playButtonDiameter / 2,
                    width: _playButtonDiameter / 2,
                    child: CircularProgressIndicator(),
                  );
                }
              }
              if (data.title == metadata.title &&
                  data.presenters == metadata.presenters) {
                return Icon(
                  Icons.pause,
                  color: state.colors.mainIconsColor,
                  size: _playButtonDiameter / 2,
                );
              }
            } else if (!snapshot.data.playing) {
              return switchCase2(snapshot.data.processingState, {
                ProcessingState.idle: Icon(
                  Icons.play_arrow,
                  color: state.colors.mainIconsColor,
                  size: _playButtonDiameter / 2,
                ),
                ProcessingState.loading: SizedBox(
                  height: _playButtonDiameter / 2,
                  width: _playButtonDiameter / 2,
                  child: CircularProgressIndicator(),
                ),
                ProcessingState.buffering: SizedBox(
                  height: _playButtonDiameter / 2,
                  width: _playButtonDiameter / 2,
                  child: CircularProgressIndicator(),
                ),
                ProcessingState.ready: Icon(
                  Icons.play_arrow,
                  color: state.colors.mainIconsColor,
                  size: _playButtonDiameter / 2,
                ),
              });
            }

            return Container(
                child: Icon(
              Icons.play_arrow,
              color: state.colors.mainIconsColor,
              size: _playButtonDiameter / 2,
            ));
          },
        );
      },
    );
  }
}
