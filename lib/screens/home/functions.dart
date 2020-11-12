import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/values.dart';
import 'package:jay_fm_flutter/screens/details/details.dart';

/// Open podcast episodes page
openPodcastEpisodes(BuildContext context, Podcast podcast) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsPage(
                podcast: podcast,
              )));
}

/// Get list of all available podcasts
List<Widget> getPodcastList(AppState state, BuildContext context) {
  List<Widget> list = [];

  for (Podcast podcast in availablePodcasts) {
    list.add(ListTile(
      title: Text(podcast.name, style: defaultTextStyle(state, textStyle: TextStyle(fontWeight: FontWeight.bold))),
      contentPadding: EdgeInsets.all(8.0),
      subtitle: podcast.description != null ? Text(podcast.description, style: defaultTextStyle(state),): SizedBox.shrink(),
      onTap: () {
        openPodcastEpisodes(context, podcast);
      },
    ));
  }

  return list;
}
