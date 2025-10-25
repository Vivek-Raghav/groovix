// Dart imports:
import 'dart:io';

class ArtistParams {
  final String name;
  final File avatarFile;
  final String bio;

  const ArtistParams({
    required this.name,
    required this.avatarFile,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
    };
  }

  @override
  String toString() {
    return 'ArtistParams(name: $name, avatarFile: ${avatarFile.path}, bio: $bio)';
  }
}
