import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie_screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 16),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              )
            ],
          ),
        ),

        // Generos de la película
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 50),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return Center(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: const LinearProgressIndicator()));
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
        height: 300,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
                padding: const EdgeInsets.all(8),
                width: 150,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Photo
                      FadeInRight(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              actor.image,
                              height: 180,
                              width: 150,
                              fit: BoxFit.cover,
                            )),
                      ),
                      //Name
                      const SizedBox(height: 4),
                      Text(actor.name, maxLines: 2),
                      Text(actor.character ?? '',
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)),
                    ]));
          },
        ));
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final isFavorite = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () async {
              //await ref.watch(localStorageRepoProvider).toggleFavorite(movie);
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavorite.when(
                data: (isFavorite) => isFavorite
                    ? const Icon(Icons.favorite_rounded, color: Colors.pink)
                    : const Icon(Icons.favorite_border),
                error: (error, stackTrace) => throw UnimplementedError(),
                loading: () => const CircularProgressIndicator()))
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();
                return FadeIn(child: child);
              }),
            ),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.7, 1.0],
                colors: [Colors.transparent, Colors.black87]),
            const _CustomGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.2],
                colors: [Colors.black87, Colors.transparent]),
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.2],
                colors: [Colors.black87, Colors.transparent])
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final Alignment begin;
  final Alignment end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {required this.begin,
      required this.end,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: colors)),
    ));
  }
}
