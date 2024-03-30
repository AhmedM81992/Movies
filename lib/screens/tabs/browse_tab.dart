import 'package:flutter/material.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        color: Color(0xFF514F4F), // Set the background color
        padding: EdgeInsets.all(16), // Add padding for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Releases', // Title
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set title text color
              ),
            ),
            SizedBox(height: 8), // Add some vertical spacing
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Set the number of columns
                  crossAxisSpacing: 8, // Set spacing between columns
                  mainAxisSpacing: 8, // Set spacing between rows
                ),
                itemCount: 0, // Set the itemCount to 0 for an empty grid
                itemBuilder: (BuildContext context, int index) {
                  // This function won't be called since the itemCount is 0
                  return Container(); // Return an empty container
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
