import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/strings.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:just_audio/just_audio.dart'; // TODO: Find way to remove this import(high order fuctions maybe?)

AudioPlayer get audioPlayer => GetIt.instance<AudioPlayer>();

/// The now playing footer(typically goes into scaffold bottom)
Widget nowPlayingFooter(AppState state, Color backgroundColor, Color titleColor,
    Color subtitleColor) {
  return StreamBuilder<Map<String, dynamic>>(
      stream: audioPlayer.nowPlaying,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    child: Image.asset('assets/images/about-you-placeholder.jpg'),
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
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
                              imageUrl: snapshot.data['image_url'],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data['title'],
                                  style: TextStyle(
                                      fontSize: 18, color: titleColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  snapshot.data['presenters'],
                                  style: TextStyle(
                                      fontSize: 15, color: subtitleColor),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      playAudio(context, snapshot.data['audio_url']);
                    },
                    child: playerStateIconBuilder(
                        state, 80, snapshot.data['audio_url']),
                  )
                ],
              ),
            ));
      });
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
              color: switchCase2(state.selectedTheme, {
                SelectedTheme.DARK: choice == darkTheme
                    ? state.colors.mainIconsColor
                    : Colors.grey,
                SelectedTheme.LIGHT: choice == lightTheme
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
        Divider(color: state.colors.mainTextColor)
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
      BuildContext context,
      AppState state,
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
showToastMessage(String message) {
  Fluttertoast.showToast(msg: message);
}

/// Builds the play button icon based on the current play state
Widget playerStateIconBuilder(
    AppState state, double _playButtonDiameter, String url) {
  return StreamBuilder<PlayerState>(
    stream: audioPlayer.playerStateStream,
    builder: (context, snapshot) {
      if (snapshot.data == null) {
        return Icon(
          Icons.play_arrow,
          color: state.colors.mainIconsColor,
          size: _playButtonDiameter / 2,
        );
      }

      if (snapshot.data.playing &&
          audioPlayer.nowPlayingMap['audio_url'] == url) {
        return Icon(
          Icons.pause,
          color: state.colors.mainIconsColor,
          size: _playButtonDiameter / 2,
        );
      } else if (!snapshot.data.playing &&
          audioPlayer.nowPlayingMap['audio_url'] == url) {
        return switchCase2(snapshot.data.processingState, {
          ProcessingState.none: Icon(
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
      } else {
        return Icon(
          Icons.play_arrow,
          color: state.colors.mainIconsColor,
          size: _playButtonDiameter / 2,
        );
      }
    },
  );
}
