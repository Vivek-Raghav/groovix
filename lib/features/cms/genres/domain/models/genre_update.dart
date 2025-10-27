class GenreUpdate {
  final String? name;
  final String? bio;

  const GenreUpdate({
    this.name,
    this.bio,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (bio != null) data['bio'] = bio;
    return data;
  }

  bool get hasFields => name != null || bio != null;
}
