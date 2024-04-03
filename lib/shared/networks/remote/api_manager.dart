import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/PopularModel.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/end_points.dart';
import 'package:movies_app/shared/styles/app_strings.dart';

class ApiManager {
  static Future<PopularModel?> getPopular() async {
    try {
      Uri url = Uri.https(
          Constants.BASE_URL, EndPoints.Popular, {"apiKey": Constants.API_KEY});

      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});

      Map<String, dynamic> json =
          jsonDecode(response.body); //return json type to map.

      return PopularModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  getUpComing() {
    Uri url = Uri.https("api.themoviedb.org", "/3/movie/upcoming",
        {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
    http.get(url);
  }

  getTopRated() {
    Uri url = Uri.https("api.themoviedb.org", "/3/movie/top_rated",
        {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
    http.get(url);
  }

  getDetails() {
    Uri url = Uri.https("api.themoviedb.org", "/3/movie/top_rated",
        {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
    http.get(url);
  }

  getMoviesList() {
    Uri url = Uri.https("api.themoviedb.org", "/3/genre/movie/list",
        {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
    http.get(url);
  }
}
