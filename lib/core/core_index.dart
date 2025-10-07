library core_index;

// Flutter exports
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

// Core constants
export 'constants/global_const.dart';
export 'constants/string_constants.dart';
export 'constants/pref_keys.dart';

// Core services
export 'services/api_service.dart';
export 'services/api_urls.dart';
export 'services/theme_manager.dart';

// Core error handling
export 'error/failure.dart';
export 'error/server_exception.dart';

// Core local database
export 'local_db/local_cache.dart';

// Core theme
export 'theme/app_theme.dart';

// Core shared utilities
export 'shared/domain/method/methods.dart';
export 'shared/domain/usecase/usecase.dart';
export 'shared/model/song_model.dart';
export 'shared/model/liked_song_model.dart';

// Core utils
export 'utils/generic_typedef.dart';

// Core initialization
export 'initialization/initialization_manager.dart';

// Core config
export 'config/flavor_config.dart';
export 'config/flavor_init.dart';
