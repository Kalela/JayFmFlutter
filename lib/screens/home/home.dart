import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/home/widgets.dart';
import 'package:jay_fm_flutter/util/constants.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/res/values.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabViews = [
    tabViewBackground(liveTabDetails()),
    tabViewBackground(browseTabDetails()),
    tabViewBackground(savedTabDetails()),
  ];

  TabController _topTabController;

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(length: _tabViews.length, vsync: this);
  }

  @override
  void dispose() {
    _topTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JayFm"),
        centerTitle: true,
        backgroundColor: jayFmFancyBlack,
        iconTheme: IconThemeData(color: Colors.grey),
        textTheme: darkTextTheme,
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: SizedBox(
            height: topBarHeight,
            child: TabBar(
              controller: _topTabController,
              tabs: [
                topBarTab("Live", darkTextTheme.headline6.color),
                topBarTab("Browse", darkTextTheme.headline6.color),
                topBarTab("Saved", darkTextTheme.headline6.color),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SizedBox.expand(
              child: TabBarView(
                  controller: _topTabController, children: _tabViews),
            ),
          ],
        ),
      ),
    );
  }
}
