import 'package:dartz/dartz.dart';
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/error/failure.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_update.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_list_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_songs_response.dart';
import 'package:groovix/features/shared/playlist/data/datasource/playlist_datasource.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final PlaylistDatasource _datasource;

  PlaylistRepositoryImpl({required PlaylistDatasource datasource})
      : _datasource = datasource;

  @override
  EitherDynamic<PlaylistModel> createPlaylist(UserPlaylistParams params) async {
    try {
      final playlist = await _datasource.createPlaylist(params);
      return Right(playlist);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<PlaylistsListResponse> getPlaylistsList(
      PlaylistsQueryModel params) async {
    try {
      final response = await _datasource.getPlaylistsList(params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<PlaylistModel> getPlaylistById(String playlistId) async {
    try {
      final playlist = await _datasource.getPlaylistById(playlistId);
      return Right(playlist);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<PlaylistModel> updatePlaylist(
      String playlistId, PlaylistUpdate update) async {
    try {
      final playlist = await _datasource.updatePlaylist(playlistId, update);
      return Right(playlist);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<DeleteResponse> deletePlaylist(String playlistId) async {
    try {
      final response = await _datasource.deletePlaylist(playlistId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<AddSongsResponse> addSongsToPlaylist(
      String playlistId, AddSongsToPlaylistRequest request) async {
    try {
      final response =
          await _datasource.addSongsToPlaylist(playlistId, request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<AddSongsResponse> removeSongsFromPlaylist(
      String playlistId, AddSongsToPlaylistRequest request) async {
    try {
      final response =
          await _datasource.removeSongsFromPlaylist(playlistId, request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<PlaylistSongsResponse> getPlaylistSongs(String playlistId,
      {int? page, int? size}) async {
    try {
      final response = await _datasource.getPlaylistSongs(playlistId,
          page: page, size: size);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
