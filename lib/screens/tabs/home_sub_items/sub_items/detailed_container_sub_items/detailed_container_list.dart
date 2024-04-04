import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/home_sub_items/details_page.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:movies_app/widgets/containers/bookmark_container.dart';

class DetailedContainerList extends StatefulWidget {
  const DetailedContainerList({super.key});

  @override
  State<DetailedContainerList> createState() => _DetailedContainerListState();
}

class _DetailedContainerListState extends State<DetailedContainerList> {
  String? movieId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    movieId = arguments is int ? arguments.toString() : arguments as String;
  }

  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.searchBox,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Like This', // Title
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          FutureBuilder(
            future: ApiManager.getSimilar(movieId!),
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
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 185,
                              width: 92,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, DetailsPage.routeName,
                                          arguments: moviesList[index].id);
                                    },
                                    child: Image.network(
                                      Constants.IMAGE_BASE_URL +
                                          (moviesList[index].posterPath ?? ""),
                                    ),
                                  ),
                                  MyBookmarkWidget(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 138),
                                    child: Container(
                                      color: Color(0xFF343534),
                                      width: 100,
                                      height: 300,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Color(0xFFFFBB3B),
                                              ),
                                              Text(
                                                moviesList[index]
                                                        .voteAverage
                                                        ?.toStringAsFixed(1) ??
                                                    "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            maxLines: 1,
                                            moviesList[index].title ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                moviesList[index].releaseDate ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
        ],
      ),
    );
  }
}
