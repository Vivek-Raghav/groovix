// lib/features/song/domain/models/song_flags_params.dart
import 'package:json_annotation/json_annotation.dart';

part 'song_flags_params.g.dart';

@JsonSerializable()
class UpdateSongFlagParams {
  @JsonKey(name: 'song_id')
  final String songId;

  @JsonKey(name: 'user_id')
  final String userId;

  final bool? isLiked;
  final bool? isRecent;

  const UpdateSongFlagParams({
    required this.songId,
    required this.userId,
    this.isLiked = false,
    this.isRecent = false,
  });

  factory UpdateSongFlagParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateSongFlagParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSongFlagParamsToJson(this);
}



@JsonSerializable()
class GetSongFlagParams {
  @JsonKey(name: 'song_id')
  final String songId;

  @JsonKey(name: 'user_id')
  final String userId;

  const GetSongFlagParams({
    required this.songId,
    required this.userId,
  });

  factory GetSongFlagParams.fromJson(Map<String, dynamic> json) =>
      _$GetSongFlagParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSongFlagParamsToJson(this);
}
