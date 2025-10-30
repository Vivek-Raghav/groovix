// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

abstract class ArtistRepository {
  EitherDynamic<ArtistModel> createArtist(ArtistParams params);
  EitherDynamic<ArtistsListResponse> getArtistsList(ArtistsQueryModel params);
  EitherDynamic<ArtistModel> getArtistById(String artistId);
  EitherDynamic<ArtistModel> updateArtist(String artistId, ArtistUpdate update);
  EitherDynamic<DeleteResponse> deleteArtist(String artistId);
}
