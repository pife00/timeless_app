import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';

final  audio ="../assets/audios/rin.mp3";

class SoundPlayer{

  FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  Future init() async{
    
    await _audioPlayer.openAudioSession();
  }


  Future play() async{
    await _audioPlayer.startPlayer(
      fromURI:audio,  
    );
  }

  Future _stop() async{
    await _audioPlayer.stopPlayer() ;
  }

  Future togglePlaying() async{
    if(_audioPlayer.isStopped){
      await play();
    }else{
      await _stop();  
    }
  }

}