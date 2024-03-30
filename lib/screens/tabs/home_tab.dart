import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: [
        Placeholder(
          fallbackHeight: 289,
          fallbackWidth: 412,
          color: Colors.white38,
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
                child: ListView.builder(
                  itemCount: 0, // Set the itemCount to 0 for an empty list
                  itemBuilder: (BuildContext context, int index) {
                    // This function won't be called since the itemCount is 0
                    return Container(); // Return an empty container
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
                'New Releases', // Title
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 1, // Set the itemCount to 0 for an empty list
                  itemBuilder: (BuildContext context, int index) {
                    // This function won't be called since the itemCount is 0
                    return Container(); // Return an empty container
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
