import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/usecase/artist_usecases.dart';

// Events
abstract class ArtistEvent {}

class LoadArtists extends ArtistEvent {}

class SearchArtists extends ArtistEvent {
  final String query;
  SearchArtists(this.query);
}

class CreateArtist extends ArtistEvent {
  final ArtistModel artist;
  CreateArtist(this.artist);
}

class UpdateArtist extends ArtistEvent {
  final ArtistModel artist;
  UpdateArtist(this.artist);
}

class DeleteArtist extends ArtistEvent {
  final String id;
  DeleteArtist(this.id);
}

// States
abstract class ArtistState {}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final List<ArtistModel> artists;
  ArtistLoaded(this.artists);
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
  final String id;
  ArtistDeleted(this.id);
}

// BLoC
class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final GetAllArtistsUseCase _getAllArtistsUseCase;
  final SearchArtistsUseCase _searchArtistsUseCase;
  final CreateArtistUseCase _createArtistUseCase;
  final UpdateArtistUseCase _updateArtistUseCase;
  final DeleteArtistUseCase _deleteArtistUseCase;

  ArtistBloc({
    required GetAllArtistsUseCase getAllArtistsUseCase,
    required SearchArtistsUseCase searchArtistsUseCase,
    required CreateArtistUseCase createArtistUseCase,
    required UpdateArtistUseCase updateArtistUseCase,
    required DeleteArtistUseCase deleteArtistUseCase,
  })  : _getAllArtistsUseCase = getAllArtistsUseCase,
        _searchArtistsUseCase = searchArtistsUseCase,
        _createArtistUseCase = createArtistUseCase,
        _updateArtistUseCase = updateArtistUseCase,
        _deleteArtistUseCase = deleteArtistUseCase,
        super(ArtistInitial()) {
    on<LoadArtists>(_onLoadArtists);
    on<SearchArtists>(_onSearchArtists);
    on<CreateArtist>(_onCreateArtist);
    on<UpdateArtist>(_onUpdateArtist);
    on<DeleteArtist>(_onDeleteArtist);
  }

  Future<void> _onLoadArtists(
      LoadArtists event, Emitter<ArtistState> emit) async {
    emit(ArtistLoading());
    try {
      final artists = await _getAllArtistsUseCase();
      emit(ArtistLoaded(artists));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }

  Future<void> _onSearchArtists(
      SearchArtists event, Emitter<ArtistState> emit) async {
    emit(ArtistLoading());
    try {
      final artists = await _searchArtistsUseCase(event.query);
      emit(ArtistLoaded(artists));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }

  Future<void> _onCreateArtist(
      CreateArtist event, Emitter<ArtistState> emit) async {
    try {
      final artist = await _createArtistUseCase(event.artist);
      emit(ArtistCreated(artist));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }

  Future<void> _onUpdateArtist(
      UpdateArtist event, Emitter<ArtistState> emit) async {
    try {
      final artist = await _updateArtistUseCase(event.artist);
      emit(ArtistUpdated(artist));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }

  Future<void> _onDeleteArtist(
      DeleteArtist event, Emitter<ArtistState> emit) async {
    try {
      await _deleteArtistUseCase(event.id);
      emit(ArtistDeleted(event.id));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }
}
