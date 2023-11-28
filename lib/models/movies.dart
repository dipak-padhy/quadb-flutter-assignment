import 'dart:core';

class Movie{
  String name;
  String language;
  double rating;
  List<String> genres;
  String image;
  String summary;
  String type;
  String premiered;

  Movie({required this.name,required this.language,required this.rating,required this.genres,required this.image,required this.summary,required this.type,required this.premiered});

  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      name: json["show"]["name"],
      rating: json["show"]["rating"]["average"],
      genres: json["show"]["genres"],
      image: json["show"]["image"]["original"],
      language: json["show"]["language"],
      summary: json["show"]["summary"],
      type: json["show"]["type"],
        premiered:json["show"]["premiered"],
    );
  }
}