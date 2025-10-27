import 'dart:io';

class GenreParams {
  final String name;
  final File coverFile;
  final String bio;

  const GenreParams({
    required this.name,
    required this.coverFile,
    required this.bio,
  });

  @override
  String toString() {
    return 'GenreParams(name: $name, coverFile: ${coverFile.path}, bio: $bio)';
  }
}
