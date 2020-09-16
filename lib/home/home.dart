import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/browse/browse.dart';
import 'package:jay_fm_flutter/util/colors.dart';

class HomePage extends StatelessWidget {
  final double playButtonDiameter = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jayFmBlue,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
            ),
            Ink(
              child: InkWell(
                child: Container(
                  height: playButtonDiameter,
                  width: playButtonDiameter,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: playButtonDiameter / 2,
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: jayFmFancyBlack),
                ),
              ),
            ),
            Text("AUDIO QUALITY"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [Radio(), Text("low")],
                ),
                Column(
                  children: [Radio(), Text("med")],
                ),
                Column(
                  children: [Radio(), Text("high")],
                )
              ],
            ),
            RaisedButton(
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
