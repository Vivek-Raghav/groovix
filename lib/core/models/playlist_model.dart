import 'package:json_annotation/json_annotation.dart';

part 'playlist_model.g.dart';

@JsonSerializable()
class PlaylistModel {
  final String id;
  final String name;
  @JsonKey(name: 'cover_url')
  final String coverUrl;
  final String bio;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'is_public')
  final String isPublic;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.bio,
    required this.userId,
    required this.isPublic,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistModelToJson(this);
}
