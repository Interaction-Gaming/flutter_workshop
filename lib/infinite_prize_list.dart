import 'dart:developer';
import 'dart:math' as math;

import 'package:infinite_listview/infinite_listview.dart';
import 'package:flutter/material.dart';

class InfinitePrizeList extends StatefulWidget {
  const InfinitePrizeList({Key? key}) : super(key: key);

  @override
  _InfinitePrizeListState createState() => _InfinitePrizeListState();
}

class _InfinitePrizeListState extends State<InfinitePrizeList> {
  static const double SCROLL_OFFSET = -225.0;
  static const double INITIAL_SPIN_OFFSET = -2000.0;

  InfiniteScrollController _scrollController = InfiniteScrollController(
    initialScrollOffset: SCROLL_OFFSET,
  );
  double _previousOffset = 0;

  final List<String> _prizes = [
    'Prize 1',
    'Prize 2',
    'Prize 3',
    'Prize 4',
    'Prize 5'
  ];
  Color color = Colors.red;

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final container = _buildOuterContainer();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Spin to Win'),
        ),
        body: Column(children: [
          Row(children: [
            _buildButton(1),
            _buildButton(2),
            _buildButton(3),
            _buildButton(4),
            _buildButton(5),
            _resetButton()
          ]),
          container
        ]));
  }

  Widget _buildOuterContainer() {
    return Container(
        color: color, margin: const EdgeInsets.all(50), child: _buildList());
  }

  Widget _buildList() {
    final infiniteListView = InfiniteListView.builder(
        padding: const EdgeInsets.all(16.0),
        controller: _scrollController,
        itemExtent: 50,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          var index = i ~/ 2; /*3*/
          while (index >= _prizes.length) {
            index -= _prizes.length;
          }
          while (index < 0) {
            index += _prizes.length;
          }
          log('index: ' + index.toString());
          return _buildRow(_prizes[index], index);
        });

    return Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        height: 500,
        child: infiniteListView);
  }

  Widget _buildRow(String word, int location) {
    return Container(
      child: ListTile(
        title: Text(word, style: _biggerFont, textAlign: TextAlign.center),
      ),
      // color: (location + 1).isEven ? Colors.grey : Colors.white,
    );
  }

  Widget _resetButton() {
    return TextButton(onPressed: _reset, child: Text("Reset"));
  }

  Widget _buildButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blue,
      ),
      onPressed: () {
        _spin(index - 1);
        log('offset:' + _scrollController.offset.toString());
      },
      child: Text('Prize ' + index.toString()),
    );
  }

  _spin(int prizeIndex) {
    setState(() {
      color = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    });
    if (_previousOffset != 0.0) {
      _scrollController.jumpTo(SCROLL_OFFSET);
    }
    final adjustment = -500.0 + (prizeIndex * 100);
    final destinationOffset = INITIAL_SPIN_OFFSET + SCROLL_OFFSET + adjustment;
    log(_previousOffset.toString());
    setState(() {
      _previousOffset = adjustment;
    });
    _scrollController.animateTo(destinationOffset,
        duration: Duration(seconds: 3), curve: Curves.linear);
  }

  void _reset() {
    setState(() {
      color = Colors.red;
      _previousOffset = 0;
    });
    _scrollController.jumpTo(SCROLL_OFFSET);
  }
}
