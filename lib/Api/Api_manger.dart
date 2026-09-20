import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/Api/api_constants.dart';
import 'package:movie_app/Api/end_point.dart';
import 'package:movie_app/models/movies_response.dart';

class ApiManger {
  static Future<MoviesResponse> getMoviesList() async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieApi);

    try {
      var response = await http.get(url).timeout(const Duration(seconds: 10));
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesResponse.fromJson(json);
    } on SocketException {
      throw Exception('تأكد من اتصالك بالإنترنت');
    } on TimeoutException {
      throw Exception('الاتصال بطيء جدًا، حاول تاني');
    } catch (e) {
      rethrow;
    }
  }

  static Future<MoviesResponse?> getMovieByName(String movieTitle) async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieApi,
        {'query_term': movieTitle});
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 10));
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesResponse.fromJson(json);
    } on SocketException {
      throw Exception('تأكد من اتصالك بالإنترنت');
    } on TimeoutException {
      throw Exception('الاتصال بطيء جدًا، حاول تاني');
    } catch (e) {
      rethrow;
    }
  }

  static Future<Movies?> getMovieDetails(int movieId) async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieDetailsApi,
        {'movie_id': movieId.toString()});
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 10));
      var json = jsonDecode(response.body);
      return Movies.fromJson(json['data']['movie']);
    } on SocketException {
      throw Exception('تأكد من اتصالك بالإنترنت');
    } on TimeoutException {
      throw Exception('الاتصال بطيء جدًا، حاول تاني');
    } catch (e) {
      rethrow;
    }
  }

  // Enhanced method to get movie details with cast information
  static Future<Movies?> getMovieDetailsWithCast(int movieId) async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieDetailsApi, {
      'movie_id': movieId.toString(),
      'with_cast': 'true',
      'with_images': 'true'
    });

    try {
      var response = await http.get(url).timeout(const Duration(seconds: 10));
      var json = jsonDecode(response.body);
      return Movies.fromJson(json['data']['movie']);
    } on SocketException {
      throw Exception('تأكد من اتصالك بالإنترنت');
    } on TimeoutException {
      throw Exception('الاتصال بطيء جدًا، حاول تاني');
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Movies>> getMovieSuggestions(int movieId) async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl,
        EndPoint.movieSuggestionsApi, {'movie_id': movieId.toString()});
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 10));
      var json = jsonDecode(response.body);
      List list = json['data']['movies'] ?? [];
      return list.map((e) => Movies.fromJson(e)).toList();
    } on SocketException {
      throw Exception('تأكد من اتصالك بالإنترنت');
    } on TimeoutException {
      throw Exception('الاتصال بطيء جدًا، حاول تاني');
    } catch (e) {
      rethrow;
    }
  }
}