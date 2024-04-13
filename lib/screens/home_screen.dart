import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/providers/my_provider.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: MyThemeData.primaryColor,
      body: Container(
        //height: MediaQuery.of(context).size.height,
        child: provider.tabs[provider.index],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.0748,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 10,
                blurRadius: 10,
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: MyThemeData.primaryColor,
            onTap: (value) {
              setState(() {
                provider.changeIndex(value);
              });
            },
            iconSize: 20,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            currentIndex: provider.index,
            selectedItemColor: MyThemeData.selectedColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: MyThemeData.whiteColor,
            selectedIconTheme: IconThemeData(color: MyThemeData.selectedColor),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.house), label: "HOME"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "SEARCH"),
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: "BROWSE"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: "WATCHLIST"),
            ],
          ),
        ),
      ),
    );
  }
}
