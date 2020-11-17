import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/podcast.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/screens/details/functions.dart';
import 'package:JayFm/services/admob_service.dart';
import 'package:JayFm/util/functions.dart';
import 'package:JayFm/util/global_widgets.dart';
import 'package:webfeed/webfeed.dart';
import 'package:webview_flutter/webview_flutter.dart';

AdMobService get admobService => GetIt.instance<AdMobService>();
final Completer<String> urlCompleter = Completer<String>();

/// Podcast episodes list built from company owned resource
Widget nonCastBoxPodcast(AppState state, Podcast podcast) {
  return FutureBuilder<RssFeed>(
    future: loadFeed(podcast.url),
    builder: (context, snapshot) {
      if (!snapshot.hasData ||
          snapshot.connectionState != ConnectionState.done) {
        return SliverToBoxAdapter(
            child: Center(
                child:
                    CircularProgressIndicator())); // TODO: Progress indicator should be centered or use listview with shimmer
      }

      return SliverPadding(
        padding: EdgeInsets.only(bottom: 70),
              sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
          List<String> splitTitle = snapshot.data.items[i].title.split(": ");
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
                imageUrl: snapshot.data.items[i].itunes.image.href,
              )),
              children: [
                Text(
                  snapshot.data.items[i].description.split("---")[0],
                  style: defaultTextStyle(state),
                )
              ],
              trailing: GestureDetector(
                onTap: () {
                  playAudio(context, snapshot.data.items[i].enclosure.url);
                  setNowPlayingInfo(
                      title: snapshot.data.items[i].title,
                      presenters: getPresenters(splitTitle),
                      imageUrl: snapshot.data.items[i].itunes.image.href);
                },
                child: playerStateIconBuilder(
                    state, 80, snapshot.data.items[i].enclosure.url),
              ));
        }, childCount: snapshot.data.items.length)),
      );
    },
  );
}

Widget castboxPodcast(Podcast podcast) {
  return SliverPadding(
    padding: EdgeInsets.only(bottom: 70),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
      Container(
        height: 500,
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
      FutureBuilder<String>(
        future: urlCompleter.future,
        builder: (context, controller) {
          if (controller.hasData) {
            return admobService.getBannerAd(context);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    ])),
  );
}
