// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class GetArtistsListUc extends UseCase<ArtistsListResponse, ArtistsQueryModel> {
  GetArtistsListUc({required this.artistRepository});
  final ArtistRepository artistRepository;

  @override
  EitherDynamic<ArtistsListResponse> call(ArtistsQueryModel params) =>
      artistRepository.getArtistsList(params);
}
