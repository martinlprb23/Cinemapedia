import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/ui/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final FutureProviderFamily<List<Video>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
  final movieRepo = ref.watch(movieRepositoryProvider);
  return movieRepo.getYoutubeVideosById(movieId);
});

class VideoFromMovie extends ConsumerWidget {
  final int movieId;
  const VideoFromMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final videosFromMovie = ref.watch(videosFromMovieProvider(movieId));
    return videosFromMovie.when(
        data: (videos) => _VideosList(videos: videos),
        error: (_, __) =>
            const Center(child: Text('Could not load similar movies!')),
        loading: () =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)));
  }
}

class _VideosList extends StatelessWidget {
  final List<Video> videos;
  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Videos',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
        _YTVideoPlayer(
            name: videos.first.name, youtubeId: videos.first.youtubeKey)
      ],
    );
  }
}

class _YTVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;
  const _YTVideoPlayer({required this.youtubeId, required this.name});

  @override
  State<_YTVideoPlayer> createState() => _YTVideoPlayerState();
}

class _YTVideoPlayerState extends State<_YTVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          showLiveFullscreenButton: true,
          mute: false,
          autoPlay: false,
          disableDragSeek: true,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Text(widget.name),
        const SizedBox(height: 8),
        YoutubePlayer(controller: _controller)
      ]),
    );
  }
}
