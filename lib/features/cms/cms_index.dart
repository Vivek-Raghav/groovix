// CMS Models
export 'domain/models/playlist_model.dart';
export 'domain/models/genre_model.dart';
export 'domain/models/artist_model.dart';
export 'domain/models/dashboard_stats.dart';

// CMS Repositories
export 'presentation/sections/songs/domain/repositories/cms_song_repository.dart';
export 'domain/repositories/playlist_repository.dart';
export 'domain/repositories/genre_repository.dart';
export 'domain/repositories/artist_repository.dart';
export 'domain/repositories/dashboard_repository.dart';

// CMS Data Sources
export 'presentation/sections/songs/data/datasource/cms_song_datasource.dart';
export 'presentation/sections/songs/data/datasource/cms_song_remote_datasource_impl.dart';

// CMS Repository Implementations
export 'presentation/sections/songs/data/repositories/cms_song_repository_impl.dart';
export 'data/repositories/dashboard_repository_impl.dart';

// CMS Use Cases
export 'presentation/sections/songs/domain/usecase/song_usecases.dart';
export 'domain/usecase/artist_usecases.dart';
export 'domain/usecase/playlist_usecases.dart';
export 'domain/usecase/genre_usecases.dart';

// CMS BLoCs
export 'presentation/bloc/song_bloc.dart';
export 'presentation/bloc/dashboard_bloc.dart';
export 'presentation/bloc/artist_bloc.dart';
export 'presentation/bloc/playlist_bloc.dart';
export 'presentation/bloc/genre_bloc.dart';

// CMS Screens
export 'cms_screen.dart';
export 'presentation/sections/dashboard/dashboard_screen.dart';
export 'presentation/sections/songs/cms_songs_screen.dart';
export 'presentation/sections/artists/cms_artists_screen.dart';
export 'presentation/sections/playlists/playlists_screen.dart';
export 'presentation/sections/genres/genres_screen.dart';
export 'presentation/sections/settings/cms_settings_screen.dart';
export 'presentation/sections/songs/cms_add_song_screen.dart';
export 'presentation/sections/artists/cms_add_artist_screen.dart';
export 'presentation/sections/playlists/cms_add_playlist_screen.dart';
export 'presentation/sections/genres/cms_add_genre_screen.dart';

// CMS Widgets
export 'presentation/widgets/stat_card.dart';
export 'presentation/widgets/search_bar.dart';
export 'presentation/widgets/logo_container.dart';
export 'presentation/widgets/recent_activity.dart';

// Core dependencies
export 'package:flutter/material.dart' hide SearchBar;
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:groovix/core/theme/app_theme.dart';
export 'package:groovix/core/services/theme/theme_manager.dart';
export 'package:groovix/injection_container/injection_index.dart';

export 'package:groovix/core/shared/model/song_model.dart';
export 'package:groovix/features/cms/presentation/bloc/events/cms_song_event.dart';
export 'package:groovix/features/cms/presentation/bloc/states/cms_song_state.dart';

export "package:groovix/features/cms/presentation/sections/songs/domain/models/upload_song_model.dart";
export "package:groovix/features/cms/presentation/sections/songs/domain/models/upload_song_response.dart";

export "package:groovix/core/constants/string_constants.dart";
export "package:groovix/core/error/server_exception.dart";
export "package:groovix/core/services/api/api_service.dart";
export "package:groovix/core/services/api/api_urls.dart";

export 'package:groovix/core/utils/generic_typedef.dart';
export "package:go_router/go_router.dart";
export "package:groovix/routes/app_routes.dart";
