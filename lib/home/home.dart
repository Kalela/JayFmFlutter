import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/browse/browse.dart';
import 'package:jay_fm_flutter/util/constants.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/util/colors.dart';

class HomePage extends StatelessWidget {
  final double playButtonDiameter = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.jayFmFancyBlack,
        iconTheme: IconThemeData(color: Colors.grey),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.check_circle),
                        Text(choice),
                      ],
                    ));
              }).toList();
            },
            onSelected: popUpChoiceAction,
          )
        ],
      ),
      backgroundColor: LightTheme.jayFmBlue,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("LIVE PLAYING", style: TextStyle(fontSize: 16),),
                Text("Jay Fm"),
                Padding(padding: EdgeInsets.only(top: 8),),
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
                      color: LightTheme.jayFmFancyBlack),
                  child: InkWell(
                    onTap: () {
                      print("Play tapped");
                    },
                    child: Container(
                      height: playButtonDiameter,
                      width: playButtonDiameter,
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: LightTheme.jayFmOrange,
                          size: playButtonDiameter / 2,
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
                        Text("low")
                      ],
                    ),
                    Column(
                      children: [
                        Radio(
                          groupValue: null,
                          onChanged: (Null value) {},
                          value: null,
                        ),
                        Text("med")
                      ],
                    ),
                    Column(
                      children: [
                        Radio(
                          groupValue: null,
                          onChanged: (Null value) {},
                          value: null,
                        ),
                        Text("high")
                      ],
                    )
                  ],
                ),
              ],
            ),
            RaisedButton(
              color: LightTheme.jayFmOrange,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BrowsePage()));
              },
              child: Text("Browse Podcasts"),
            ),
          ],
        ),
      ),
    );
  }
}
