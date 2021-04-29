import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/podcast.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/screens/details/widgets.dart';
import 'package:JayFm/services/podcasts_service/podcasts_service.dart';
import 'package:JayFm/util/global_widgets.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final Podcast? podcast;

  PodcastsService? get podcastService => GetIt.instance<PodcastsService>();

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
                IconThemeData(color: state.colors.textTheme!.bodyText1!.color),
            title: Text(podcast!.name!),
          ),
          body: Container(
              padding: EdgeInsets.only(left: 10, right: 9, top: 10),
              color: state.colors.mainBackgroundColor,
              child: Center(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                          child: Column(
                        children: [
                          Text(
                            podcast!.description,
                            style: defaultTextStyle(state,
                                textStyle: TextStyle(fontSize: 15)),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        ],
                      )),
                    ),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      shadowColor: Colors.black.withOpacity(0.0),
                      backgroundColor: Colors.black.withOpacity(0.0),
                      title: Center(
                        child: StreamBuilder<List<Podcast>>(
                            stream:
                                podcastService!.streamController!.savedPodcasts,
                            initialData: [],
                            builder: (context, snapshot) {
                              if (snapshot.data!.any(
                                  (element) => element.name == podcast!.name)) {
                                // If podcast is already saved
                                return FloatingActionButton.extended(
                                  heroTag: "deleteButton",
                                  onPressed: () {
                                    podcastService!.deletePodcast(podcast!);
                                  },
                                  label: Text("Remove from Saved"),
                                  icon: Icon(Icons.delete_outline),
                                );
                              }

                              return FloatingActionButton.extended(
                                heroTag: "saveButton",
                                onPressed: () {
                                  podcastService!.savePodcast(podcast!);
                                },
                                label: Text("Add to Saved"),
                                icon: Icon(Icons.save_outlined),
                              );
                            }),
                      ),
                    ),
                    podcast!.isIFrame!
                        ? castboxPodcast(podcast!, context)
                        : nonCastBoxPodcast(state, podcast!)
                  ],
                ),
              )),
          bottomSheet: Container(
              height: 70, color: Colors.black, child: NowPlayingFooter(state)),
        );
      },
    );
  }
}
