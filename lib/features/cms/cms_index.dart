// CMS Models
export 'domain/models/song_model.dart';
export 'domain/models/playlist_model.dart';
export 'domain/models/genre_model.dart';
export 'domain/models/artist_model.dart';
export 'domain/models/dashboard_stats.dart';

// CMS Repositories
export 'domain/repositories/cms_song_repository.dart';
export 'domain/repositories/playlist_repository.dart';
export 'domain/repositories/genre_repository.dart';
export 'domain/repositories/artist_repository.dart';
export 'domain/repositories/dashboard_repository.dart';

// CMS Data Sources
export 'data/datasources/cms_song_datasource.dart';
export 'data/datasources/cms_song_datasource_impl.dart';

// CMS Repository Implementations
export 'data/repositories/cms_song_repository_impl.dart';
export 'data/repositories/dashboard_repository_impl.dart';

// CMS BLoCs
export 'presentation/bloc/song_bloc.dart';
export 'presentation/bloc/dashboard_bloc.dart';

// CMS Screens
export 'presentation/screens/cms_screen.dart';
export 'presentation/screens/dashboard_screen.dart';
export 'presentation/screens/cms_songs_screen.dart';
export 'presentation/screens/playlists_screen.dart';
export 'presentation/screens/genres_screen.dart';
export 'presentation/screens/cms_settings_screen.dart';
export 'presentation/screens/cms_add_song_screen.dart';
export 'presentation/screens/cms_add_playlist_screen.dart';
export 'presentation/screens/cms_add_genre_screen.dart';

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
