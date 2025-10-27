import 'package:groovix/features/shared/playlist/playlist_index.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class UserPlaylistPage extends StatelessWidget {
  const UserPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<PlaylistBloc>()),
      ],
      child: const UserPlaylistScreen(),
    );
  }
}
