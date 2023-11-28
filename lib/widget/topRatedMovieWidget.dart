import 'package:cinescape/widget/getDetails.dart';
import 'package:flutter/material.dart';

class TopRatedMovieWidget extends StatelessWidget {
  const TopRatedMovieWidget({
    super.key, required this.snapshot
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 308,
      // color: Colors.greenAccent,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (context) =>
                        GetDetails(name: snapshot.data[index]['name'],
                          image: snapshot.data[index]['image']['original'],
                          language: snapshot.data[index]['language'],
                          premiered: snapshot.data[index]['premiered'],
                          rating: snapshot.data[index]['rating']['average']
                              .toString(),
                          summary: snapshot.data[index]['summary'],
                          type: snapshot.data[index]['type'],
                          genres: getGenres(index),)));
                    },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                      /*  boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              offset: Offset.fromDirection(1,1),
                            blurRadius: 8
                          ),
                        ]*/
                    ),
                    width: 150,
                    height: 230,
                    child: Image.network(
                      snapshot.data[index]['image']['original'],
                      filterQuality: FilterQuality.high, fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(height: 8,),
                Text(snapshot.data[index]['name'],
                  style: const TextStyle(fontSize: 14, fontFamily: 'Satoshi'),),
                SizedBox(
                  //  color: Colors.orange,
                  width: 160,
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(snapshot.data[index]['language'],
                        style: const TextStyle(fontSize: 10,
                            fontFamily: 'Satoshi',
                            color: Colors.white38),),
                      TextButton.icon(onPressed: () {},
                        icon: Icon(Icons.star, color: Colors.yellow.withOpacity(
                            0.8), size: 20,),
                        label: Text(snapshot.data[index]['rating']['average']
                            .toString(), style: const TextStyle(fontSize: 10,
                            fontFamily: 'Satoshi',
                            color: Colors.white38),),)
                    ],
                  ),
                ),


              ],
            ),
          );
        },),
    );
  }

  getGenres(int index) {
    List genres = [];
    var query = snapshot.data[index]['genres'];
    query.forEach(
        (x) => genres.add(snapshot.data[index]['genres'])
    );

    return genres;
  }
}