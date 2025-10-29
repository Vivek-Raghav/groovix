import 'package:groovix/core/shared/utils/generic_enums.dart';
import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/features/home/home_index.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_state.dart';
import 'package:groovix/features/song/bloc/song_bloc.dart';
import 'package:groovix/features/song/bloc/song_state.dart';
import 'package:groovix/features/song/domain/models/song_query_model.dart';
import 'package:groovix/features/song/presentation/screens/songs_screen.dart';

class SongsPage extends StatelessWidget {
  final SongListContext songListContext;
  const SongsPage({required this.songListContext, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<MusicPlayerBloc>()),
        BlocProvider.value(value: getIt<SongCubit>())
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const CommonBackButton(),
            Text('Songs',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            const SizedBox(width: 36),
          ]),
        ),
        body: Builder(builder: (context) {
          switch (songListContext) {
            case SongListContext.search:
              return BlocProvider.value(
                  value: getIt<SongCubit>()
                    ..getSongList(SongsQueryModel(page: 1, size: 10)),
                  child: BlocBuilder<SongCubit, SongState>(
                      builder: (context, state) {
                    if (state.songsListResponse?.songs != null) {
                      return SongsScreen(
                          songs: state.songsListResponse?.songs ?? []);
                    } else if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  }));
            case SongListContext.playlist:
              return BlocProvider.value(
                value: getIt<PlaylistBloc>(),
                child: BlocBuilder<PlaylistBloc, PlaylistState>(
                    builder: (context, state) {
                  if (state is GetPlaylistSongsLoaded) {
                    return SongsScreen(songs: state.songs);
                  } else if (state is GetPlaylistSongsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox.shrink();
                }),
              );
            case SongListContext.genre:
              return BlocProvider.value(
                  value: getIt<CmsGenreBloc>(),
                  child: BlocBuilder<CmsGenreBloc, CmsGenreState>(
                      builder: (context, state) {
                    if (state is GetGenreSongsLoaded) {
                      return SongsScreen(songs: state.songs);
                    } else if (state is GetGenreSongsLoading ||
                        state is CmsGenreLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetGenreSongsError) {
                      return Center(
                          child: Text(
                              'Error: ${state.message}')); // ⬅️ Show error properly
                    }
                    return const SizedBox.shrink();
                  }));
            case SongListContext.artist:
              return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
