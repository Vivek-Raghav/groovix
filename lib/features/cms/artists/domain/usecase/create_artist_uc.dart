// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class CreateArtistUc extends UseCase<ArtistModel, ArtistParams> {
  CreateArtistUc({required this.artistRepository});
  final ArtistRepository artistRepository;

  @override
  EitherDynamic<ArtistModel> call(ArtistParams params) =>
      artistRepository.createArtist(params);
}
