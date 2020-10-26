import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/strings.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/details/details.dart';
import 'package:jay_fm_flutter/util/functions.dart'; // TODO: Find way to remove this import(high order fuctions maybe?)

/// Text colors for dark theme
const TextTheme darkTextTheme = TextTheme(
    bodyText2: TextStyle(color: Colors.grey),
    bodyText1: TextStyle(color: Colors.grey),
    headline6: TextStyle(color: Colors.grey));

/// Base Item card for podcasts
Widget baseItemCard(int index, String title, BuildContext context) {
  return Container(
    color: jayFmFancyBlack.withOpacity(0.0),
    height: 120,
    child: Ink(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        title: title,
                      )));
        },
        child: Card(
          color: jayFmFancyBlack,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    width: 100,
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "09.00 - 10.00",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Show Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Text(
                          "Presenter names",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

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
                        "Podcast Title",
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
Widget drawerPopUpMenu(
    {GlobalAppColors colors, BuildContext context, AppState state}) {
  return Container(
    color: colors.mainBackgroundColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text('We speak music'),
          decoration: BoxDecoration(
            color: colors.mainIconsColor,
          ),
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
                SelectedTheme.DARK:
                    choice == darkTheme ? colors.mainIconsColor : Colors.grey,
                SelectedTheme.LIGHT:
                    choice == lightTheme ? colors.mainIconsColor : Colors.grey
              }),
            ),
            title: Text(choice, style: TextStyle(color: colors.mainTextColor),),
          );
        }).toList()),
        Divider(color: colors.mainTextColor,),
        audioQuality(colors, state, context),
        Divider(color: colors.mainTextColor)
      ],
    ),
  );
}

/// Custom scaffold widget for use throughout the application
class SharedScaffold extends Scaffold {
  SharedScaffold(
      {Widget body,
      AppBar appBar,
      GlobalAppColors colors,
      dynamic bottomSheet,
      BuildContext context,
      AppState state,
      Drawer drawer})
      : super(
            body: body,
            appBar: appBar,
            bottomSheet: bottomSheet,
            drawer: Drawer(
              child: drawerPopUpMenu(
                  colors: colors, context: context, state: state),
            ));
}

/// Audio quality widget
Widget audioQuality(
    GlobalAppColors colors, AppState state, BuildContext context) {
  return Column(
    children: [
      Text("AUDIO QUALITY", style: defaultTextStyle(colors)),
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
              Text("LOW", style: defaultTextStyle(colors))
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
              Text("MED", style: defaultTextStyle(colors))
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
              Text("HIGH", style: defaultTextStyle(colors))
            ],
          )
        ],
      ),
    ],
  );
}
