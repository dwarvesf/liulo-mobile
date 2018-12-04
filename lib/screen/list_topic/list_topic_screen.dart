import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:liulo/model/event.dart';
import 'package:liulo/model/topic.dart';
import 'package:liulo/screen/list_question/list_question_screen.dart';
import 'package:liulo/screen/list_topic/list_topic_presenter.dart';
import 'package:liulo/utils/easy_listview.dart';
import 'package:liulo/utils/shimmer.dart';
import 'package:liulo/utils/token_util.dart';
import 'package:liulo/utils/view_util.dart';

class ListTopicScreen extends StatefulWidget {
  ListTopicScreen({Key key, this.title, this.event}) : super(key: key);

  final String title;
  final Event event;

  @override
  _ListTopicScreenState createState() => new _ListTopicScreenState();
}

class _ListTopicScreenState extends State<ListTopicScreen>
    implements ListTopicContract {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Topic> listTopic = new List();
  ListTopicPresenter listTopicPresenter;
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController speakerController = new TextEditingController();

  _ListTopicScreenState() {
    listTopicPresenter = new ListTopicPresenter(this);
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
        listTopicPresenter.getListTopic(token, widget.event.id);
      }
    }

    return null;
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void replaceToListQuestionScreen(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ListQuestionScreen(title: 'Manage Question', topic: topic)),
    );
  }

  void _onTapItem(BuildContext context, Topic topic) {
    replaceToListQuestionScreen(topic);
  }

  Column _buildItem(int position) {
    return Column(
      children: <Widget>[
        Divider(height: 5.0),
        ListTile(
          title: Text(
            '${listTopic[position].name}',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
            ),
          ),
          subtitle: Text(
            '${listTopic[position].description}',
            style: new TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          onTap: () => _onTapItem(context, listTopic[position]),
        ),
      ],
    );
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
                .map((_) =>
                Padding(
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
      return buildLisView();
    }
  }

  Scaffold buildLisView() {
    return Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: RefreshIndicator(
        key: refreshKey,
        child: EasyListView(
            headerBuilder: ((context) =>
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                        child: TextFormField(
                          decoration: new InputDecoration(hintText: "Name"),
                          controller: nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Name';
                            }
                          },
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                        child: TextFormField(
                          controller: descController,
                          decoration:
                          new InputDecoration(hintText: "Description"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Description';
                            }
                          },
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                        child: TextFormField(
                          decoration:
                          new InputDecoration(hintText: "Speaker Name"),
                          controller: speakerController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Speaker Name';
                            }
                          },
                        ),
                      ),
                      Center(
                        child: new ButtonTheme(
                          minWidth: 150.0,
                          height: 36.0,
                          child: RaisedButton(
                            textColor: Colors.white,
                            onPressed: onCreateClick,
                            color: Colors.blue,
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              "Create Topic",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            itemCount: listTopic.length,

            itemBuilder: (context, position) {
              return _buildItem(position);
            }),
        onRefresh: refreshList,
      ),

    );
  }

  Future<Null> onCreateClick() async {
    var token = await TokenUtil.getToken();
    if (token.isNotEmpty) {
      if (_formKey.currentState.validate()) {
        ViewUtil.hideKeyboard(context);

        var connectivityResult = await (new Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          ViewUtil.showDialogConnection(context);
        } else {
          listTopicPresenter.createTopic(
              nameController.text, descController.text, speakerController.text,
              widget.event.id, token);
        }
      }
    }

    return null;
  }

  @override
  void onGetDataSuccess(List<Topic> items) {
    setLoading(false);
    setState(() {
      this.listTopic = items;
    });
  }

  @override
  void onGetDataFailed(String error) {
    setLoading(false);
  }

  @override
  void onCreateFailed(String error) {
  }

  @override
  void onCreateSuccess(Topic topic) {
    refreshList();
  }
}
