import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class NowPlaying {
  String id;
  final String imageUrl;
  final String title;
  final String presenters;
  final String audioUrl;

  NowPlaying(this.imageUrl, this.title, this.presenters, this.audioUrl,
      [String id])
      : id = id ?? _uuid.v4();

  @override
  String toString() {
    return "Now Playing: id = $id, imageUrl = $imageUrl, title = $title, presenters = $presenters, audioUrl = $audioUrl";
  }
}
