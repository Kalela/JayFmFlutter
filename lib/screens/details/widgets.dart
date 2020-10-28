import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/details/functions.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:webfeed/webfeed.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

      print(snapshot.data);

      return ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: snapshot.data.items.length,
          itemBuilder: (context, i) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              title: Text(
                "${snapshot.data.items[i].title}",
                style: TextStyle(color: colors.mainTextColor),
              ),
              leading: Container(
                child: Image.network(snapshot.data.items[i].itunes.image.href),
              ),
              trailing: GestureDetector(
                  onTap: () {
                    playPodcast(
                        state, context, snapshot.data.items[i].enclosure.url);
                  },
                  child: Icon(
                    Icons.play_arrow,
                    color: colors.mainIconsColor,
                    size: 40,
                  )),
            );
          });
    },
  );
}

/// Podcast episodes list built from a castbox resource
Widget castBoxPodcast(String podcastUrl) {
  return WebView(
    initialUrl: podcastUrl,
    javascriptMode: JavascriptMode.unrestricted,

  );
}
