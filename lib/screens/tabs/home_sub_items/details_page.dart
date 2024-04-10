import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/home_sub_items/sub_items/detailed_container_sub_items/detailed_container_list.dart';
import 'package:movies_app/screens/tabs/home_sub_items/sub_items/detailed_container_sub_items/details_videoplayer.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = "Details";
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? movieId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)!.settings.arguments;
    movieId = arguments is int
        ? arguments.toString()
        : arguments as String;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: FutureBuilder(
          future: ApiManager.getDetails(movieId!),
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
            var movieDetail = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                child: Stack(
                  children: [
                    Text(
                      movieDetail?.title ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: ApiManager.getDetails(movieId!),
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
          var movieDetail = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(0.1),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: Constants.IMAGE_BASE_URL +
                            (movieDetail?.backdropPath ??
                                ""),
                        height: MediaQuery.of(context)
                                .size
                                .height *
                            0.235,
                        width: MediaQuery.of(context)
                                .size
                                .width *
                            1,
                        fit: BoxFit.fitWidth,
                        progressIndicatorBuilder: (context,
                                url, downloadProgress) =>
                            Center(
                                child:
                                    CircularProgressIndicator(
                                        value:
                                            downloadProgress
                                                .progress)),
                        errorWidget:
                            (context, url, error) =>
                                Icon(Icons.error),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 55),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                DetailsVideoPlayer
                                    .routeName,
                                arguments:
                                    movieId, // Pass the movieId to the DetailsVideoPlayer page
                              );
                            },
                            icon: Icon(
                              CupertinoIcons
                                  .play_circle_fill,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context)
                              .size
                              .height *
                          0.005),
                  Row(
                    children: [
                      Text(
                        movieDetail?.title ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        movieDetail?.releaseDate ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context)
                              .size
                              .height *
                          0.005),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),
                        child: Container(
                          width: MediaQuery.of(context)
                                  .size
                                  .width *
                              0.4,
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: Constants
                                        .IMAGE_BASE_URL +
                                    (movieDetail
                                            ?.posterPath ??
                                        ""),
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context,
                                        url,
                                        downloadProgress) =>
                                    Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress
                                                .progress)),
                                errorWidget:
                                    (context, url, error) =>
                                        Icon(Icons.error),
                              ),
                              // MyBookmarkWidget(
                              //   moviesList: movieDetail,
                              // )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 170.0),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing:
                                  10, // gap between adjacent chips
                              runSpacing:
                                  7, // gap between lines
                              children: movieDetail?.genres
                                      ?.map((genre) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      12),
                                          border: Border.all(
                                              color: Color(
                                                  0xFF514F4F),
                                              width: 1)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets
                                                .all(13.0),
                                        child: Text(
                                          genre.name ?? '',
                                          style: TextStyle(
                                              color: Colors
                                                  .white,
                                              fontSize: 10,
                                              fontWeight:
                                                  FontWeight
                                                      .w400),
                                        ),
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context)
                                            .size
                                            .height *
                                        0.009),
                            Text(
                              maxLines: 6,
                              movieDetail?.overview ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.w400),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context)
                                            .size
                                            .height *
                                        0.009),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 25,
                                  color: Color(0xFFFFBB3B),
                                ),
                                Text(
                                  movieDetail?.voteAverage
                                          ?.toStringAsFixed(
                                              1) ??
                                      "",
                                  style: TextStyle(
                                      fontWeight:
                                          FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context)
                              .size
                              .height *
                          0.005),
                  Container(
                    height:
                        MediaQuery.of(context).size.height *
                            0.26,
                    width:
                        MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: DetailedContainerList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
