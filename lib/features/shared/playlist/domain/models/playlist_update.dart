class PlaylistUpdate {
  final String? name;
  final String? bio;
  final String? isPublic;

  const PlaylistUpdate({
    this.name,
    this.bio,
    this.isPublic,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (bio != null) data['bio'] = bio;
    if (isPublic != null) data['is_public'] = isPublic;
    return data;
  }

  bool get hasFields => name != null || bio != null || isPublic != null;
}
