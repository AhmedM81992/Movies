import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/DetailsModel.dart';
import 'package:movies_app/models/PopularModel.dart';
import 'package:movies_app/models/SimilarToModel.dart';
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
          {"apiKey": Constants.API_KEY});
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
          {"apiKey": Constants.API_KEY});
      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
      http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      return TopRatedModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<DetailsModel?> getDetails(String id) async {
    try {
      Uri url = Uri.https(Constants.BASE_URL, EndPoints.Details + id);
      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
      Map<String, dynamic> json = jsonDecode(response.body);
      return DetailsModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<SimilarToModel?> getSimilar(String id) async {
    try {
      Uri url = Uri.https(Constants.BASE_URL, EndPoints.Details + id + EndPoints.Similar);
      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
      Map<String, dynamic> json = jsonDecode(response.body);
      return SimilarToModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  getMoviesList() {
    Uri url = Uri.https(Constants.BASE_URL, "/3/genre/movie/list",
        {"apiKey": Constants.API_KEY});
    http.get(url);
  }
}
