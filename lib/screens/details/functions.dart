import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

Future<RssFeed?> loadFeed(String feedUrl) async {
  try {
    final client = http.Client();
    final response = await client.get(Uri.parse(feedUrl));
    return RssFeed.parse(response.body);
  } catch (e) {
    print(e);
  }
  return null;
}

/// Get presenters from title list aqcuired by splitting rss feed title
String getPresenters(List<String> splitTitle) {
  String presenters;
  try {
    presenters = splitTitle[1];
  } catch (e) {
    presenters = "Jay Fm";
  }

  return presenters;
}
