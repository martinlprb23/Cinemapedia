import 'package:cinemapedia/ui/providers/movies/movies_providers.dart';
import 'package:cinemapedia/ui/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final popularMovies = ref.watch(popularMoviesProvider);
    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        body: MovieMasonry(
            movies: popularMovies,
            loadNextPage: () =>
                ref.read(popularMoviesProvider.notifier).loadNextPage()));
  }

  @override
  bool get wantKeepAlive => true;
}
