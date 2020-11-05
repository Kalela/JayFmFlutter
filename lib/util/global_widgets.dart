import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/strings.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/util/functions.dart'; // TODO: Find way to remove this import(high order fuctions maybe?)

/// Text colors for dark theme
const TextTheme darkTextTheme = TextTheme(
    bodyText2: TextStyle(color: Colors.grey),
    bodyText1: TextStyle(color: Colors.grey),
    headline6: TextStyle(color: Colors.grey));

/// The now playing footer(typically goes into scaffold bottom)
Widget nowPlayingFooter(
    Color backgroundColor, Color titleColor, Color subtitleColor) {
  return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Episode Title",
                        style: TextStyle(fontSize: 18, color: titleColor),
                      ),
                      Text(
                        "Presenter",
                        style: TextStyle(fontSize: 15, color: subtitleColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Icon(
              Icons.play_arrow,
              color: titleColor,
              size: 40,
            ),
          ],
        ),
      ));
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
