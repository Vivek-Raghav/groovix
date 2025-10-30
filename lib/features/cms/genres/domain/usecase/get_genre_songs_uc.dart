// Project imports:
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';

class GetGenreSongsUc
    extends UseCase<GenreSongsResponse, Map<String, dynamic>> {
  GetGenreSongsUc({required this.genreRepository});
  final GenreRepository genreRepository;

  @override
  EitherDynamic<GenreSongsResponse> call(Map<String, dynamic> params) {
    final String genreId = params['genreId'] as String;
    final int? page = params['page'] as int?;
    final int? size = params['size'] as int?;
    return genreRepository.getGenreSongs(genreId, page: page, size: size);
  }
}
