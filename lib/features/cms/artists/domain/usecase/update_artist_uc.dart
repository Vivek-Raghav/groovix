// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class UpdateArtistUc extends UseCase<ArtistModel, UpdateArtistParams> {
  UpdateArtistUc({required this.artistRepository});
  final ArtistRepository artistRepository;

  @override
  EitherDynamic<ArtistModel> call(UpdateArtistParams params) =>
      artistRepository.updateArtist(params.artistId, params.update);
}
