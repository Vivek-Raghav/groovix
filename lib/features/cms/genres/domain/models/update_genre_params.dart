// Project imports:
import 'package:groovix/features/cms/genres/domain/models/genre_update.dart';

class UpdateGenreParams {
  final String genreId;
  final GenreUpdate update;

  const UpdateGenreParams({
    required this.genreId,
    required this.update,
  });

  @override
  String toString() {
    return 'UpdateGenreParams(genreId: $genreId, update: $update)';
  }
}
