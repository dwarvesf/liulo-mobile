import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liulo/model/event.dart';
import 'package:liulo/screen/list_event/list_event_presenter.dart';
import 'package:liulo/screen/list_topic/list_topic_screen.dart';
import 'package:liulo/utils/shimmer.dart';
import 'package:liulo/utils/token_util.dart';

class ListEventScreen extends StatefulWidget {
  ListEventScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListEventScreenState createState() => new _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen>
    implements ListEventScreenContract {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Event> listEvent = new List();
  ListEventPresenter listEventPresenter;
  bool isLoading = true;

  _ListEventScreenState() {
    listEventPresenter = new ListEventPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);

    var token = await TokenUtil.getToken();
    if (token.isNotEmpty) {
      listEventPresenter.getListEvent(token);
    }

    return null;
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void _onTapItem(BuildContext context, Event event) {
    replaceToListTopicScreen(event);
  }

  void replaceToListTopicScreen(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ListTopicScreen(title: 'Manage Topic', event: event)),
    );
  }

  Column _buildItem(int position) {
    return Column(
      children: <Widget>[
        Divider(height: 5.0),
        ListTile(
          title: Text(
            '${listEvent[position].code} | ${listEvent[position].name}',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
            ),
          ),
          subtitle: Text(
            '${listEvent[position].description}',
            style: new TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          onTap: () => _onTapItem(context, listEvent[position]),
        ),
      ],
    );
  }

  ListView _buildList(context) {
    return new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: listEvent.length,
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (context, position) {
          return _buildItem(position);
        });
  }

  Scaffold buildShimmer() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: [0, 1, 2, 3, 4, 5, 6]
                .map((_) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48.0,
                            height: 48.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return buildShimmer();
    } else {
      return new Scaffold(
        appBar: new AppBar(title: new Text(widget.title)),
        body: RefreshIndicator(
          key: refreshKey,
          child: _buildList(context),
          onRefresh: refreshList,
        ),
      );
    }
  }

  @override
  void onGetDataSuccess(List<Event> items) {
    setLoading(false);
    setState(() {
      this.listEvent = items;
    });
  }

  @override
  void onGetDataFailed(String error) {
    setLoading(false);
  }
}
