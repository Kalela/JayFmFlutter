import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/details/details.dart';
import 'package:jay_fm_flutter/util/functions.dart';
import 'package:just_audio/just_audio.dart';

openPodcastEpisodes(BuildContext context, String feedUrl) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsPage(
                title: "Episodes",
                feedUrl: feedUrl,
              )));
}

List<Widget> getPodcastList(GlobalAppColors colors, BuildContext context) {
  List<Widget> list = [];

  list.add(ListTile(
    title: Text(
      "About You Podcast",
      style: TextStyle(color: colors.mainTextColor),
    ),
    onTap: () {
      openPodcastEpisodes(context, "https://anchor.fm/s/81752fc/podcast/rss");
    },
  ));

  for (Podcast podcast in availablePodcasts) {
    list.add(ListTile(
      title: Text(podcast.name, style: TextStyle(color: colors.mainTextColor)),
      onTap: () {
        openPodcastEpisodes(context, podcast.url);
      },
    ));
  }

  return list;
}
