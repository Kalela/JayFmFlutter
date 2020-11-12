class Podcast {
  String name;
  String url;
  String description;
  bool isCastbox;
  bool isSaved;

  Podcast({this.name, this.url, this.isCastbox, this.description = "No description"});
}