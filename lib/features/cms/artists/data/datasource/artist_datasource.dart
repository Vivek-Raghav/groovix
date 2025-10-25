import 'package:groovix/features/cms/cms_index.dart';

abstract class ArtistDatasource {
  Future<ArtistModel> createArtist(ArtistParams params);
  Future<ArtistsListResponse> getArtistsList(ArtistsQueryModel params);
  Future<ArtistModel> getArtistById(String artistId);
  Future<ArtistModel> updateArtist(String artistId, ArtistUpdate update);
  Future<DeleteResponse> deleteArtist(String artistId);
}
