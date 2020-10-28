import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/models/podcast.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/strings.dart';

/// These are the tab bar pop up choices
const List<String> choices = <String>[darkTheme, lightTheme];

/// Default text styling that is used by all text
TextStyle defaultTextStyle(GlobalAppColors colors, [textStyle]) {
  if (textStyle != null)
    return TextStyle(color: colors.mainTextColor).merge(textStyle);

  return TextStyle(color: colors.mainTextColor);
}

double topBarHeight = 35.0;

const mainPodcastUrl = "http://stream.zeno.fm/geapkb665rquv";

List availablePodcasts = [
  Podcast(name: "The Science of Sex"),
  Podcast(name: "Show Reel"),
  Podcast(name: "I Have No Idea What I'm Doing"),
  Podcast(name: "Open Sky Fitness"),
  Podcast(name: "Randy Pontiff Sex Show"),
  Podcast(name: "African Tech Roundup"),
  Podcast(name: "Deconstructed"),
  Podcast(name: "The Bodybuilding.com Podcast"),
];
