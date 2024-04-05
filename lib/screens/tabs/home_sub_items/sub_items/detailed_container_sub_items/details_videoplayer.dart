import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import SystemChrome
import 'package:movies_app/screens/tabs/home_sub_items/details_page.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:movies_app/widgets/containers/bookmark_container.dart';
import 'package:movies_app/widgets/containers/full_screen_video_player.dart';
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
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _trailerUrlFuture = _fetchTrailerUrl();
    _movieTitleFuture = _fetchMovieTitle();
    _movieDetailsFuture = _fetchMovieDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<String?> _fetchTrailerUrl() async {
    try {
      final details = await ApiManager.getTrailer(widget.movieId);
      final trailer = details?.results?.firstWhere(
        (video) => video.type == 'Trailer',
        orElse: () => Results(),
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
      appBar: !_isFullScreen
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true, // Set to false
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
            )
          : null,
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

          _controller = YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(snapshot.data!) ?? '',
            flags: YoutubePlayerFlags(autoPlay: true),
          );

          // Use the YouTubePlayer widget to play the trailer
          return Stack(
            alignment: Alignment.center,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  print('Player is ready.');
                },
                onEnded: (data) {
                  print('Video has ended.');
                },
              ),
              if (!_isFullScreen)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: !_isFullScreen
          ? Builder(
              builder: (context) {
                final snapshot = _trailerUrlFuture;
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 360, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details:",
                            style: TextStyle(color: Colors.white),
                          ),
                          FutureBuilder<String?>(
                            future: _movieDetailsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                    'Loading...'); // Placeholder while loading
                              } else if (snapshot.hasError ||
                                  !snapshot.hasData) {
                                return Text(
                                    'Error'); // Placeholder for error state
                              } else {
                                return Text(
                                  snapshot.data!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 285, left: 355),
                      child: FloatingActionButton(
                        foregroundColor: MyThemeData.whiteColor,
                        backgroundColor: MyThemeData.searchBox,
                        onPressed: () {
                          setState(() {
                            _isFullScreen = true;
                          });
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                          snapshot.then((data) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenVideoPlayer(
                                  videoUrl: data!,
                                ),
                              ),
                            ).then((value) {
                              setState(() {
                                _isFullScreen = false;
                              });
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                              ]);
                            });
                          });
                        },
                        child: Icon(Icons.fullscreen),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 480, left: 5),
                      child: Container(
                        color: MyThemeData.searchBox,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.39,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Recommended",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: FutureBuilder(
                                future: ApiManager.getPopular(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                        child: Text("Something Went Wrong!"));
                                  }
                                  var moviesList = snapshot.data?.results ?? [];
                                  return ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        DetailsPage.routeName,
                                                        arguments:
                                                            moviesList[index]
                                                                .id);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: Constants
                                                              .IMAGE_BASE_URL +
                                                          (moviesList[index]
                                                                  .posterPath ??
                                                              ""),
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context,
                                                              url,
                                                              downloadProgress) =>
                                                          Center(
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress)),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                MyBookmarkWidget(),
                                              ],
                                            ),
                                          ));
                                    },
                                    itemCount: moviesList.length,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          : null,
    );
  }
}
