import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/strings.dart';

/// These are the tab bar pop up choices
const List<String> choices = <String>[darkTheme, lightTheme];

/// Default text styling that is used by all text
TextStyle defaultTextStyle(AppState state, [textStyle]) {
  if (textStyle != null)
    return TextStyle(color: state.colors.mainTextColor).merge(textStyle);

  return TextStyle(color: state.colors.mainTextColor);
}

double topBarHeight = 35.0;

const mainPodcastUrl = "http://stream.zeno.fm/geapkb665rquv";

List availablePodcasts = [
  Podcast(
      name: "About You",
      url: "https://anchor.fm/s/81752fc/podcast/rss",
      isCastbox: false),
  Podcast(
      name: "The Science of Sex",
      url:
          "https://castbox.fm/app/castbox/player/id1408503/id139019454?v=8.22.11&autoplay=0",
      isCastbox: true),
  Podcast(name: "Show Reel"),
  Podcast(name: "I Have No Idea What I'm Doing"),
  Podcast(name: "Open Sky Fitness"),
  Podcast(name: "Randy Pontiff Sex Show"),
  Podcast(name: "African Tech Roundup"),
  Podcast(name: "Deconstructed"),
  Podcast(name: "The Bodybuilding.com Podcast"),
  Podcast(name: "Garyvee Audio Experience"),
  Podcast(name: "Global Journalist Radio"),
  Podcast(name: "1 Million Milionares"),
];
