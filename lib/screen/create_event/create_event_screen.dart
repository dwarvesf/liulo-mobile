import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liulo/model/event.dart';
import 'package:liulo/screen/create_event/create_event_presenter.dart';
import 'package:liulo/utils/token_util.dart';
import 'package:liulo/utils/view_util.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateEventScreenState createState() => new _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen>
    implements CreateEventContract {
  CreateEventPresenter createEventPresenter;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _CreateEventScreenState() {
    createEventPresenter = new CreateEventPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  Future<Null> onCreateClick() async {
    var token = await TokenUtil.getToken();
    if (token.isNotEmpty) {
      if (_formKey.currentState.validate()) {
        setLoading(true);
        ViewUtil.hideKeyboard(context);
        createEventPresenter.createEvent(
            nameController.text, descController.text, token);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(title: new Text(widget.title)),
        body: new Stack(
          children: _buildForm(context),
        ));
  }

  List<Widget> _buildForm(BuildContext context) {
    var body = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
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
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: TextFormField(
              controller: descController,
              decoration: new InputDecoration(hintText: "Description"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Description';
                }
              },
            ),
          ),
          Center(
            child: new ButtonTheme(
              minWidth: 150.0,
              height: 36.0,
              child: RaisedButton(
                onPressed: onCreateClick,
                textColor: Colors.white,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Create Event",
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var l = new List<Widget>();
    l.add(body);

    if (isLoading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      l.add(modal);
    }

    return l;
  }

  @override
  void onCreateFailed(String error) {
    setLoading(false);

    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error)));
  }

  @override
  void onCreateSuccess(Event event) {
    setLoading(false);
    scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text("Create Event successfully")));
    Navigator.of(context).pop(true);
  }
}
