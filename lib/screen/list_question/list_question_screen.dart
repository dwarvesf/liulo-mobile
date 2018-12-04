import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:liulo/model/question.dart';
import 'package:liulo/model/topic.dart';
import 'package:liulo/screen/list_question/list_question_presenter.dart';
import 'package:liulo/utils/shimmer.dart';
import 'package:liulo/utils/token_util.dart';
import 'package:liulo/utils/view_util.dart';

class ListQuestionScreen extends StatefulWidget {
  ListQuestionScreen({Key key, this.title, this.topic}) : super(key: key);

  final String title;
  final Topic topic;
  @override
  _ListQuestionScreenState createState() => new _ListQuestionScreenState();
}

class _ListQuestionScreenState extends State<ListQuestionScreen>
    implements ListQuestionScreenContract {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Question> listQuestion = new List();
  ListQuestionPresenter listQuestionPresenter;
  bool isLoading = true;

  _ListQuestionScreenState() {
    listQuestionPresenter = new ListQuestionPresenter(this);
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
      var connectivityResult = await (new Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        ViewUtil.showDialogConnection(context);
        setLoading(false);
      } else {
        listQuestionPresenter.getListTopic(token, widget.topic.id);
      }
    }

    return null;
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void _onTapItem(BuildContext context, Question question) {
  }

  Column _buildItem(int position) {
    return Column(
      children: <Widget>[
        Divider(height: 5.0),
        ListTile(
          title: Text(
            '${listQuestion[position].description}',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
            ),
          ),

          leading: Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.check_circle),
                color: ViewUtil.getColorCheckButton(
                    listQuestion[position].status),
                onPressed: () {
                  setState(() {
                    listQuestion[position].status = ViewUtil.getValueCheck(
                        listQuestion[position].status);
                  });
                },
              ),
            ],
          ),
          onTap: () => _onTapItem(context, listQuestion[position]),
        ),
      ],
    );
  }

  ListView _buildList(context) {
    return new ListView.builder(
        itemCount: listQuestion.length,
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
  void onGetDataSuccess(List<Question> items) {
    setLoading(false);
    setState(() {
      this.listQuestion = items;
    });
  }

  @override
  void onGetDataFailed(String error) {
    setLoading(false);
  }
}
