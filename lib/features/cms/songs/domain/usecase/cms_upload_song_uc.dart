// Project imports:
import "package:groovix/core/shared/domain/usecase/usecase.dart";
import "package:groovix/features/cms/cms_index.dart";

class UploadSongUc extends UseCase<UploadSongResponse, UploadSongModel> {
  UploadSongUc({required this.cmsSongRepository});
  final CmsSongRepository cmsSongRepository;

  @override
  EitherDynamic<UploadSongResponse> call(UploadSongModel params) =>
      cmsSongRepository.uploadSong(params);
}
