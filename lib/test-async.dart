import 'package:flutter/material.dart';
import 'package:tpir_wheel/simple-audio-manager.dart';

class AsyncScroller extends StatefulWidget {
  const AsyncScroller({Key? key}) : super(key: key);

  @override
  _AsyncScrollerState createState() => _AsyncScrollerState();
}

class _AsyncScrollerState extends State<AsyncScroller> {
  var _audioManager;

  create() async {
    _audioManager = await AudioManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: create(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return TextButton(
                onPressed: () => {_audioManager.setVolume(0.0)},
                child: Text('Mute BG'));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
