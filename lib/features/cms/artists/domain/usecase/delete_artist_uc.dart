// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class DeleteArtistUc extends UseCase<DeleteResponse, String> {
  DeleteArtistUc({required this.artistRepository});
  final ArtistRepository artistRepository;

  @override
  EitherDynamic<DeleteResponse> call(String artistId) =>
      artistRepository.deleteArtist(artistId);
}
