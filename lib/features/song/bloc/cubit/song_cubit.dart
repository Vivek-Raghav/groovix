import 'package:groovix/features/song/song_index.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit(
      {required this.uploadSongUc,
      required this.songListUc,
      required this.songFlagsUc})
      : super(SongInitial());

  final UploadSongUc uploadSongUc;
  final SongListUc songListUc;
  final SongFlagsUc songFlagsUc;

  Future<void> uploadSong(UploadSongModel uploadSongModel) async {
    emit(SongLoading());
    final result = await uploadSongUc.call(uploadSongModel);
    result.fold((failure) => emit(SongFailure(error: failure.toString())),
        (success) => emit(SongSuccess(uploadSongResponse: success)));
  }

  Future<void> getSongList(SongsQueryModel songPaginationModel) async {
    emit(SongListLoading());
    final result = await songListUc.call(songPaginationModel);
    result.fold((failure) => emit(SongListFailure(error: failure.toString())),
        (success) => emit(SongListSuccess(songsListResponse: success)));
  }

  // In SongCubit
  Future<bool> updateSongFlags(SongFlagParams songFlagParams) async {
    emit(SongFlagsLoading());
    final result = await songFlagsUc.call(songFlagParams);
    return result.fold((failure) {
      emit(SongFlagsFailure(error: failure.toString()));
      return false;
    }, (success) {
      emit(SongFlagsSuccess(songFlagsResponse: success));
      return true;
    });
  }

  Future<void> getSongFlags(SongFlagParams songFlagParams) async {
    emit(SongFlagsLoading());
    final result = await songFlagsUc.call(songFlagParams);
    return result.fold((failure) {
      emit(SongFlagsFailure(error: failure.toString()));
    }, (success) {
      Future.delayed(const Duration(seconds: 2), () {
        emit(SongFlagsSuccess(songFlagsResponse: success));
      });
    });
  }
}
