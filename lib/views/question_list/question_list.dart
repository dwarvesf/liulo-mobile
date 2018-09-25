import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/views/common/list_model.dart';
import 'package:liulo/models/question.dart';
import 'package:liulo/views/question_list/question_list_view_model.dart';
import 'package:redux/redux.dart';
import 'question_list_item/index.dart';

class QuestionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, QuestionListViewModel>(
    converter: (Store<AppState> store) => QuestionListViewModel.create(store),
    builder: (BuildContext context, QuestionListViewModel viewModel) => Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: viewModel.items.map((Question item) => _createWidget(item, viewModel.onUpVotePressed)).toList()),
      ),
    ),
  );

  Widget _createWidget(Question item, Function onUpVotePressed) {
    return Row(
      children: [
        FlatButton(
          onPressed: onUpVotePressed(item.id),
          child: Icon(
            Icons.keyboard_arrow_up,
            semanticLabel: "Upvote",
          ),
        ),
        Text(item.description),
      ],
    );
  }
}


class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<Question> _list;
  Question _selectedItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel<Question>(
      listKey: _listKey,
      initialItems: <Question>[Question(id: 0), Question(id: 1), Question(id: 2)],
      removedItemBuilder: _buildRemovedItem,
    );
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return QuestionListItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(Question item, BuildContext context, Animation<double> animation) {
    return QuestionListItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    Question newItem = Question(id: index+1);
    _list.insert(index, newItem);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}