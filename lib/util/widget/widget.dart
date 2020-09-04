import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jay_fm_flutter/details/details.dart';
import 'package:jay_fm_flutter/util/colors.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({@required this.onInit, @required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

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

Widget nowPlayingFooter(Color backgroundColor, Color titleColor, Color subtitleColor) {
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
