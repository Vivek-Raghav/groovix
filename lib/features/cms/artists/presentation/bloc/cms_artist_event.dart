// Events

// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

abstract class ArtistEvent {}

class SearchArtists extends ArtistEvent {
  final String query;
  SearchArtists(this.query);
}

class GetArtistById extends ArtistEvent {
  final String artistId;
  GetArtistById(this.artistId);
}

class DeleteArtist extends ArtistEvent {
  final String artistId;
  DeleteArtist(this.artistId);
}

class CreateArtist extends ArtistEvent {
  final ArtistParams artistParams;
  CreateArtist(this.artistParams);
}

class UpdateArtist extends ArtistEvent {
  final String artistId;
  final ArtistUpdate update;
  UpdateArtist(this.artistId, this.update);
}

class FetchArtistsList extends ArtistEvent {
  final ArtistsQueryModel artistsQueryModel;
  FetchArtistsList(this.artistsQueryModel);
}
