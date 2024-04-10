import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/ResultsModel.dart';
import 'package:movies_app/screens/tabs/home_sub_items/details_page.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

class SearchListItems extends StatelessWidget {
  final Results result;

  const SearchListItems({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.14,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, DetailsPage.routeName,
                      arguments: result.id);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width *
                            0.485,
                    height:
                        MediaQuery.of(context).size.height *
                            0.118,
                    child: CachedNetworkImage(
                      imageUrl: Constants.IMAGE_BASE_URL +
                          (result.backdropPath ?? ""),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context,
                              url, downloadProgress) =>
                          Center(
                              child:
                                  CircularProgressIndicator(
                                      value:
                                          downloadProgress
                                              .progress)),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.476,
                height: MediaQuery.of(context).size.height *
                    0.118,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      Text(
                        result.releaseDate ?? "",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Color(0xFFFFBB3B),
                          ),
                          Text(
                            result.voteAverage
                                    ?.toStringAsFixed(1) ??
                                "",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: MyThemeData.searchBox,
            endIndent: 10,
            indent: 10,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
