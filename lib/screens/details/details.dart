import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final String title;

  DetailsPage({this.title});

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
        return Scaffold(
          backgroundColor: jayFmBlue,
          appBar: AppBar(
            backgroundColor: jayFmFancyBlack,
            iconTheme: IconThemeData(color: Colors.grey),
            actions: [tabBarPopUpMenu(colors, context, state)],
          ),
          body: Container(
            padding: EdgeInsets.only(left: 10),
            color: jayFmBlue,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 25, color: jayFmFancyBlack),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 700,
                    child: ListView.builder(itemBuilder: (context, i) {
                      return baseItemCard(i, "Day", context);
                    }),
                  )
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 70,
            color: Colors.black,
            child: nowPlayingFooter(jayFmMaroon, Colors.grey, jayFmOrange),
          ),
        );
      },
    );
  }
}
