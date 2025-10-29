import 'package:groovix/features/navigation_bar/navigation_index.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: getIt<MusicPlayerBloc>()),
      BlocProvider.value(value: getIt<SongCubit>()),
    ], child: const ExploreScreen());
  }
}
