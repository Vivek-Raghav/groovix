import '../models/genre_model.dart';

abstract class GenreRepository {
  Future<List<GenreModel>> getAllGenres();
  Future<GenreModel?> getGenreById(String id);
  Future<List<GenreModel>> searchGenres(String query);
  Future<GenreModel> createGenre(GenreModel genre);
  Future<GenreModel> updateGenre(GenreModel genre);
  Future<void> deleteGenre(String id);
}
