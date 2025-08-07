import 'package:json_annotation/json_annotation.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  final String id;
  final String title;
  final String artistId;
  final String album;
  final String coverUrl;
  final String audioUrl;
  final DateTime createdAt;

  SongModel({
    required this.id,
    required this.title,
    required this.artistId,
    required this.album,
    required this.coverUrl,
    required this.audioUrl,
    required this.createdAt,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}