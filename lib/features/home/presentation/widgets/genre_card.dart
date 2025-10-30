// Project imports:
import 'package:groovix/features/home/home_index.dart';

class GenreCard extends StatelessWidget {
  final GenreModel genre;
  const GenreCard({required this.genre, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        // width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(genre.coverUrl,
                width: 40, height: 40, fit: BoxFit.cover),
          ),
          const SizedBox(width: 8),
          Text(genre.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
        ]));
  }
}
