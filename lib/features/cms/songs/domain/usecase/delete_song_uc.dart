import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/songs/domain/repositories/cms_song_repository.dart';

class DeleteSongUc extends UseCase<dynamic, String> {
  DeleteSongUc({required this.cmsSongRepository});
  final CmsSongRepository cmsSongRepository;

  @override
  EitherDynamic<dynamic> call(String songId) =>
      cmsSongRepository.deleteSong(songId);
}
