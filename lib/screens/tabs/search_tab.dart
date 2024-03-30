import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

class SearchTab extends StatefulWidget {
  SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool isSearching = true;

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.primaryColor,
      body: isSearching
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 60),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff514F4F),
                ),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: MyThemeData.whiteColor),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white38),
                    prefixIcon:
                        Icon(Icons.search, color: MyThemeData.whiteColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: MyThemeData
                            .whiteColor, // Change this color to your liking
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: MyThemeData
                            .whiteColor, // Change this color to your liking
                      ),
                    ),
                  ),
                  onChanged: (value) async {
                    // Your search logic here
                    setState(() {});
                  },
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/novideo.png"),
                ],
              ),
            ),
    );
  }
}
