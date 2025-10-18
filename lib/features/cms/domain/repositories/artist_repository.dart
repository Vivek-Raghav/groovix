import '../models/artist_model.dart';

abstract class ArtistRepository {
  Future<List<ArtistModel>> getAllArtists();
  Future<ArtistModel?> getArtistById(String id);
  Future<List<ArtistModel>> searchArtists(String query);
  Future<ArtistModel> createArtist(ArtistModel artist);
  Future<ArtistModel> updateArtist(ArtistModel artist);
  Future<void> deleteArtist(String id);
}
