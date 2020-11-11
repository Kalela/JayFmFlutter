import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/details/functions.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:webfeed/webfeed.dart';

/// Podcast episodes list built from a company owned resource
Widget nonCastBoxPodcast(
    GlobalAppColors colors, AppState state, String feedUrl) {
  return FutureBuilder<RssFeed>(
    future: loadFeed(feedUrl),
    builder: (context, snapshot) {
      if (!snapshot.hasData ||
          snapshot.connectionState != ConnectionState.done) {
        return Center(child: CircularProgressIndicator());
      }

      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(bottom: 10),
            sliver: SliverToBoxAdapter(
              child: Container(
                  child: Text(
                snapshot.data.description.split(" Support")[0],
                style:
                    defaultTextStyle(state, textStyle: TextStyle(fontSize: 15)),
              )),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
            List<String> splitTitle = snapshot.data.items[i].title.split(": ");
            return ExpansionTile(
                tilePadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                title: Text(
                  "${splitTitle[0]}",
                  style: TextStyle(color: colors.mainTextColor),
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
          }, childCount: snapshot.data.items.length))
        ],
      );
    },
  );
}
