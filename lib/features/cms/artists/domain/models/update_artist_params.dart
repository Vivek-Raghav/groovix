import 'package:groovix/features/cms/cms_index.dart';

class UpdateArtistParams {
  final String artistId;
  final ArtistUpdate update;

  const UpdateArtistParams({
    required this.artistId,
    required this.update,
  });

  @override
  String toString() {
    return 'UpdateArtistParams(artistId: $artistId, update: $update)';
  }
}
