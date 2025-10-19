class PlaylistModel {
  final String id;
  final String name;
  final String description;
  final List<String> songIds;
  final String coverImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String createdBy;

  const PlaylistModel({
    required this.id,
    required this.name,
    required this.description,
    required this.songIds,
    required this.coverImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.isActive = true,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      songIds: List<String>.from(json['songIds'] as List),
      coverImageUrl: json['coverImageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'songIds': songIds,
      'coverImageUrl': coverImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
      'isActive': isActive,
    };
  }

  PlaylistModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? songIds,
    String? coverImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    bool? isActive,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      songIds: songIds ?? this.songIds,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlaylistModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PlaylistModel(id: $id, name: $name, songCount: ${songIds.length})';
  }
}
