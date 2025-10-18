import '../models/artist_model.dart';
import '../repositories/artist_repository.dart';

class GetAllArtistsUseCase {
  final ArtistRepository _repository;

  GetAllArtistsUseCase(this._repository);

  Future<List<ArtistModel>> call() async {
    return await _repository.getAllArtists();
  }
}

class GetArtistByIdUseCase {
  final ArtistRepository _repository;

  GetArtistByIdUseCase(this._repository);

  Future<ArtistModel?> call(String id) async {
    return await _repository.getArtistById(id);
  }
}

class SearchArtistsUseCase {
  final ArtistRepository _repository;

  SearchArtistsUseCase(this._repository);

  Future<List<ArtistModel>> call(String query) async {
    return await _repository.searchArtists(query);
  }
}

class CreateArtistUseCase {
  final ArtistRepository _repository;

  CreateArtistUseCase(this._repository);

  Future<ArtistModel> call(ArtistModel artist) async {
    return await _repository.createArtist(artist);
  }
}

class UpdateArtistUseCase {
  final ArtistRepository _repository;

  UpdateArtistUseCase(this._repository);

  Future<ArtistModel> call(ArtistModel artist) async {
    return await _repository.updateArtist(artist);
  }
}

class DeleteArtistUseCase {
  final ArtistRepository _repository;

  DeleteArtistUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteArtist(id);
  }
}
