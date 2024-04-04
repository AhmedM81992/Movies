import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/home_sub_items/details_page.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/widgets/containers/bookmark_container.dart';

class PopularContainer extends StatefulWidget {
  const PopularContainer({super.key});

  @override
  State<PopularContainer> createState() => _PopularContainerState();
}

class _PopularContainerState extends State<PopularContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3327,
      width: MediaQuery.of(context).size.width,
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
          return PageView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Image.network(
                          Constants.IMAGE_BASE_URL +
                              (moviesList[index].backdropPath ?? ""),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, DetailsPage.routeName,
                                  arguments: moviesList[index].id);
                            },
                            icon: Icon(
                              CupertinoIcons.play_circle_fill,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 90.0, left: 21),
                          child: Container(
                            width: 129,
                            height: 199,
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 160, top: 235),
                          child: Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moviesList[index].originalTitle ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                moviesList[index].releaseDate ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: moviesList.length,
          );
        },
      ),
    );
  }
}
