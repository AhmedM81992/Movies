import 'package:flutter/material.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../models/TrailerModel.dart';

class DetailsVideoPlayer extends StatefulWidget {
  static const String routeName = "DetailsVideoPlayer";
  final String movieId;

  const DetailsVideoPlayer({required this.movieId, Key? key}) : super(key: key);

  @override
  State<DetailsVideoPlayer> createState() => _DetailsVideoPlayerState();
}

class _DetailsVideoPlayerState extends State<DetailsVideoPlayer> {
  late Future<String?> _trailerUrlFuture;
  late Future<String?> _movieTitleFuture;
  late Future<String?> _movieDetailsFuture;

  @override
  void initState() {
    super.initState();
    _trailerUrlFuture = _fetchTrailerUrl();
    _movieTitleFuture = _fetchMovieTitle();
    _movieDetailsFuture =
        _fetchMovieDetails(); // Initialize _movieDetailsFuture
  }

  Future<String?> _fetchTrailerUrl() async {
    try {
      final details = await ApiManager.getTrailer(widget.movieId);
      // Extract the trailer key from the movie details
      final trailer = details?.results?.firstWhere(
        (video) => video.type == 'Trailer',
        orElse: () => Results(), // Return an empty Results object here
      );
      return trailer != null
          ? 'https://www.youtube.com/watch?v=${trailer.key}'
          : null;
    } catch (e) {
      print('Error fetching trailer: $e');
      return null;
    }
  }

  Future<String?> _fetchMovieTitle() async {
    try {
      final details = await ApiManager.getDetails(widget.movieId);
      return details?.title;
    } catch (e) {
      print('Error fetching movie title: $e');
      return null;
    }
  }

  Future<String?> _fetchMovieDetails() async {
    try {
      final details = await ApiManager.getDetails(widget.movieId);
      return details?.overview;
    } catch (e) {
      print('Error fetching movie title: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: FutureBuilder<String?>(
          future: _movieTitleFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...'); // Placeholder while loading
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Text('Error'); // Placeholder for error state
            } else {
              return Text(
                snapshot.data!,
                style: TextStyle(color: Colors.white),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<String?>(
        future: _trailerUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == null) {
            return Center(child: Text('Trailer not available'));
          }

          // Use the YouTubePlayer widget to play the trailer
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId:
                      YoutubePlayer.convertUrlToId(snapshot.data!) ?? '',
                  flags: YoutubePlayerFlags(autoPlay: true),
                ),
              ),
              Text(
                "Details:",
                style: TextStyle(color: Colors.white),
              ),
              FutureBuilder<String?>(
                future: _movieDetailsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...'); // Placeholder while loading
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Text('Error'); // Placeholder for error state
                  } else {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
