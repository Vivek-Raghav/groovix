// Project imports:
import "package:groovix/core/shared/domain/usecase/usecase.dart";
import "package:groovix/core/utils/generic_typedef.dart";
import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/repositories/cms_song_repository.dart";

class SearchSongUc extends UseCase<List<SongModel>, String> {
  SearchSongUc({required this.cmsSongRepository});
  final CmsSongRepository cmsSongRepository;

  @override
  EitherDynamic<List<SongModel>> call(String query) =>
      cmsSongRepository.searchSongs(query);
}
