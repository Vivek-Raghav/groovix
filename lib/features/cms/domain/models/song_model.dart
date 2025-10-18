class SongModel {
  final String id;
  final String name;
  final String artist;
  final List<String> genres;
  final List<String> categories;
  final String audioUrl;
  final String thumbnailUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int duration; // in seconds
  final bool isActive;

  const SongModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.genres,
    required this.categories,
    required this.audioUrl,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
    this.isActive = true,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      genres: List<String>.from(json['genres'] as List),
      categories: List<String>.from(json['categories'] as List),
      audioUrl: json['audioUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      duration: json['duration'] as int,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'genres': genres,
      'categories': categories,
      'audioUrl': audioUrl,
      'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'duration': duration,
      'isActive': isActive,
    };
  }

  SongModel copyWith({
    String? id,
    String? name,
    String? artist,
    List<String>? genres,
    List<String>? categories,
    String? audioUrl,
    String? thumbnailUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? duration,
    bool? isActive,
  }) {
    return SongModel(
      id: id ?? this.id,
      name: name ?? this.name,
      artist: artist ?? this.artist,
      genres: genres ?? this.genres,
      categories: categories ?? this.categories,
      audioUrl: audioUrl ?? this.audioUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SongModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SongModel(id: $id, name: $name, artist: $artist)';
  }
}
