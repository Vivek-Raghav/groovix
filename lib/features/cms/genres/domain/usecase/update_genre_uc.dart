import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/models/update_genre_params.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';

class UpdateGenreUc extends UseCase<GenreModel, UpdateGenreParams> {
  UpdateGenreUc({required this.genreRepository});
  final GenreRepository genreRepository;

  @override
  EitherDynamic<GenreModel> call(UpdateGenreParams params) =>
      genreRepository.updateGenre(params.genreId, params.update);
}
