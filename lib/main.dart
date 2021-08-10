// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:infinite_listview/infinite_listview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(            
      title: 'Startup Name Generator',            
      home: InfinitePrizeList()
    );
  }
}

class InfinitePrizeList extends StatefulWidget {
  const InfinitePrizeList({ Key? key }) : super(key: key);

  @override
  _InfinitePrizeListState createState() => _InfinitePrizeListState();
}

class _InfinitePrizeListState extends State<InfinitePrizeList> {
  final List<String> _prizes = ['Prize 1', 'Prize 2', 'Prize 3', 'Prize 4', 'Prize 5'];
  // Map<String, String> _prizeMap = {'prize_id_1': 'Prize 1', 'prize_id_2': 'Prize 2', 'prize_id_3': 'Prize 3'};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _selectedFont = const TextStyle(fontSize: 18.0, backgroundColor: Colors.yellow);

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
      child: _buildList()
    );
  }

  Widget _buildList() {
    return Container( 
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(400, 50, 400, 50),
      child: InfiniteListView.builder(
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
}



class PrizeList extends StatefulWidget {
  const PrizeList({ Key? key }) : super(key: key);

  @override
  _PrizeListState createState() => _PrizeListState();
}

class _PrizeListState extends State<PrizeList> {
  final List<String> _prizes = ['Prize 1', 'Prize 2', 'Prize 3', 'Prize 4', 'Prize 5'];
  // Map<String, String> _prizeMap = {'prize_id_1': 'Prize 1', 'prize_id_2': 'Prize 2', 'prize_id_3': 'Prize 3'};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildOuterContainer(),
    );
  }

  Widget _buildOuterContainer() {
    return Container(
      color: Colors.red[600],
      margin: const EdgeInsets.all(50),
      child: _buildList()
    );
  }

  Widget _buildList() {
    return Container( 
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(500, 50, 500, 50),
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          var index = i ~/ 2; /*3*/
          while (index >= _prizes.length) {
            index -= _prizes.length;
          }
          return _buildRow(_prizes[index]);
        })
      );
    }

  Widget _buildRow(String word) {
    return ListTile(
      title: Text(
        word,
        style: _biggerFont,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({ Key? key }) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}