import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart';

@JsonSerializable()
class GenreModel {
  final String id;
  final String name;
  @JsonKey(name: 'cover_url')
  final String coverUrl;
  final String bio;

  GenreModel({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.bio,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}
