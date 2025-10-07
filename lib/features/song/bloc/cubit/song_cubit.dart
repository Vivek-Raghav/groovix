// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:groovix/features/song/bloc/state/song_state.dart';
import 'package:groovix/features/song/domain/usecase/upload_song_uc.dart';
import 'package:groovix/features/song/song_index.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit({required this.uploadSongUc}) : super(SongInitial());

  final UploadSongUc uploadSongUc;

  Future<void> uploadSong(UploadSongModel uploadSongModel) async {
    emit(SongLoading());
    final result = await uploadSongUc.call(uploadSongModel);
    result.fold((failure) => emit(SongFailure(error: failure.toString())),
        (success) => emit(SongSuccess(uploadSongResponse: success)));
  }
}
