import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jay_fm_flutter/models/app_state.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/screens/details/functions.dart';
import 'package:jay_fm_flutter/util/global_widgets.dart';
import 'package:webfeed/domain/rss_feed.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final String title;
  final String feedUrl;

  DetailsPage({this.title, this.feedUrl});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        // TODO: Move app colors to global
        GlobalAppColors colors = state.selectedTheme == SelectedTheme.LIGHT
            ? GlobalAppColors(
                mainBackgroundColor: jayFmBlue,
                mainButtonsColor: jayFmFancyBlack,
                mainIconsColor: jayFmOrange,
                mainTextColor: Colors.black)
            : GlobalAppColors(
                mainBackgroundColor: jayFmFancyBlack,
                mainButtonsColor: Colors.grey,
                mainIconsColor: Colors.blueGrey,
                mainTextColor: Colors.white);

        return SharedScaffold(
          colors: colors,
          context: context,
          state: state,
          appBar: AppBar(
            backgroundColor: jayFmFancyBlack,
            iconTheme: IconThemeData(color: Colors.grey),
            title: Text(title),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 10, right: 9),
            color: colors.mainBackgroundColor,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                      height: 700,
                      child: FutureBuilder<RssFeed>(
                        future: loadFeed(feedUrl),
                        builder: (context, snapshot) {
                          // print("I am here");
                          // RssFeed feed = await loadFeed();
                          // print("The feed is $feed");
                          // print("The feed categories ${feed.items.length}");
                          // for (RssItem item in feed.items) {
                          //   // print("Description: ${item.description}");
                          //   print("Author: ${item.author}");
                          //   print("Categories: ${item.categories}");
                          //   print("Link: ${item.link}");
                          //   print("Title: ${item.title}");
                          //   // break;
                          // }
                          if (!snapshot.hasData ||
                              snapshot.connectionState !=
                                  ConnectionState.done) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                              itemCount: snapshot.data.items.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  title: Text(
                                    "${snapshot.data.items[i].title}",
                                    style:
                                        TextStyle(color: colors.mainTextColor),
                                  ),
                                  trailing: Icon(Icons.play_arrow, color: colors.mainIconsColor, size: 40,),
                                );
                              });
                        },
                      ))
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 70,
            color: Colors.black,
            child: nowPlayingFooter(jayFmMaroon, Colors.grey, jayFmOrange),
          ),
        );
      },
    );
  }
}
