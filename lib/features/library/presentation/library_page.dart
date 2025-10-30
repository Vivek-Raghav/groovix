import 'package:groovix/core/core_index.dart';
import 'package:groovix/features/library/presentation/library_screen.dart';
import 'package:groovix/features/song/bloc/song_bloc.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: getIt<SongCubit>()),
    ], child: const LibraryScreen());
  }
}
