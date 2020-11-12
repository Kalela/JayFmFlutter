import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/details/widgets.dart';
import 'package:jay_fm_flutter/services/podcasts_service.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final Podcast podcast;

  PodcastsService get podcastService => GetIt.instance<PodcastsService>();

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
            backgroundColor: state.colors.mainBackgroundColor,
            iconTheme:
                IconThemeData(color: state.colors.textTheme.bodyText1.color),
            title: Text(podcast.name),
          ),
          body: Container(
              padding: EdgeInsets.only(left: 10, right: 9),
              color: state.colors.mainBackgroundColor,
              child: Stack(
                children: [
                  Center(
                    child: podcast.isCastbox
                        ? castboxPodcast(podcast)
                        : SizedBox.expand(
                            child: nonCastBoxPodcast(state, podcast)),
                  ),
                  // podcast.isCastbox
                  //     ? FutureBuilder<String>(
                  //         future: urlCompleter.future,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             return Positioned(
                  //               bottom: 90,
                  //               right: 15,
                  //               child: FloatingActionButton(
                  //                   backgroundColor:
                  //                       state.colors.mainButtonsColor,
                  //                   child: Icon(Icons.save),
                  //                   onPressed: () {
                  //                     podcastService.savePodcast(podcast);
                  //                   }),
                  //             );
                  //           }
                  //           return SizedBox.shrink();
                  //         },
                  //       )
                  //     : Positioned(
                  //         bottom: 90,
                  //         right: 15,
                  //         child: FloatingActionButton(
                  //             backgroundColor: state.colors.mainButtonsColor,
                  //             child: Icon(Icons.save),
                  //             onPressed: () {
                  //               podcastService.savePodcast(podcast);
                  //             }),
                  //       ),
                ],
              )),
          bottomSheet: Container(
            height: 70,
            color: Colors.black,
            child: StreamBuilder<Object>(
                stream: audioPlayer.nowPlaying.stream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return SizedBox.shrink();
                  }
                  return nowPlayingFooter(
                      state, jayFmMaroon, Colors.grey, jayFmOrange);
                }),
          ),
        );
      },
    );
  }
}
