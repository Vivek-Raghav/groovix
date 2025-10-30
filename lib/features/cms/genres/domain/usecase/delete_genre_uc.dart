// Project imports:
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';

class DeleteGenreUc extends UseCase<DeleteResponse, String> {
  DeleteGenreUc({required this.genreRepository});
  final GenreRepository genreRepository;

  @override
  EitherDynamic<DeleteResponse> call(String genreId) =>
      genreRepository.deleteGenre(genreId);
}
