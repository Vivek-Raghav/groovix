class ArtistParams {
  final String name;
  final String avatarUrl;
  final String bio;

  const ArtistParams({
    required this.name,
    required this.avatarUrl,
    required this.bio,
  });

  factory ArtistParams.fromJson(Map<String, dynamic> json) {
    return ArtistParams(
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      bio: json['bio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar_url': avatarUrl,
      'bio': bio,
    };
  }

  @override
  String toString() {
    return 'ArtistParams(name: $name, avatarUrl: $avatarUrl, bio: $bio)';
  }
}
