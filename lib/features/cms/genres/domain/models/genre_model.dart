class GenreModel {
  final String id;
  final String name;
  final String description;
  final String color; // hex color code
  final String icon; // icon identifier
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final int songCount;

  const GenreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.songCount = 0,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
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
      'description': description,
      'color': color,
      'icon': icon,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'songCount': songCount,
    };
  }

  GenreModel copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    int? songCount,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      songCount: songCount ?? this.songCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GenreModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'GenreModel(id: $id, name: $name, songCount: $songCount)';
  }
}
