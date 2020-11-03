import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/details/widgets.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:jay_fm_flutter/util/stateful_wrapper.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final String title;
  final String feedUrl;
  final bool isCastbox;

  DetailsPage({this.title, this.feedUrl, this.isCastbox});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return SharedScaffold(
          context: context,
          state: state,
          appBar: AppBar(
            backgroundColor: jayFmFancyBlack,
            iconTheme: IconThemeData(color: Colors.grey),
            title: Text(title),
          ),
          body: Container(
              padding: EdgeInsets.only(left: 10, right: 9),
              color: state.colors.mainBackgroundColor,
              child: Center(
                child: isCastbox
                    ? Container(
                        child: castBoxPodcast(feedUrl),
                      )
                    : SizedBox.expand(
                        child:
                            nonCastBoxPodcast(state.colors, state, feedUrl)),
              )),
          bottomSheet: isCastbox ? null : Container(
            height: 70,
            color: Colors.black,
            child: nowPlayingFooter(jayFmMaroon, Colors.grey, jayFmOrange),
          ),
        );
      },
    );
  }
}
