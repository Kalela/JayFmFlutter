import 'package:JayFm/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/podcast.dart';
import 'package:JayFm/res/strings.dart';

/// These are the tab bar pop up choices
const List<String> choices = <String>[darkTheme, lightTheme];

/// Default text styling that is used by all text. Allows dynamic changing of text style based on theme.
TextStyle defaultTextStyle(AppState state, {textStyle}) {
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
      description:
          "The podcast is based on the belief that; we give ourselves better odds of winning, when we approach life as a series of projects 'about you'. Join Jamal Abdallah and his team, with weekly special guests as they teach 'us' how to fail better, beat resistance and enjoy the benefits that come from completing a dream project; about you.",
      isIFrame: false),
  Podcast(
    name: "The Science of Sex",
    url:
        "https://castbox.fm/app/castbox/player/id1408503/id139019454?v=8.22.11&autoplay=0",
    isIFrame: true,
  ),
  Podcast(
    name: "Show Reel",
    url:
        "https://w.soundcloud.com/player/?visual=false&url=https%3A%2F%2Fapi.soundcloud.com%2Fusers%2F171927247&show_artwork=true&auto_play=false&show_playcount=false&show_comments=true&color=%23606060&height=450&width=728",
    isIFrame: true,
  ),
  Podcast(
      name: "I Have No Idea What I'm Doing",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id1475691/id311381469?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Open Sky Fitness",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id39195/id251060397?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Randy Pontiff Sex Show",
      isIFrame: true,
      url:
          "https://w.soundcloud.com/player/?visual=false&url=https%3A%2F%2Fapi.soundcloud.com%2Fusers%2F249635154&show_artwork=true&auto_play=false&show_playcount=false&show_comments=true&color=%23606060&height=450&width=709"),
  Podcast(
      name: "African Tech Roundup",
      isIFrame: true,
      url:
          "https://soundcloud.com/african-tech-round-up/embracing-development-finance-on-the-african-continent-with-jean-bosco-iyacu"),
  Podcast(
      name: "Deconstructed",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id1490945/id375854389?v=8.22.11&autoplay=0"),
  Podcast(
      name: "The Bodybuilding.com Podcast",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id979938/id318410719?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Garyvee Audio Experience",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id257325/id377535101?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Global Journalist Radio",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id468563/id377467084?v=8.22.11&autoplay=0"),
  Podcast(
      name: "1 Million Milionares",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id1967767/id130370375?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Key Africans Unlocked",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id1168420/id277316130?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Talking Heads",
      isIFrame: true,
      url: "https://w.soundcloud.com/player/?visual=false&url=https%3A%2F%2Fapi.soundcloud.com%2Fusers%2F83035360&show_artwork=true&auto_play=false&show_playcount=false&show_comments=true&color=%23606060&height=494&width=728"),
  Podcast(
      name: "LSE iQ Podcast",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id2727/id376598934?v=8.22.11&autoplay=0"),
  Podcast(
      name: "YALI Network Radio",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id371254/id259083651?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Ufahamu Africa",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id446891/id376105875?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Afracanah Podcast",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id374688/id319311620?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Getting Grown",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id506641/id377048495?v=8.22.11&autoplay=0"),
  Podcast(
      name: "The Benchwarmerz",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id403522/id317425432?v=8.22.11&autoplay=0"),
  Podcast(
      name: "On Violent Extremism",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id330914/id263336789?v=8.22.11&autoplay=0"),
  Podcast(
      name: "Hard Talk",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id468565/id377186843?v=8.22.11&autoplay=0"),
  Podcast(
      name: "CRYPTO 101",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id1565701/id357181791?v=8.22.11&autoplay=0"),
  Podcast(
      name: "48 Rules of Power",
      isIFrame: true,
      url: "https://w.soundcloud.com/player/?visual=false&url=https%3A%2F%2Fapi.soundcloud.com%2Fplaylists%2F33512958&show_artwork=true&auto_play=false&show_playcount=false&show_comments=true&color=%23606060&height=467&width=728"),
  Podcast(
      name: "Room for Relations",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id143508/id255977746?v=8.22.11&autoplay=0"),
  Podcast(
      name: "The Jtrain Podcast",
      isIFrame: true,
      url:
          "https://castbox.fm/app/castbox/player/id1364972/id377477776?v=8.22.11&autoplay=0"),
];
