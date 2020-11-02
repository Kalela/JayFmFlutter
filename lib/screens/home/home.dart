// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/home/widgets.dart';
import 'package:jay_fm_flutter/util/admob_service.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:jay_fm_flutter/util/stateful_wrapper.dart';

class HomePage extends StatelessWidget {
  final int tabViewsLength = 3;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return StatefulWrapper(
          onInit: () async {
            // AdMobService.showHomeBannerAd();
          },
          onDispose: () {
          },
          child: DefaultTabController(
            length: tabViewsLength,
            child: SharedScaffold(
              context: context,
              state: state,
              appBar: AppBar(
                title: Container(child: Image.asset('assets/images/logo.png'), height: 80,),
                centerTitle: true,
                backgroundColor: jayFmFancyBlack,
                iconTheme: IconThemeData(color: Colors.grey),
                textTheme: darkTextTheme,
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
                tabViewBackground(liveTabDetails(state, context), state),
                tabViewBackground(browseTabDetails(state, context), state),
                tabViewBackground(savedTabDetails(state), state),
              ]),
            ),
          ),
        );
      },
    );
  }
}
