import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/PopularModel.dart';
import 'package:movies_app/models/TopRatedModel.dart';
import 'package:movies_app/models/UpComingModel.dart';
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

  static Future<UpComingModel?> getUpComing() async {
    try {
      Uri url = Uri.https(Constants.BASE_URL, EndPoints.UpComing,
          {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
      http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      return UpComingModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<TopRatedModel?> getTopRated() async {
    try {
      Uri url = Uri.https(Constants.BASE_URL, EndPoints.TopRated,
          {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
      http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      return TopRatedModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  getDetails() {
    Uri url = Uri.https(Constants.BASE_URL, "/3/movie/top_rated",
        {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
    http.get(url);
  }

  getMoviesList() {
    Uri url = Uri.https(Constants.BASE_URL, "/3/genre/movie/list",
        {"apiKey": dotenv.env['HTTP_API_KEY_BROWSER']});
    http.get(url);
  }
}
