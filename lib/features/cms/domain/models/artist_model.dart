class ArtistModel {
  final String id;
  final String name;
  final String bio;
  final String profileImageUrl;
  final List<String> genres;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final int songCount;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.genres,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.songCount = 0,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      genres: List<String>.from(json['genres'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
      songCount: json['songCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'genres': genres,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'songCount': songCount,
    };
  }

  ArtistModel copyWith({
    String? id,
    String? name,
    String? bio,
    String? profileImageUrl,
    List<String>? genres,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    int? songCount,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      genres: genres ?? this.genres,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      songCount: songCount ?? this.songCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ArtistModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ArtistModel(id: $id, name: $name, songCount: $songCount)';
  }
}
