// lib/features/song/domain/models/song_flags_params.dart
import 'package:json_annotation/json_annotation.dart';

part 'song_flags_params.g.dart';

@JsonSerializable()
class SongFlagParams {
  @JsonKey(name: 'song_id')
  final String songId;

  @JsonKey(name: 'user_id')
  final String userId;

  // Backend expects camelCase keys for these two, so no rename.
  final bool? isLiked;
  final bool? isRecent;

  const SongFlagParams({
    required this.songId,
    required this.userId,
    this.isLiked = false,
    this.isRecent = false,
  });

  factory SongFlagParams.fromJson(Map<String, dynamic> json) =>
      _$SongFlagParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SongFlagParamsToJson(this);
}
