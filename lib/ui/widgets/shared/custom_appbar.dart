import 'package:cinemapedia/ui/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/ui/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color: colors.primary),
                const SizedBox(width: 5),
                Text('Cinemapedia', style: titleStyle),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      final movieRepo = ref.read(movieRepositoryProvider);
                      showSearch(
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovies: movieRepo.searchMovies));
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
