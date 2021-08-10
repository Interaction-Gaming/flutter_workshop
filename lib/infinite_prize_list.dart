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

  InfiniteScrollController _scrollController = InfiniteScrollController(initialScrollOffset: SCROLL_OFFSET, );

  final List<String> _prizes = [
    'Prize 1',
    'Prize 2',
    'Prize 3',
    'Prize 4',
    'Prize 5'
  ];
  Color color = Colors.red;

  // Map<String, String> _prizeMap = {'prize_id_1': 'Prize 1', 'prize_id_2': 'Prize 2', 'prize_id_3': 'Prize 3'};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // final _selectedFont =
  //     const TextStyle(fontSize: 18.0, backgroundColor: Colors.yellow);

  // @override
  // void initState() {
  //   _scrollController = InfiniteScrollController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final container = _buildOuterContainer();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Spin to Win'),
        ),
        body: Column(children: [
          Row(children: [_buildButton(1), _buildButton(2),_buildButton(3),_buildButton(4),_buildButton(5)]), container]));
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
          return _buildRow(_prizes[index], i);
        });

    log('list view: ' + infiniteListView.toString());
    log('list scroll controller: ' + infiniteListView.controller.toString());
    log('sc: ' + _scrollController.toString());
    // infiniteListView.controller?.animateTo(3, duration: Duration(minutes: 1), curve: Curves.bounceOut);

    return Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        height: 500,
        child: infiniteListView);
  }

  Widget _buildRow(String word, int location) {
    return ListTile(
      // tileColor: location == 3 ? Colors.yellow[600] : Colors.lightBlue[50],
      // selectedTileColor: Colors.yellow,
      title: Text(
        word,
        style: _biggerFont,
        textAlign: TextAlign.center
      ),
    );
  }

  Widget _buildButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blue,
      ),
      onPressed: () {
        // scrollController?.jumpTo(4);
        // log(color.toString());
        if (_scrollController.offset == SCROLL_OFFSET) {
          setState(() {
            color = Colors
                .primaries[math.Random().nextInt(Colors.primaries.length)];
          });

          _spin(index-1);

        } else {
          setState(() {
            color = Colors.red;
          });
          _scrollController.jumpTo(SCROLL_OFFSET);
        }
        log('offset:' + _scrollController.offset.toString());

        // log(scrollController.toString());
        // scrollController.animateTo(3,1)
      },
      child: Text('Prize' + index.toString()),
    );
  }

  _spin(int prizeIndex) {
    log('Spin to index' + prizeIndex.toString());

    const preSpinOffset = -2000.0 + SCROLL_OFFSET;
    final destinationOffset = preSpinOffset - 500.0 + (prizeIndex * 100);

    log('Destination Offset' + destinationOffset.toString());
          // final newOffset =
          //     2000.0 + math.Random().nextInt(_prizes.length * 10 * 30);
          _scrollController.animateTo(destinationOffset,
              duration: Duration(seconds: 3), curve: Curves.linear);
  }
}
