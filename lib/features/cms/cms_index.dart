// CMS Main Screen
export 'cms_screen.dart';

// Dashboard Module
export 'dashboard/domain/models/dashboard_stats.dart';
export 'dashboard/domain/repositories/dashboard_repository.dart';
export 'dashboard/data/repositories/dashboard_repository_impl.dart';
export 'dashboard/presentation/bloc/dashboard_bloc.dart';
export 'dashboard/presentation/screens/dashboard_screen.dart';

// Songs Module
export 'songs/domain/models/upload_song_model.dart';
export 'songs/domain/models/upload_song_response.dart';
export 'songs/domain/repositories/cms_song_repository.dart';
export 'songs/domain/usecase/song_usecases.dart';
export 'songs/domain/usecase/cms_upload_song_uc.dart';
export 'songs/data/datasource/cms_song_datasource.dart';
export 'songs/data/datasource/cms_song_remote_datasource_impl.dart';
export 'songs/data/repositories/cms_song_repository_impl.dart';
export 'songs/presentation/bloc/song_bloc.dart';
export 'songs/presentation/bloc/cms_song_event.dart';
export 'songs/presentation/bloc/cms_song_state.dart';
export 'songs/presentation/screens/cms_songs_screen.dart';
export 'songs/presentation/screens/cms_add_song_screen.dart';
export 'songs/presentation/screens/cms_upload_song.dart';
export 'songs/presentation/screens/song_upload_success_screen.dart';
export 'songs/presentation/widgets/audio_wave.dart';
export 'songs/presentation/widgets/file_picker.dart';

// Artists Module
export 'artists/domain/models/artist_model.dart';
export 'artists/domain/repositories/artist_repository.dart';
export 'artists/domain/usecase/artist_usecases.dart';
export 'artists/presentation/bloc/artist_bloc.dart';
export 'artists/presentation/screens/cms_artists_screen.dart';
export 'artists/presentation/screens/cms_add_artist_screen.dart';

// Playlists Module
export 'playlists/domain/models/playlist_model.dart';
export 'playlists/domain/repositories/playlist_repository.dart';
export 'playlists/domain/usecase/playlist_usecases.dart';
export 'playlists/presentation/bloc/playlist_bloc.dart';
export 'playlists/presentation/screens/playlists_screen.dart';
export 'playlists/presentation/screens/cms_add_playlist_screen.dart';

// Genres Module
export 'genres/domain/models/genre_model.dart';
export 'genres/domain/repositories/genre_repository.dart';
export 'genres/domain/usecase/genre_usecases.dart';
export 'genres/presentation/bloc/genre_bloc.dart';
export 'genres/presentation/screens/genres_screen.dart';
export 'genres/presentation/screens/cms_add_genre_screen.dart';

// Settings Module
export 'settings/presentation/screens/cms_settings_screen.dart';

// Shared Widgets
export 'shared/widgets/stat_card.dart';
export 'shared/widgets/search_bar.dart';
export 'shared/widgets/logo_container.dart';
export 'shared/widgets/recent_activity.dart';

// Core dependencies
export 'package:flutter/material.dart' hide SearchBar;
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:groovix/core/theme/app_theme.dart';
export 'package:groovix/core/services/theme/theme_manager.dart';
export 'package:groovix/injection_container/injection_index.dart';

// Shared Models
export 'package:groovix/core/shared/model/song_model.dart';

// Core Services
export 'package:groovix/core/constants/string_constants.dart';
export 'package:groovix/core/error/server_exception.dart';
export 'package:groovix/core/services/api/api_service.dart';
export 'package:groovix/core/services/api/api_urls.dart';
export 'package:groovix/core/utils/generic_typedef.dart';

// Navigation
export 'package:go_router/go_router.dart';
export 'package:groovix/routes/app_routes.dart';

// Common Widgets
export 'package:groovix/core/shared/widgets/common_back_button.dart';
