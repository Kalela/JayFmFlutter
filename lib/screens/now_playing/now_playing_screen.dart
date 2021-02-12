// import 'package:JayFm/models/app_state.dart';
// import 'package:JayFm/models/position_data.dart';
// import 'package:JayFm/screens/now_playing/widgets.dart';
// import 'package:JayFm/services/player_service/player_service.dart';
// import 'package:JayFm/util/global_widgets.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:get_it/get_it.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';

// JayFmPlayerService get audioPlayerService =>
//     GetIt.instance<JayFmPlayerService>();

// class NowPlayingPage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, AppState>(
//         converter: (store) => store.state,
//         builder: (context, state) {
//           return SharedScaffold(
//             state: state,
//             context: context,
//             appBar: AppBar(
//               backgroundColor: state.colors.mainBackgroundColor,
//               iconTheme:
//                   IconThemeData(color: state.colors.textTheme.bodyText1.color),
//               title: Text("Now Playing"),
//             ),
//             body: Container(
//               color: state.colors.mainBackgroundColor,
//               child: Column(
//                 children: [
//                   Flexible(
//                       flex: 3,
//                       child: StreamBuilder<SequenceState>(
//                           stream: audioPlayerService
//                               .audioPlayer.sequenceStateStream,
//                           builder: (context, snapshot) {
//                             if (snapshot.data == null)
//                               return Center(child: CircularProgressIndicator());

//                             return Container(
//                               child: CachedNetworkImage(
//                                 imageUrl:
//                                     snapshot.data.currentSource.tag.artwork,
//                                 fit: BoxFit.fill,
//                                 placeholder: (context, url) {
//                                   return Image.asset(
//                                       'assets/images/about-you-placeholder.jpg',
//                                       fit: BoxFit.fill);
//                                 },
//                               ),
//                             );
//                           })),
//                   Flexible(
//                       flex: 3,
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             StreamBuilder<Duration>(
//                                 stream: audioPlayerService
//                                     .audioPlayer.durationStream,
//                                 builder: (context, snapshot) {
//                                   final duration =
//                                       snapshot.data ?? Duration.zero;
//                                   return StreamBuilder<PositionData>(
//                                       stream: Rx.combineLatest2<Duration,
//                                               Duration, PositionData>(
//                                           audioPlayerService
//                                               .audioPlayer.positionStream,
//                                           audioPlayerService.audioPlayer
//                                               .bufferedPositionStream,
//                                           (position, bufferedPosition) =>
//                                               PositionData(
//                                                   position, bufferedPosition)),
//                                       builder: (context, snapshot) {
//                                         final positionData = snapshot.data ??
//                                             PositionData(
//                                                 Duration.zero, Duration.zero);
//                                         var position = positionData.position ??
//                                             Duration.zero;
//                                         if (position > duration) {
//                                           position = duration;
//                                         }
//                                         var bufferedPosition =
//                                             positionData.bufferedPosition ??
//                                                 Duration.zero;
//                                         if (bufferedPosition > duration) {
//                                           bufferedPosition = duration;
//                                         }
//                                         return SeekBar(
//                                           duration: duration,
//                                           position: position,
//                                           bufferedPosition: bufferedPosition,
//                                           state: state,
//                                           onChangeEnd: (newPosition) {
//                                             // audioPlayerService.audioPlayer
//                                             //     .seek(newPosition);
//                                           },
//                                         );
//                                       });
//                                 }),
//                             Padding(padding: EdgeInsets.only(top: 10)),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 32.0),
//                               child: playerRow(state),
//                             ),
//                             Padding(padding: EdgeInsets.only(top: 30)),
//                             statusRow(state),
//                             Spacer()
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
