import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/details/widgets.dart';
import 'package:jay_fm_flutter/services/database_service.dart';
import 'package:jay_fm_flutter/services/saved_podcast_controller.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final Podcast podcast;
  SavedPodcastController get savedPodcastController =>
      GetIt.instance<SavedPodcastController>();
  DatabaseService get databaseService =>
      GetIt.instance<DatabaseService>();

  final Completer<String> urlCompleter = Completer<String>();

  DetailsPage({this.podcast});

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
            title: Text(podcast.name),
          ),
          body: Container(
              padding: EdgeInsets.only(left: 10, right: 9),
              color: state.colors.mainBackgroundColor,
              child: Stack(
                children: [
                  Center(
                    child: podcast.isCastbox
                        ? Container(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: WebView(
                                    initialUrl: Uri.dataFromString(
                                            '<html><body><iframe allowtransparency="true" src="${podcast.url}" frameborder="0" width="100%" height="500"></iframe></body></html>',
                                            mimeType: 'text/html')
                                        .toString(),
                                    javascriptMode: JavascriptMode.unrestricted,
                                    debuggingEnabled: true,
                                    onPageFinished: (url) {
                                      urlCompleter.complete(url);
                                    },
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: FutureBuilder<String>(
                                    future: urlCompleter.future,
                                    builder: (context, controller) {
                                      if (controller.hasData) {
                                        return Flexible(
                                            flex: 1,
                                            child: Stack(
                                              children: [
                                                state.bannerAd,
                                              ],
                                            ));
                                      }

                                      return CircularProgressIndicator();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.expand(
                            child: nonCastBoxPodcast(
                                state.colors, state, podcast.url)),
                  ),
                  podcast.isCastbox
                      ? FutureBuilder<String>(
                          future: urlCompleter.future,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Positioned(
                                bottom: 90,
                                right: 15,
                                child: FloatingActionButton(
                                    backgroundColor:
                                        state.colors.mainButtonsColor,
                                    child: Icon(Icons.save),
                                    onPressed: () {
                                      databaseService.insertPodcastToTable(podcast);
                                      savedPodcastController
                                          .addPodcastToStream(podcast);
                                      showToastMessage("Podcast saved");
                                    }),
                              );
                            }

                            return Container();
                          },
                        )
                      : Positioned(
                          bottom: 90,
                          right: 15,
                          child: FloatingActionButton(
                              backgroundColor: state.colors.mainButtonsColor,
                              child: Icon(Icons.save),
                              onPressed: () {
                                databaseService.insertPodcastToTable(podcast);
                                savedPodcastController
                                    .addPodcastToStream(podcast);
                                showToastMessage("Podcast saved");
                              }),
                        )
                ],
              )),
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
