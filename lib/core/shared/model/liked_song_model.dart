import 'package:json_annotation/json_annotation.dart';

part 'liked_song_model.g.dart';

@JsonSerializable()
class LikedSongModel {
  final String userId;
  final String songId;
  final DateTime likedAt;

  LikedSongModel({
    required this.userId,
    required this.songId,
    required this.likedAt,
  });

  factory LikedSongModel.fromJson(Map<String, dynamic> json) =>
      _$LikedSongModelFromJson(json);
  Map<String, dynamic> toJson() => _$LikedSongModelToJson(this);
}