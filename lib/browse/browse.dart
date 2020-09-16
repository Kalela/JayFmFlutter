import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/browse/widgets.dart';
import 'package:jay_fm_flutter/util/colors.dart';
import 'package:jay_fm_flutter/util/constants.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/util/strings.dart';
import 'package:jay_fm_flutter/util/values.dart';
import 'package:jay_fm_flutter/util/widget/widget.dart';

class BrowsePage extends StatelessWidget {
  final List<Widget> tabViews = [
    tabViewBackground(liveTabDetails()),
    tabViewBackground(browseTabDetails()),
    tabViewBackground(latestTabDetails()),
    tabViewBackground(savedTabDetails()),
  ];

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
      body: DefaultTabController(
        length: tabViews.length,
        child: Container(
          child: Stack(
            children: [
              SizedBox.expand(
                child: TabBarView(children: tabViews),
              ),
              SizedBox(
                height: topBarHeight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: TabBar(
                    indicator: ShapeDecoration(shape: Border.all()),
                    tabs: [
                      topBarTab("Live", Colors.black),
                      topBarTab("Browse", Colors.black),
                      topBarTab("Latest", Colors.black),
                      topBarTab("Saved", Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        color: Colors.white,
        child: nowPlayingFooter(
            LightTheme.jayFmFancyBlack, Colors.white, Colors.grey),
      ),
    );
  }
}
