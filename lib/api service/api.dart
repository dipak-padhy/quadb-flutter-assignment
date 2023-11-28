import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;

class Api {
  static const _movieUrl = "https://api.tvmaze.com/search/shows?q=all";

  Future<List> getMovies() async {
    final response = await http.get(Uri.parse(_movieUrl));
    log("----------------------->response ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = response.body;
      final decodedData = jsonDecode(data);
      //   log("----------------------->Decoded data = ${decodedData}");
      final MovieList = [];

      decodedData.forEach(
              (x) {
            MovieList.add(x['show']);
          }
      );
      log("----------------------->Decoded data = $MovieList");
      MovieList.removeRange(2, 4);
      return MovieList;
    } else {
      log("---------------------------------------->error");
      throw Exception("ërror");
    }
  }


  Future<List> getMoviesSearch(String query) async {

    final response = await http.get(
        Uri.parse("https://api.tvmaze.com/search/shows?q=$query"));
    log("----------------------->response ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = response.body;
      final decodedData = jsonDecode(data);

      final results = [];
      decodedData.forEach(
              (x) {
            results.add(x['show']);
          }
      );
      //results = decodedData.map((e) => Movie.fromJson(e)).toList();
      log("----------------------->searching Decoded data = $results");
      return results;
    }
    else {
      log("------------------------>error while searchng");
      throw Exception("error while searchng");
    }
  }

    Future<List> getReversedMovies() async {
      final response = await http.get(Uri.parse(_movieUrl));
      log("----------------------->response ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = response.body;
        final decodedData = jsonDecode(data);
        //   log("----------------------->Decoded data = ${decodedData}");
        final MovieList = [];

        //final reversedMovieList = [];

        decodedData.forEach(
                (x) {
              if (x['show']['rating']['average'] != null) {
                MovieList.add(x['show']);
              }
            }
        );


        log("----------------------->Decoded data = $MovieList");
        return MovieList;
      } else {
        log("---------------------------------------->error");
        throw Exception("ërror");
      }
    }

    Future<List> getGenres() async {
      final response = await http.get(Uri.parse(_movieUrl));
      log("----------------------->response ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = response.body;
        final decodedData = jsonDecode(data);
        //   log("----------------------->Decoded data = ${decodedData}");
        final MovieList = [];

        //final reversedMovieList = [];

        decodedData.forEach(
                (x) {
              if (x['show']['rating']['average'] == null) {
                MovieList.add(x['show']);
              }
            }
        );


        log("----------------------->Decoded data = $MovieList");
        MovieList.removeRange(1, 3);
        return MovieList;
      } else {
        log("---------------------------------------->error");
        throw Exception("ërror");
      }
    }


    Future<List> getUpcomingMovies() async {
      final response = await http.get(Uri.parse(_movieUrl));
      log("----------------------->response ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = response.body;
        final decodedData = jsonDecode(data);
        //  log("----------------------->Decoded data = ${decodedData}");
        final MovieList = [];

        //final reversedMovieList = [];

        decodedData.forEach(
                (x) {
              if (x['show']['rating']['average'] == null) {
                MovieList.add(x['show']);
              }
            }
        );


        log("----------------------->Upcoming data = $MovieList");
        //MovieList.removeRange(1, 3);
        MovieList.removeLast();
        return MovieList;
      } else {
        log("---------------------------------------->error");
        throw Exception("ërror");
      }
    }
  }
