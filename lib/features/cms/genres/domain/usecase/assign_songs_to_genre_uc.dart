// Project imports:
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_to_genre_request.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';

class AssignSongsToGenreUc
    extends UseCase<AssignSongsResponse, Map<String, dynamic>> {
  AssignSongsToGenreUc({required this.genreRepository});
  final GenreRepository genreRepository;

  @override
  EitherDynamic<AssignSongsResponse> call(Map<String, dynamic> params) {
    final String genreId = params['genreId'] as String;
    final AssignSongsToGenreRequest request =
        params['request'] as AssignSongsToGenreRequest;
    return genreRepository.assignSongsToGenre(genreId, request);
  }
}
