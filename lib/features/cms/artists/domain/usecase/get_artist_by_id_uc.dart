// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class GetArtistByIdUc extends UseCase<ArtistModel, String> {
  GetArtistByIdUc({required this.artistRepository});
  final ArtistRepository artistRepository;

  @override
  EitherDynamic<ArtistModel> call(String artistId) =>
      artistRepository.getArtistById(artistId);
}
