import 'package:flutter/material.dart';
import 'package:movies_app/providers/my_provider.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "Home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: MyThemeData.primaryColor,
      bottomNavigationBar: Container(
        height: 90,
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
              provider.changeIndex(value);
            },
            currentIndex: provider.index,
            selectedItemColor: MyThemeData.SelectedColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: MyThemeData.whiteColor,
            selectedIconTheme: IconThemeData(color: MyThemeData.SelectedColor),
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
