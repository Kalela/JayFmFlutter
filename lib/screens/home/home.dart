// import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/screens/home/widgets.dart';
import 'package:JayFm/util/global_widgets.dart';

class HomePage extends StatelessWidget {
  final int tabViewsLength = 3;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return DefaultTabController(
          length: tabViewsLength,
          child: SharedScaffold(
            context: context,
            state: state,
            appBar: AppBar(
              title: Container(
                child: Image.asset('assets/images/logo.png'),
                height: 80,
              ),
              centerTitle: true,
              backgroundColor: state.colors.mainBackgroundColor,
              iconTheme: IconThemeData(color: state.colors.textTheme.bodyText1.color),
              textTheme: state.colors.textTheme,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: TabBar(
                  tabs: [
                    topBarTab("Live", state.colors.textTheme.headline6.color),
                    topBarTab("Browse", state.colors.textTheme.headline6.color),
                    topBarTab("Saved", state.colors.textTheme.headline6.color),
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
        );
      },
    );
  }
}
