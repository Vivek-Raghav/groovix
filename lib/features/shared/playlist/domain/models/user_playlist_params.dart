import 'dart:io';

class UserPlaylistParams {
  final String name;
  final File coverFile;
  final String bio;
  final bool isPublic;

  const UserPlaylistParams({
    required this.name,
    required this.coverFile,
    required this.bio,
    this.isPublic = false,
  });

  @override
  String toString() {
    return 'UserPlaylistParams(name: $name, coverFile: ${coverFile.path}, bio: $bio, isPublic: $isPublic)';
  }
}
