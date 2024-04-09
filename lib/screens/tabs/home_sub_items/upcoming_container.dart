import 'package:flutter/material.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/local/fetch_api.dart';
import 'package:movies_app/shared/networks/local/upcoming_local_database.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:movies_app/widgets/containers/bookmark_container.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'details_page.dart';

class UpComingContainer extends StatefulWidget {
  const UpComingContainer({Key? key}) : super(key: key);

  @override
  State<UpComingContainer> createState() => _UpComingContainerState();
}

class _UpComingContainerState extends State<UpComingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.searchBox,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.235,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'New Releases', // Title
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FetchAPI.getUpcoming(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Something Went Wrong!"));
                }
                var moviesList = snapshot.data?.results ?? [];
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailsPage.routeName,
                                  arguments: moviesList[index].id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: Constants.IMAGE_BASE_URL +
                                      (moviesList[index].posterPath ?? ""),
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            MyBookmarkWidget(),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: moviesList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
