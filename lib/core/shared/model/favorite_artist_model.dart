import 'package:json_annotation/json_annotation.dart';

part 'favorite_artist_model.g.dart';

@JsonSerializable()
class FavoriteArtistModel {
  final String userId;
  final String artistId;
  final DateTime favoritedAt;

  FavoriteArtistModel({
    required this.userId,
    required this.artistId,
    required this.favoritedAt,
  });

  factory FavoriteArtistModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteArtistModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteArtistModelToJson(this);
}
