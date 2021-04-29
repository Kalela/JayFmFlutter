import 'dart:async';
import 'package:JayFm/models/audio_meta_data.dart';
import 'package:JayFm/util/global_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/podcast.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/screens/details/functions.dart';
import 'package:JayFm/services/admob_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webfeed/webfeed.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:JayFm/services/player_service/player_service.dart';

AdMobService? get admobService => GetIt.instance<AdMobService>();
JayFmPlayerService? get audioPlayerService =>
    GetIt.instance<JayFmPlayerService>();
final Completer<String> urlCompleter = Completer<String>();

/// Podcast episodes list built from company owned resource
Widget nonCastBoxPodcast(AppState state, Podcast podcast) {
  return FutureBuilder<RssFeed?>(
    future: loadFeed(podcast.url!),
    builder: (context, snapshot) {
      if (!snapshot.hasData ||
          snapshot.connectionState != ConnectionState.done) {
        return SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ); // TODO: Progress indicator should be centered or use listview with shimmer
      }

      return SliverPadding(
        padding: EdgeInsets.only(bottom: 70),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
          List<String> splitTitle = snapshot.data!.items![i].title!.split(": ");
          return ExpansionTile(
            tilePadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            title: Text(
              "${splitTitle[0]}",
              style: TextStyle(color: state.colors.mainTextColor),
            ),
            subtitle: Text(
              getPresenters(splitTitle),
              style: defaultTextStyle(state),
            ),
            leading: Container(
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Image.asset('assets/images/about-you-placeholder.jpg'),
                imageUrl: snapshot.data!.items![i].itunes!.image!.href!,
              ),
            ),
            children: [
              Text(
                snapshot.data!.items![i].description!.split("---")[0],
                style: defaultTextStyle(state),
              )
            ],
            trailing: StreamBuilder<SequenceState?>(
              stream: audioPlayerService!.audioPlayer!.sequenceStateStream,
              builder: (context, sequenceSnapshot) {
                return StreamBuilder<PlayerState>(
                  stream: audioPlayerService!.audioPlayer!.playerStateStream,
                  builder: (context, playerStateSnapshot) {
                    return GestureDetector(
                      onTap: () async {
                        var playlist = ConcatenatingAudioSource(children: [
                          for (var episode in snapshot.data!.items!) ...[
                            AudioSource.uri(
                              Uri.parse(episode.enclosure!.url!),
                              tag: AudioMetadata(
                                presenters: getPresenters(splitTitle),
                                artwork: episode.itunes!.image!.href,
                                title: splitTitle[0],
                              ),
                            )
                          ]
                        ]);

                        if (sequenceSnapshot.data != null) {
                          if (sequenceSnapshot.data!.sequence[0].tag.title !=
                              playlist.children[0].sequence[0].tag.title) {
                            // Check if the playing playlist and the new playlist are the same
                            await audioPlayerService!
                                .setPlaylist(playlist, false);
                          }

                          if (sequenceSnapshot.data!.currentSource!.tag.title ==
                                  playlist.children[i].sequence[0].tag.title &&
                              playerStateSnapshot.data!.playing) {
                            await audioPlayerService!.audioPlayer!.pause();
                          } else {
                            await audioPlayerService!.audioPlayer!
                                .seek(Duration.zero, index: i);
                            await audioPlayerService!.audioPlayer!.play();
                          }
                        } else {
                          await audioPlayerService!
                              .setPlaylist(playlist, false);
                          await audioPlayerService!.audioPlayer!
                              .seek(Duration.zero, index: i);
                          await audioPlayerService!.audioPlayer!.play();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        child: PlayerStateIconBuilder(
                            80,
                            AudioMetadata(
                              presenters: snapshot.data!.items![i].title!
                                  .split(": ")[0],
                              artwork:
                                  snapshot.data!.items![i].itunes!.image!.href,
                              title: snapshot.data!.items![i].title,
                            ),
                            state),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }, childCount: snapshot.data!.items!.length)),
      );
    },
  );
}

Widget castboxPodcast(Podcast podcast, BuildContext context) {
  return SliverPadding(
    padding: EdgeInsets.only(bottom: 70),
    sliver: SliverList(
      key: Key("sliverListKey"),
      delegate: SliverChildListDelegate(
        [
          FutureBuilder<String>(
            future: urlCompleter.future,
            builder: (context, controller) {
              if (controller.hasData) {
                return admobService!.getBannerAd(context);
              }

              return SizedBox.shrink();
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            child: WebView(
              allowsInlineMediaPlayback: true,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                  .require_user_action_for_all_media_types,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
                ),
              },
              initialUrl: Uri.dataFromString(
                      '<html><body><iframe allowtransparency="true" src="${podcast.url}" frameborder="0" width="100%" height="500"></iframe></body></html>',
                      mimeType: 'text/html')
                  .toString(),
              key: Key("webviewKey"),
              javascriptMode: JavascriptMode.unrestricted,
              debuggingEnabled: true,
              onPageFinished: (url) {
                urlCompleter.complete(url);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
