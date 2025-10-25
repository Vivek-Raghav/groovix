class ArtistUpdate {
  final String? name;
  final String? avatarUrl;
  final String? bio;

  const ArtistUpdate({
    this.name,
    this.avatarUrl,
    this.bio,
  });

  factory ArtistUpdate.fromJson(Map<String, dynamic> json) {
    return ArtistUpdate(
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bio != null) 'bio': bio,
    };
  }

  @override
  String toString() {
    return 'ArtistUpdate(name: $name, avatarUrl: $avatarUrl, bio: $bio)';
  }
}
