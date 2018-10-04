import 'package:flutter/material.dart';
import 'package:liulo/models/question.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class QuestionListItem extends StatelessWidget {
  final Question item;
  final Function onUpVotePressed;
  final Function onUnVotePressed;

  const QuestionListItem({
    Key key,
    @required this.item,
    @required this.onUpVotePressed,
    @required this.onUnVotePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 128.0,
        child: Card(
          color: Colors.primaries[item.id % Colors.primaries.length],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    color: item.isVoted ? Colors.orange : Colors.black,
                    icon: const Icon(Icons.thumb_up),
                    onPressed: item.isVoted ? onUnVotePressed : onUpVotePressed,
                    tooltip: item.isVoted ? 'Un Vote' : 'Up Vote',
                  ),
                  new Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
