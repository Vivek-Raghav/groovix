// Package imports:
import 'package:dartz/dartz.dart';
import 'package:groovix/core/error/failure.dart';
import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart";

class CmsSongRepositoryImpl extends CmsSongRepository {
  CmsSongRepositoryImpl({required this.cmsSongRemoteDataSource});
  final CmsSongRemoteDataSource cmsSongRemoteDataSource;

  @override
  Future<List<SongModel>> searchSongs(String query) async {
    return await cmsSongRemoteDataSource.searchSongs(query);
  }

  @override
  Future<SongModel> updateSongFields(
      String songId, CmsSongUpdateModel updateModel) async {
    return await cmsSongRemoteDataSource.updateSongFields(songId, updateModel);
  }

  @override
  EitherDynamic<dynamic> deleteSong(String id) async {
    try {
      final data = await cmsSongRemoteDataSource.deleteSong(id);
      if (data != null) {
        return Right(data);
      } else {
        return Left(
            ServerFailure(error: StringConstants.strSomethingWentWrong));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }

  @override
  EitherDynamic<UploadSongResponse> uploadSong(UploadSongModel params) async {
    try {
      final data = await cmsSongRemoteDataSource.uploadSong(params);
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
}
