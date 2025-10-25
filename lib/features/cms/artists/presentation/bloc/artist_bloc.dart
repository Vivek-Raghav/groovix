import 'package:groovix/features/cms/cms_index.dart';

// BLoC
class CmsArtistBloc extends Bloc<ArtistEvent, CmsArtistState> {
  final CreateArtistUc _createArtistUc;
  final GetArtistsListUc _getArtistsListUc;
  final GetArtistByIdUc _getArtistByIdUc;
  final UpdateArtistUc _updateArtistUc;
  final DeleteArtistUc _deleteArtistUc;

  CmsArtistBloc({
    required CreateArtistUc createArtistUc,
    required GetArtistsListUc getArtistsListUc,
    required GetArtistByIdUc getArtistByIdUc,
    required UpdateArtistUc updateArtistUc,
    required DeleteArtistUc deleteArtistUc,
  })  : _createArtistUc = createArtistUc,
        _getArtistsListUc = getArtistsListUc,
        _getArtistByIdUc = getArtistByIdUc,
        _updateArtistUc = updateArtistUc,
        _deleteArtistUc = deleteArtistUc,
        super(CmsArtistInitial()) {
    on<FetchArtistsList>(_onFetchArtistsList);
    on<GetArtistById>(_onGetArtistById);
    on<CreateArtist>(_onCreateArtist);
    on<UpdateArtist>(_onUpdateArtist);
    on<DeleteArtist>(_onDeleteArtist);
  }

  Future<void> _onFetchArtistsList(
      FetchArtistsList event, Emitter<CmsArtistState> emit) async {
    emit(CmsArtistLoading());

    final result = await _getArtistsListUc(event.artistsQueryModel);
    result.fold(
      (failure) => emit(CmsArtistError(_mapFailureToMessage(failure))),
      (response) => emit(CmsArtistLoaded(response.artists)),
    );
  }

  Future<void> _onGetArtistById(
      GetArtistById event, Emitter<CmsArtistState> emit) async {
    emit(CmsArtistLoading());

    final result = await _getArtistByIdUc(event.artistId);
    result.fold(
      (failure) => emit(CmsArtistError(_mapFailureToMessage(failure))),
      (artist) => emit(CmsArtistLoaded([artist])),
    );
  }

  Future<void> _onCreateArtist(
      CreateArtist event, Emitter<CmsArtistState> emit) async {
    emit(CreateArtistLoading());

    final result = await _createArtistUc(event.artistParams);
    result.fold(
      (failure) =>
          emit(CreateArtistFailure(error: _mapFailureToMessage(failure))),
      (artist) => emit(CreateArtistSuccess(artist: artist)),
    );
  }

  Future<void> _onUpdateArtist(
      UpdateArtist event, Emitter<CmsArtistState> emit) async {
    emit(UpdateArtistLoading());

    final params = UpdateArtistParams(
      artistId: event.artistId,
      update: event.update,
    );

    final result = await _updateArtistUc(params);
    result.fold(
      (failure) =>
          emit(UpdateArtistFailure(error: _mapFailureToMessage(failure))),
      (artist) {
        emit(UpdateArtistSuccess(artist));
        add(FetchArtistsList(ArtistsQueryModel(page: 1, size: 10)));
      },
    );
  }

  Future<void> _onDeleteArtist(
      DeleteArtist event, Emitter<CmsArtistState> emit) async {
    emit(ArtistDeletedLoading());

    final result = await _deleteArtistUc(event.artistId);
    result.fold(
      (failure) => emit(ArtistDeletedError(_mapFailureToMessage(failure))),
      (response) => emit(ArtistDeleted(event.artistId)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error: ${failure.toString()}';
      case GeneralFailure:
        return 'Error: ${failure.toString()}';
      default:
        return 'Unexpected error: ${failure.toString()}';
    }
  }
}
