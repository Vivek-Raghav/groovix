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
      if (data.id.isNotEmpty) {
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

  @override
  EitherDynamic<SongsListResponse> getSongList(SongsQueryModel params) async {
    try {
      final data = await songRemoteDataSource.getSongList(params);
      if (data.songs.isNotEmpty) {
        return Right(data);
      } else {
        return Left(
          ServerFailure(error: StringConstants.strSomethingWentWrong),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }

  @override
  EitherDynamic<UserSongFlagsResponse> updateSongFlags(
      SongFlagParams params) async {
    try {
      final data = await songRemoteDataSource.updateSongFlags(params);
      if (data.id.isNotEmpty) {
        return Right(data);
      } else {
        return Left(
          ServerFailure(error: StringConstants.strSomethingWentWrong),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }
}
