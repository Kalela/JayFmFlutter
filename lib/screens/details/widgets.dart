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

      return ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: snapshot.data.items.length,
          itemBuilder: (context, i) {
            List<String> splitTitle = snapshot.data.items[i].title.split(": ");
            return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
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
          });
    },
  );
}
