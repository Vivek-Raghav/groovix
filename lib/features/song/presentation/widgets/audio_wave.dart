import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:groovix/core/theme/app_theme.dart';

class AudioWave extends StatefulWidget {
  const AudioWave({super.key, required this.path});
  final String path;

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController _playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  void initializePlayer() {
    _playerController.onCompletion.listen((_) async {
      await _playerController.stopPlayer();
      await _playerController.preparePlayer(path: widget.path);
      setState(() {});
    });
    _playerController.preparePlayer(path: widget.path);
  }

  Future<void> playAndPause() async {
    final playerState = _playerController.playerState;

    if (playerState.isPlaying) {
      await _playerController.pausePlayer();
    } else if (playerState.isStopped) {
      await _playerController.startPlayer();
    } else {
      await _playerController.startPlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: playAndPause,
            icon: Icon(_playerController.playerState.isPlaying
                ? CupertinoIcons.pause_solid
                : CupertinoIcons.play_arrow_solid),
            color: _playerController.playerState.isPlaying
                ? Theme.of(context).primaryColor
                : ThemeColors.clrGreen),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 80),
            playerController: _playerController,
            playerWaveStyle: PlayerWaveStyle(
              seekLineColor: ThemeColors.grey,
              fixedWaveColor: ThemeColors.grey,
              liveWaveColor: Theme.of(context).primaryColor,
              waveThickness: 2,
            ),
          ),
        )
      ],
    );
  }
}
