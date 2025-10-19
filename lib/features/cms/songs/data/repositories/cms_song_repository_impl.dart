// Package imports:
import 'package:dartz/dartz.dart';
import 'package:groovix/core/error/failure.dart';
import "package:groovix/features/cms/cms_index.dart";

class CmsSongRepositoryImpl extends CmsSongRepository {
  CmsSongRepositoryImpl({required this.cmsSongRemoteDataSource});
  final CmsSongRemoteDataSource cmsSongRemoteDataSource;

  @override
  Future<List<SongModel>> getAllSongs() async {
    return await cmsSongRemoteDataSource.getAllSongs();
  }

  @override
  Future<SongModel?> getSongById(String id) async {
    return await cmsSongRemoteDataSource.getSongById(id);
  }

  @override
  Future<List<SongModel>> searchSongs(String query) async {
    return await cmsSongRemoteDataSource.searchSongs(query);
  }

  @override
  Future<SongModel> createSong(SongModel song) async {
    return await cmsSongRemoteDataSource.createSong(song);
  }

  @override
  Future<SongModel> updateSong(SongModel song) async {
    return await cmsSongRemoteDataSource.updateSong(song);
  }

  @override
  Future<void> deleteSong(String id) async {
    return await cmsSongRemoteDataSource.deleteSong(id);
  }

  @override
  Future<List<SongModel>> getRecentSongs({int limit = 10}) async {
    return await cmsSongRemoteDataSource.getRecentSongs(limit: limit);
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
