// lib/features/song/domain/models/song_flag_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'song_flag_response.g.dart';

@JsonSerializable()
class UserSongFlagsResponse {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'song_id')
  final String songId;

  @JsonKey(name: 'is_liked')
  final bool isLiked;

  @JsonKey(name: 'is_recent')
  final bool isRecent;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const UserSongFlagsResponse({
    required this.id,
    required this.userId,
    required this.songId,
    required this.isLiked,
    required this.isRecent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSongFlagsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSongFlagsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSongFlagsResponseToJson(this);
}