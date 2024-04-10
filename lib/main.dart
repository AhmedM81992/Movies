import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/providers/movie_detail_provider.dart';
import 'package:movies_app/providers/my_provider.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/tabs/home_sub_items/details_page.dart';
import 'package:movies_app/screens/tabs/home_sub_items/sub_items/detailed_container_sub_items/details_videoplayer.dart';
import 'package:movies_app/shared/networks/local/popular_local_database.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize LocalDatabase
  await PopularLocalDatabase.initDatabase();
  FirebaseFirestore.instance.disableNetwork();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => MovieDetailsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsPage.routeName: (context) => DetailsPage(),
        DetailsVideoPlayer.routeName: (context) {
          // Extract the movieId argument from the route settings
          final String? movieId =
              ModalRoute.of(context)?.settings.arguments as String?;
          // Return the DetailsVideoPlayer widget with the provided movieId
          return DetailsVideoPlayer(movieId: movieId!);
        },
      },
    );
  }
}
