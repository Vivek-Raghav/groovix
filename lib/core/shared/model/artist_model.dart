// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String? bio;

  ArtistModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.bio,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}
