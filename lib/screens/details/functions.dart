import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

const String FEED_URL =
     '';

Future<RssFeed> loadFeed(String feedUrl) async {
  print("Starting to load feed");
  try {
    final client = http.Client();
    final response = await client.get(feedUrl);
    return RssFeed.parse(response.body);
  } catch (e) {
    print(e);
  }
  return null;
}