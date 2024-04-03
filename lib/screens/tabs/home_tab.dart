import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:movies_app/widgets/containers/bookmark_container.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //String baseUrl = "https://image.tmdb.org/t/p/w500";
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: [
        // Placeholder(
        //   fallbackHeight: 289,
        //   fallbackWidth: 412,
        //   color: Colors.white38,
        // ),
        Container(
          height: 289,
          width: 412,
          child: FutureBuilder(
            future: ApiManager.getPopular(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something Went Wrong!"));
              }
              var moviesList = snapshot.data?.results ?? [];
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Image.network(
                    Constants.IMAGE_BASE_URL +
                        (moviesList[index].backdropPath ?? ""),
                  );
                },
                itemCount: moviesList.length,
              );
            },
          ),
        ),
        SizedBox(height: 24),
        Container(
          color: MyThemeData.searchBox,
          width: 420,
          height: 187,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Releases', // Title
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ApiManager.getUpComing(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Something Went Wrong!"));
                    }
                    var moviesList = snapshot.data?.results ?? [];
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Stack(
                                  children: [
                                    Image.network(
                                      Constants.IMAGE_BASE_URL +
                                          (moviesList[index].posterPath ?? ""),
                                    ),
                                    MyBookmarkWidget(),
                                  ],
                                ),
                              ));
                        },
                        itemCount: moviesList.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Container(
          color: MyThemeData.searchBox,
          width: 420,
          height: 187,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended', // Title
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ApiManager.getTopRated(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Something Went Wrong!"));
                    }
                    var moviesList = snapshot.data?.results ?? [];
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Stack(
                                children: [
                                  Image.network(
                                    Constants.IMAGE_BASE_URL +
                                        (moviesList[index].posterPath ?? ""),
                                  ),
                                  MyBookmarkWidget(),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: moviesList.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
