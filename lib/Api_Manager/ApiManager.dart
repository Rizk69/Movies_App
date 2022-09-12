import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ResponsData/category.dart';
import '../ResponsData/respon_header.dart';

class ApiManager {
  static Future<ResponHeader> getResponsHeader() async {
    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';

    var url = Uri.https(authority, '/3/movie/popular',
        {'api_key': api_key, 'language': 'en-US', 'page': '1'});
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    ResponHeader responsHeader = ResponHeader.fromJson(json);
    return responsHeader;
  }

  static Future<ResponHeader> getResponsTopRated() async {
    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';
    var url = Uri.https(authority, '/3/movie/top_rated',
        {'api_key': api_key, 'language': 'en-US', 'page': '1'});
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    ResponHeader responsHeader = ResponHeader.fromJson(json);
    return responsHeader;
  }

  static Future<ResponHeader> getResponsSimailar(int id) async {
//https://api.themoviedb.org/3/movie/610150/similar?api_key=f9913dcdc3e455726868be0993e170fa&movie_id=610150
    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';

    var url = Uri.https(authority, '/3/movie/$id/similar', {
      'api_key': api_key,
      'language': 'en-US',
      'page': '1',
      'movie_id': '$id'
    });
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    ResponHeader responsHeader = ResponHeader.fromJson(json);
    return responsHeader;
  }

  static Future<ResponHeader> getResponsSearch(String query) async {
    //https://api.themoviedb.org/3/search/movie?api_key=f9913dcdc3e455726868be0993e170fa&language=en-US&page=1&include_adult=false
    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';

    var url = Uri.https(authority, '/3/search/movie',
        {'api_key': api_key, 'language': 'en-US', 'page': '1', 'query': query});
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    ResponHeader responsHeader = ResponHeader.fromJson(json);
    return responsHeader;
  }

  static Future<CategoryData> getResponsCategory() async {
    //https://api.themoviedb.org/3/genre/movie/list?api_key=f9913dcdc3e455726868be0993e170fa&language=en-US
    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';

    var url = Uri.https(authority, '/3/genre/movie/list',
        {'api_key': api_key, 'language': 'en-US'});
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    CategoryData responsHeader = CategoryData.fromJson(json);
    return responsHeader;
  }

  static Future<ResponHeader> getResponsCategoryDateails(String id) async {
    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';
    var url = Uri.https(authority, '/3/discover/movie',
        {'api_key': api_key, 'language': 'en-US', 'sort_by': id});
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    ResponHeader responsHeader = ResponHeader.fromJson(json);
    return responsHeader;
  }
}
