// Project imports:
import 'package:groovix/features/home/home_index.dart';
import 'package:groovix/features/song/domain/models/song_query_model.dart';
import '../../../cms_index.dart';

class CmsSongBloc extends Bloc<SongEvent, CmsSongState> {
  CmsSongBloc(
      {required this.uploadSongUc,
      required this.songListUc,
      required this.updateSongFieldsUc,
      required this.deleteSongUc,
      required this.searchSongUc})
      : super(CmsSongInitial()) {
    on<SearchSongs>(_onSearchSongs);
    on<UpdateSongFields>(_onUpdateSongFields);
    on<DeleteSong>(_onDeleteSong);
    on<UploadSong>(_uploadSong);
    on<FetchSongList>(_loadSongList);
  }

  final UploadSongUc uploadSongUc;
  final SongListUc songListUc;
  final UpdateSongFieldsUseCase updateSongFieldsUc;
  final DeleteSongUc deleteSongUc;
  final SearchSongUc searchSongUc;

  Future<void> _loadSongList(
      FetchSongList event, Emitter<CmsSongState> emit) async {
    emit(CmsSongLoading());
    final response = await songListUc.call(event.songsQueryModel);
    response.fold((failure) => emit(CmsSongError(failure.toString())),
        (response) => emit(CmsSongLoaded(response.songs)));
  }

  Future<void> _uploadSong(UploadSong event, Emitter<CmsSongState> emit) async {
    emit(UploadCmsSongLoading());
    final result = await uploadSongUc.call(event.uploadSongModel);
    result.fold((failure) => emit(UploadSongFailure(error: failure.toString())),
        (success) => emit(UploadSongSuccess(uploadSongResponse: success)));
  }

  Future<void> _onSearchSongs(
      SearchSongs event, Emitter<CmsSongState> emit) async {
    emit(CmsSongLoading());
    final result = await searchSongUc.call(event.query);
    result.fold(
      (failure) => emit(CmsSongError(failure.toString())),
      (songs) => emit(CmsSongLoaded(songs)),
    );
  }

  Future<void> _onUpdateSongFields(
      UpdateSongFields event, Emitter<CmsSongState> emit) async {
    emit(UpdateSongFieldsLoading());
    try {
      final song =
          await updateSongFieldsUc.call(event.songId, event.updateModel);
      emit(UpdateSongFieldsSuccess(song));
    } catch (e) {
      emit(UpdateSongFieldsFailure(error: e.toString()));
    }
  }

  Future<void> _onDeleteSong(
      DeleteSong event, Emitter<CmsSongState> emit) async {
    emit(SongDeletedLoading());
    final result = await deleteSongUc.call(event.songId);
    result.fold(
      (failure) => emit(SongDeletedError(failure.toString())),
      (success) {
        add(FetchSongList(SongsQueryModel(page: 1, size: 100)));
        showToast(title: "Successfully Deleted");
      },
    );
  }
}
