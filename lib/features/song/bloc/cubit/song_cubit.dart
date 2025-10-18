import 'package:groovix/features/song/song_index.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit({required this.songListUc}) : super(SongInitial());

  final SongListUc songListUc;

  Future<void> getSongList(SongsQueryModel songPaginationModel) async {
    emit(SongListLoading());
    final result = await songListUc.call(songPaginationModel);
    result.fold((failure) => emit(SongListFailure(error: failure.toString())),
        (success) => emit(SongListSuccess(songsListResponse: success)));
  }
}
