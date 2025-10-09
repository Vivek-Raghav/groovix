import 'package:groovix/features/home/home_index.dart';
import 'package:groovix/features/song/song_index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<SongCubit>()),
      ],
      child: const HomeScreen(),
    );
  }
}
