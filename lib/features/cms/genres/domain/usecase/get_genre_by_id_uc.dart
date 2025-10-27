import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';

class GetGenreByIdUc extends UseCase<GenreModel, String> {
  GetGenreByIdUc({required this.genreRepository});
  final GenreRepository genreRepository;

  @override
  EitherDynamic<GenreModel> call(String genreId) =>
      genreRepository.getGenreById(genreId);
}
