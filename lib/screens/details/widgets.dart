import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
                  child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Image.asset('assets/images/about-you-placeholder.jpg'),
                imageUrl: snapshot.data.items[i].itunes.image.href,
              )),
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



// /// Podcast episodes list built from a castbox html resource
// Widget castBoxPodcast(String webviewContent) {
//   var webView = WebView(
//     initialUrl:
//         Uri.dataFromString(webviewContent, mimeType: 'text/html').toString(),
//     javascriptMode: JavascriptMode.unrestricted,
//     debuggingEnabled: true,
//     onWebViewCreated: (webViewController) {
//       print("I am here");
//       _controller.complete(webViewController);
//     },
//   );

//   return FutureBuilder<WebViewController>(
//     future: _controller.future,
//     builder: (context, controller) {
//       if (controller.hasData) {
//         return webView;
//       }

//       return CircularProgressIndicator();
//     },
//   );
// }
