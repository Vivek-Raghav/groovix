import 'package:groovix/features/song/song_index.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit({required this.uploadSongUc, required this.songListUc})
      : super(SongInitial());

  final UploadSongUc uploadSongUc;
  final SongListUc songListUc;

  Future<void> uploadSong(UploadSongModel uploadSongModel) async {
    emit(UploadSongLoading());
    final result = await uploadSongUc.call(uploadSongModel);
    result.fold((failure) => emit(UploadSongFailure(error: failure.toString())),
        (success) => emit(UploadSongSuccess(uploadSongResponse: success)));
  }

  Future<void> getSongList(SongsQueryModel songPaginationModel) async {
    emit(SongListLoading());
    final result = await songListUc.call(songPaginationModel);
    result.fold((failure) => emit(SongListFailure(error: failure.toString())),
        (success) => emit(SongListSuccess(songsListResponse: success)));
  }
}
