import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/screens/tabs/home_sub_items/popular_container.dart';
import 'package:movies_app/screens/tabs/home_sub_items/top_rated_container.dart';
import 'package:movies_app/screens/tabs/home_sub_items/upcoming_container.dart';

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
        PopularContainer(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.010),
        UpComingContainer(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.010),
        TopRatedContainer(),
      ]),
    );
  }
}
