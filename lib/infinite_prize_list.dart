import 'package:infinite_listview/infinite_listview.dart';
import 'package:flutter/material.dart';

class InfinitePrizeList extends StatefulWidget {
  const InfinitePrizeList({Key? key}) : super(key: key);

  @override
  _InfinitePrizeListState createState() => _InfinitePrizeListState();
}

class _InfinitePrizeListState extends State<InfinitePrizeList> {
  final List<String> _prizes = [
    'Prize 1',
    'Prize 2',
    'Prize 3',
    'Prize 4',
    'Prize 5'
  ];
  // Map<String, String> _prizeMap = {'prize_id_1': 'Prize 1', 'prize_id_2': 'Prize 2', 'prize_id_3': 'Prize 3'};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _selectedFont =
      const TextStyle(fontSize: 18.0, backgroundColor: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin to Win'),
      ),
      body: _buildOuterContainer(),
    );
  }

  Widget _buildOuterContainer() {
    return Container(
        color: Colors.red[600],
        margin: const EdgeInsets.all(50),
        child: _buildList());
  }

  /*
    Widget _buildList() {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        height: 400,
        child: Column(children: [_buildButton(), _buildButton()])
    );
  }
  */

  Widget _buildList() {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        height: 400,
        child:
          InfiniteListView.builder(
              padding: const EdgeInsets.all(16.0),
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
              })
        );
  }

  Widget _buildRow(String word, int location) {
    return ListTile(
      // tileColor: location == 3 ? Colors.yellow[600] : Colors.lightBlue[50],
      selectedTileColor: Colors.yellow,
      title: Text(
        word,
        style: _biggerFont,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blue,
      ),
      onPressed: () {},
      child: Text('TextButton'),
    );
  }
}
