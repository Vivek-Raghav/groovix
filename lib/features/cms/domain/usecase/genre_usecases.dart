import '../models/genre_model.dart';
import '../repositories/genre_repository.dart';

class GetAllGenresUseCase {
  final GenreRepository _repository;

  GetAllGenresUseCase(this._repository);

  Future<List<GenreModel>> call() async {
    return await _repository.getAllGenres();
  }
}

class GetGenreByIdUseCase {
  final GenreRepository _repository;

  GetGenreByIdUseCase(this._repository);

  Future<GenreModel?> call(String id) async {
    return await _repository.getGenreById(id);
  }
}

class SearchGenresUseCase {
  final GenreRepository _repository;

  SearchGenresUseCase(this._repository);

  Future<List<GenreModel>> call(String query) async {
    return await _repository.searchGenres(query);
  }
}

class CreateGenreUseCase {
  final GenreRepository _repository;

  CreateGenreUseCase(this._repository);

  Future<GenreModel> call(GenreModel genre) async {
    return await _repository.createGenre(genre);
  }
}

class UpdateGenreUseCase {
  final GenreRepository _repository;

  UpdateGenreUseCase(this._repository);

  Future<GenreModel> call(GenreModel genre) async {
    return await _repository.updateGenre(genre);
  }
}

class DeleteGenreUseCase {
  final GenreRepository _repository;

  DeleteGenreUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteGenre(id);
  }
}
