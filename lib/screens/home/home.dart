import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/home/widgets.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:jay_fm_flutter/util/stateful_wrapper.dart';

class HomePage extends StatelessWidget {
  final int tabViewsLength = 3;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        // TODO: Move app colors to global
        GlobalAppColors colors = state.selectedTheme == SelectedTheme.LIGHT
            ? GlobalAppColors(
                mainBackgroundColor: jayFmBlue,
                mainButtonsColor: jayFmFancyBlack,
                mainIconsColor: jayFmOrange,
                mainTextColor: Colors.black)
            : GlobalAppColors(
                mainBackgroundColor: jayFmFancyBlack,
                mainButtonsColor: Colors.grey,
                mainIconsColor: Colors.blueGrey,
                mainTextColor: Colors.white);

        return StatefulWrapper(
          onInit: () async {
          },
          onDispose: () {
            //TODO: Dispose audio player on close
          },
          child: DefaultTabController(
            length: tabViewsLength,
            child: Scaffold(
              appBar: AppBar(
                title: Text("JayFm"),
                centerTitle: true,
                backgroundColor: jayFmFancyBlack,
                iconTheme: IconThemeData(color: Colors.grey),
                textTheme: darkTextTheme,
                actions: [tabBarPopUpMenu(colors, context, state)],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(30.0),
                  child: TabBar(
                    tabs: [
                      topBarTab("Live", darkTextTheme.headline6.color),
                      topBarTab("Browse", darkTextTheme.headline6.color),
                      topBarTab("Saved", darkTextTheme.headline6.color),
                    ],
                  ),
                ),
              ),
              body: TabBarView(children: [
                tabViewBackground(
                    liveTabDetails(colors, state, context), state),
                tabViewBackground(browseTabDetails(colors), state),
                tabViewBackground(savedTabDetails(colors), state),
              ]),
            ),
          ),
        );
      },
    );
  }
}
