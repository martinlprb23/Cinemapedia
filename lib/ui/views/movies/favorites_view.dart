import 'package:cinemapedia/ui/providers/providers.dart';
import 'package:cinemapedia/ui/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;
    isLastPage = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text('Ohhh no!!',
                style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text('No tienes películas favoritas',
                style: TextStyle(fontSize: 20, color: Colors.black45)),
            const SizedBox(height: 20),
            FilledButton.tonal(
                onPressed: () => context.go('/home/0'),
                child: const Text('Empieza a buscar'))
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Favorites')),
        body: MovieMasonry(movies: favoriteMovies, loadNextPage: loadNextPage));
  }
}
