import 'dart:convert';
import 'package:http/http.dart' as http;
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
  static Future<ResponHeader> getResponsSimailar() async {

    var authority = 'api.themoviedb.org';
    var api_key = 'f9913dcdc3e455726868be0993e170fa';

    var url = Uri.https(authority, '/3/movie/top_rated',
        {'api_key': api_key, 'language': 'en-US', 'page': '1',});
    var respons = await http.get(url);
    var json = jsonDecode(respons.body);
    ResponHeader responsHeader = ResponHeader.fromJson(json);
    return responsHeader;
  }
}
//https://api.themoviedb.org/3/movie/latest?api_key=<<api_key>>&language=en-US
//https://api.themoviedb.org/3/movie/popular?api_key=f9913dcdc3e455726868be0993e170fa&language=en-US&page=1
//https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
// var url = Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=f9913dcdc3e455726868be0993e170fa&language=en-US');
//