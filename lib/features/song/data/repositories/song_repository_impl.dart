// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:groovix/features/song/song_index.dart';

class SongRepositoryImpl extends SongRepository {
  SongRepositoryImpl({required this.songRemoteDataSource});
  final SongRemoteDataSource songRemoteDataSource;

  @override
  EitherDynamic<UploadSongResponse> uploadSong(UploadSongModel params) async {
    try {
      final data = await songRemoteDataSource.uploadSong(params);
      if (data != null) {
        return Right(data);
      } else {
        return Left(
          ServerFailure(
            error: StringConstants.strSomethingWentWrong,
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }
}
