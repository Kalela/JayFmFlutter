import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/details/details.dart';

/// Open podcast episodes page
openPodcastEpisodes(BuildContext context, String feedUrl, bool isCastbox) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsPage(
                title: "Episodes",
                feedUrl: feedUrl,
                isCastbox: isCastbox,
              ))).then((value){
                // AdMobService.showHomeBannerAd();
              });
}

/// Get list of all available podcasts
List<Widget> getPodcastList(AppState state, BuildContext context) {
  List<Widget> list = [];

  list.add(ListTile(
    title: Text(
      "About You Podcast",
      style: TextStyle(color: state.colors.mainTextColor),
    ),
    onTap: () {
      openPodcastEpisodes(context, "https://anchor.fm/s/81752fc/podcast/rss", false);
    },
  ));

  for (Podcast podcast in availablePodcasts) {
    list.add(ListTile(
      title: Text(podcast.name, style: TextStyle(color: state.colors.mainTextColor)),
      onTap: () {
        openPodcastEpisodes(context, podcast.url, true);
      },
    ));
  }

  return list;
}
