import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase/firebase_functions.dart';
import 'package:movies_app/models/ResultsModel.dart';
import 'package:movies_app/screens/tabs/search_sub_items/search_list_items.dart';

class WatchListTab extends StatefulWidget {
  WatchListTab({super.key});

  @override
  initState() {
    print("initState Called");
  }

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Watch List',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set title text color
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot<Results>>(
              future: FireBaseFunctions.getFavorites(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator());
                }
                var favorites = snapshot.data!.docs
                    .map((e) => e.data())
                    .toList();
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return SearchListItems(
                        result: favorites![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
