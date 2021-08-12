import 'dart:developer';
import 'dart:math' as math;

import 'package:infinite_listview/infinite_listview.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tpir_wheel/simple-audio-manager.dart';

class InfinitePrizeList extends StatefulWidget {
  const InfinitePrizeList({Key? key}) : super(key: key);

  @override
  _InfinitePrizeListState createState() => _InfinitePrizeListState();
}

class _InfinitePrizeListState extends State<InfinitePrizeList> {
  static const double SCROLL_OFFSET = -200.0;
  static const double INITIAL_SPIN_OFFSET = -2000.0;

  InfiniteScrollController _scrollController = InfiniteScrollController(
    initialScrollOffset: SCROLL_OFFSET,
  );
  AudioManager audioManager = AudioManager();
  double _previousOffset = SCROLL_OFFSET;
  int _previousIndex = 0;
  final List<String> _prizes = [
    'Prizep 1',
    'Prize 2',
    'Prize 3',
    'Prize 4',
    'Prize 5'
  ];
  Color? color = Colors.deepPurple[900];
  bool _isSpinning = false;
  final _biggerFont = const TextStyle(fontSize: 20.0, height: 1);
  @override
  void initState() {
    super.initState();
    audioManager.playLocalAsset("sfx/bensound-jazzyfrenchy.mp3");
  }

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
            _resetButton(),
            _buildAddBackgroundMusicButton(),
            _buildUnmuteButton(),
            _buildMuteButton()
          ]),
          container
        ]));
  }

  Widget _buildOuterContainer() {
    return Container(
      color: color,
      margin: const EdgeInsets.all(50),
      child: _buildList(),
      constraints: BoxConstraints(minWidth: 200, maxWidth: 400),
    );
  }

  Widget _buildList() {
    // audioPlayer.setVolume(0);
    final infiniteListView = InfiniteListView.builder(
        // padding: const EdgeInsets.all(16.0),
        controller: _scrollController,
        itemExtent: 100,
        physics: _isSpinning ? NeverScrollableScrollPhysics() : null,
        itemBuilder: /*1*/ (context, i) {
          // if (i.isOdd) return const Divider(); /*2*/

          var index = i; //i ~/ 2; /*3*/
          while (index >= _prizes.length) {
            index -= _prizes.length;
          }
          while (index < 0) {
            index += _prizes.length;
          }
          log('index: ' + index.toString());
          return _buildRow(_prizes[index], index, i.isEven);
        });

    return Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        height: 500,
        child: infiniteListView);
  }

  Widget _buildRow(String word, int location, bool isEven) {
    return Material(
      child: ListTile(
        title: Center(
            child: Text(word, style: _biggerFont, textAlign: TextAlign.center)),
      ),
      color: isEven ? Colors.purple[200] : Colors.purple[500],
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

  Widget _buildAddBackgroundMusicButton() {
    return TextButton(
        onPressed: () => {audioManager.playLocalAsset("sfx/bensound-jazzyfrenchy.mp3")}, child: Text('Play BG'));
  }

  Widget _buildUnmuteButton() {
    return TextButton(
        onPressed: () => {audioManager.setVolume(1.0)}, child: Text('Unmute BG'));
  }

  Widget _buildMuteButton() {
    return TextButton(
        onPressed: () => {audioManager.setVolume(0.0)}, child: Text('Mute BG'));
  }

  _spin(int prizeIndex) {
    setState(() {
      color = Colors.deepPurple[700];
      _isSpinning = true;
    });
    audioManager.playLocalAsset("sfx/WheelLaunch.mp3");
    final adjustment = -500.0 + (prizeIndex * 100);
    final previousAdjustment =
        -500.0 + ((_prizes.length - _previousIndex) * 100);
    final destinationOffset =
        _previousOffset + previousAdjustment + INITIAL_SPIN_OFFSET + adjustment;
    log(_previousOffset.toString());
    setState(() {
      _previousOffset = destinationOffset;
      _previousIndex = prizeIndex;
    });
    _scrollController.animateTo(destinationOffset,
        duration: Duration(seconds: 3), curve: Curves.linear).then((value) => audioManager.playLocalAsset("sfx/InnerSelect.mp3"));
  }

  void _reset() {
    setState(() {
      color = Colors.deepPurple[900];
      _previousOffset = SCROLL_OFFSET;
      _previousIndex = 0;
      _isSpinning = false;
    });
    _scrollController.jumpTo(SCROLL_OFFSET);
  }
}
