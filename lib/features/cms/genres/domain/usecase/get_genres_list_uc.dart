// Project imports:
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_list_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';

class GetGenresListUc extends UseCase<GenresListResponse, GenresQueryModel> {
  GetGenresListUc({required this.genreRepository});
  final GenreRepository genreRepository;

  @override
  EitherDynamic<GenresListResponse> call(GenresQueryModel params) =>
      genreRepository.getGenresList(params);
}
