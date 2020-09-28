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

/// The tab bar pop up menu and button
Widget tabBarPopUpMenu(BuildContext appContext, AppState state) {
  return PopupMenuButton<String>(
    itemBuilder: (context) {
      return choices.map((String choice) {
        return PopupMenuItem<String>(
            value: choice,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.check_circle,
                  color: switchCase2(state.selectedTheme, {
                    SelectedTheme.DARK:
                        choice == darkTheme ? Colors.green : Colors.grey,
                    SelectedTheme.LIGHT:
                        choice == lightTheme ? Colors.green : Colors.grey
                  }),
                ),
                Text(choice),
              ],
            ));
      }).toList();
    },
    onSelected: (choice) {
      tabBarPopUpChoiceAction(choice, appContext);
    },
  );
}
