import 'package:groovix/core/shared/model/song_model.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerManager {
  static final MusicPlayerManager _instance = MusicPlayerManager._internal();
  factory MusicPlayerManager() => _instance;
  MusicPlayerManager._internal();

  final _player = AudioPlayer();
  SongModel? _currentSong;

  Future<void> loadAndPlay(SongModel song) async {
    _currentSong = song;
    await _player.setAudioSource(AudioSource.uri(Uri.parse(song.songUrl)));
    _player.play();
  }

  Future<void> pause() async => _player.pause();
  Future<void> resume() async => _player.play();
  Future<void> seek(Duration position) async => _player.seek(position);
  Future<void> stop() async => _player.stop();

  Duration get duration => _player.duration ?? Duration.zero;
  SongModel? get currentSong => _currentSong;

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
}
