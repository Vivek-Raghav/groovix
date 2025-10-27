import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_bloc.dart';
import 'package:groovix/routes/routes_index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<MusicPlayerBloc>()),
        BlocProvider.value(value: getIt<SongCubit>()),
        BlocProvider.value(value: getIt<PlaylistBloc>()),
        BlocProvider.value(value: getIt<CmsGenreBloc>())
      ],
      child: const HomeScreen(),
    );
  }
}
