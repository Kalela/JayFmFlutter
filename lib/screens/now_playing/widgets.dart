import 'dart:math';

import 'package:JayFm/models/app_state.dart';
import 'package:JayFm/models/audio_meta_data.dart';
import 'package:JayFm/res/values.dart';
import 'package:JayFm/services/player_service/player_service.dart';
import 'package:JayFm/util/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

JayFmPlayerService get audioPlayerService =>
    GetIt.instance<JayFmPlayerService>();

Widget playerRow(AppState state) {
  final _iconSize2 = 50.0;
  final _playButtonDiameter = 100.0;
  return StreamBuilder<SequenceState>(
      stream: audioPlayerService.audioPlayer.sequenceStateStream,
      builder: (context, sequenceSnapshot) {
        final sequenceState = sequenceSnapshot.data;
        if (sequenceState?.sequence?.isEmpty ?? true) return SizedBox();
        final metadata = sequenceState.currentSource.tag as AudioMetadata;
        return StreamBuilder<PlayerState>(
            stream: audioPlayerService.audioPlayer.playerStateStream,
            builder: (context, playerStateSnapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.skip_previous_outlined,
                        color: state.colors.mainButtonsColor,
                        size: _iconSize2,
                      )),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: _playButtonDiameter,
                      width: _playButtonDiameter,
                      child: RawMaterialButton(
                        onPressed:
                            metadata != null && playerStateSnapshot.data != null
                                ? playerStateSnapshot.data.playing
                                    ? audioPlayerService.audioPlayer.pause
                                    : audioPlayerService.audioPlayer.play
                                : null,
                        fillColor: state.colors.mainButtonsColor,
                        shape: CircleBorder(),
                        elevation: 10.0,
                        child: Center(
                          child: PlayerStateIconBuilder(
                              _playButtonDiameter, metadata, state),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.skip_next_outlined,
                        color: state.colors.mainButtonsColor,
                        size: _iconSize2,
                      )),
                ],
              );
            });
      });
}

Widget statusRow(AppState state) {
  return StreamBuilder<SequenceState>(
      stream: audioPlayerService.audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) return SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              snapshot.data.currentSource.tag.title,
              style: defaultTextStyle(state),
            ),
            Text(
              snapshot.data.currentSource.tag.presenters,
              style: defaultTextStyle(state),
            )
          ],
        );
      });
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;
  final AppState state;

  SeekBar({
    @required this.duration,
    @required this.position,
    @required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    @required this.state,
  });

  @override
  _SeekBarState createState() => _SeekBarState(state);
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;
  SliderThemeData _sliderThemeData;
  final AppState state;

  _SeekBarState(this.state);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: defaultTextStyle(state)),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {}
}
