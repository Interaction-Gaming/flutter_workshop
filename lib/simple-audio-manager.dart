import 'dart:developer';
import 'dart:html';

import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  AudioPlayer bgmAudioPlayer = AudioPlayer();
  AudioCache audioCache = new AudioCache();
  Map<String, AudioPlayer> _audioPlayers = Map();
  double masterVolume = 1.0;

  AudioManager() { }

  AudioManager._init() {
    log('Private init');
  }

  static Future<AudioManager> init() async {

    var component = AudioManager._init();
    await component.initialize();
    return component;
  }
  Future initialize() async {
    _audioPlayers['bgm'] =
        await playLocalAsset("sfx/bensound-jazzyfrenchy.mp3");
  }

  Future playLocalAsset(String fileName) async {
    if ( _audioPlayers.containsKey(fileName)) { 
      var player = _audioPlayers.remove(fileName);
      player!.stop();
      player.release();

    }
    _audioPlayers[fileName] = await _playLocalAsset(fileName);
  }

  Future<AudioPlayer> _playLocalAsset(String fileName) async {
    return audioCache.play(fileName, volume: masterVolume);
  }

  void setVolume(double volume) {
    masterVolume = volume;

    _audioPlayers.forEach((key, value) {
      value.setVolume(masterVolume);
    });
  }
}