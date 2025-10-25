import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovix/features/cms/cms_index.dart';

// Events
abstract class ArtistEvent {}

class LoadArtists extends ArtistEvent {
  final ArtistsQueryModel params;
  LoadArtists(this.params);
}

class GetArtistById extends ArtistEvent {
  final String artistId;
  GetArtistById(this.artistId);
}

class CreateArtist extends ArtistEvent {
  final ArtistParams params;
  CreateArtist(this.params);
}

class UpdateArtist extends ArtistEvent {
  final String artistId;
  final ArtistUpdate update;
  UpdateArtist(this.artistId, this.update);
}

class DeleteArtist extends ArtistEvent {
  final String artistId;
  DeleteArtist(this.artistId);
}

// States
abstract class ArtistState {}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistsLoaded extends ArtistState {
  final ArtistsListResponse response;
  ArtistsLoaded(this.response);
}

class ArtistLoaded extends ArtistState {
  final ArtistModel artist;
  ArtistLoaded(this.artist);
}

class ArtistError extends ArtistState {
  final String message;
  ArtistError(this.message);
}

class ArtistCreated extends ArtistState {
  final ArtistModel artist;
  ArtistCreated(this.artist);
}

class ArtistUpdated extends ArtistState {
  final ArtistModel artist;
  ArtistUpdated(this.artist);
}

class ArtistDeleted extends ArtistState {
  final String artistId;
  ArtistDeleted(this.artistId);
}

// BLoC
class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final CreateArtistUc _createArtistUc;
  final GetArtistsListUc _getArtistsListUc;
  final GetArtistByIdUc _getArtistByIdUc;
  final UpdateArtistUc _updateArtistUc;
  final DeleteArtistUc _deleteArtistUc;

  ArtistBloc({
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
        super(ArtistInitial()) {
    on<LoadArtists>(_onLoadArtists);
    on<GetArtistById>(_onGetArtistById);
    on<CreateArtist>(_onCreateArtist);
    on<UpdateArtist>(_onUpdateArtist);
    on<DeleteArtist>(_onDeleteArtist);
  }

  Future<void> _onLoadArtists(
      LoadArtists event, Emitter<ArtistState> emit) async {
    emit(ArtistLoading());

    final result = await _getArtistsListUc(event.params);
    result.fold(
      (failure) => emit(ArtistError(_mapFailureToMessage(failure))),
      (response) => emit(ArtistsLoaded(response)),
    );
  }

  Future<void> _onGetArtistById(
      GetArtistById event, Emitter<ArtistState> emit) async {
    emit(ArtistLoading());

    final result = await _getArtistByIdUc(event.artistId);
    result.fold(
      (failure) => emit(ArtistError(_mapFailureToMessage(failure))),
      (artist) => emit(ArtistLoaded(artist)),
    );
  }

  Future<void> _onCreateArtist(
      CreateArtist event, Emitter<ArtistState> emit) async {
    final result = await _createArtistUc(event.params);
    result.fold(
      (failure) => emit(ArtistError(_mapFailureToMessage(failure))),
      (artist) => emit(ArtistCreated(artist)),
    );
  }

  Future<void> _onUpdateArtist(
      UpdateArtist event, Emitter<ArtistState> emit) async {
    final params = UpdateArtistParams(
      artistId: event.artistId,
      update: event.update,
    );

    final result = await _updateArtistUc(params);
    result.fold(
      (failure) => emit(ArtistError(_mapFailureToMessage(failure))),
      (artist) => emit(ArtistUpdated(artist)),
    );
  }

  Future<void> _onDeleteArtist(
      DeleteArtist event, Emitter<ArtistState> emit) async {
    final result = await _deleteArtistUc(event.artistId);
    result.fold(
      (failure) => emit(ArtistError(_mapFailureToMessage(failure))),
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
