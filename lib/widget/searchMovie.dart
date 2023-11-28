
import 'package:cinescape/api%20service/api.dart';
import 'package:cinescape/widget/getDetails.dart';
import 'package:flutter/material.dart';

class SearchMovie extends SearchDelegate {

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new));
  }

  final Api  _movieList = Api();


  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _movieList.getMoviesSearch(query),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: Colors.red.withOpacity(0.8),),
          );
        }
          if(snapshot.data!.length == 0) {
            return Center(
              child: Text(":( Oops, It's not available.",style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 16,
                  color: Colors.red.withOpacity(1)
              ),),
            );
          }
       else{
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(
                      8.0, 12, 8, 4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator
                          .of(context)
                          .push(MaterialPageRoute(builder: (context) =>
                          GetDetails(name: data[index]['name'],
                            image: data[index]['image']['original'],
                            language: data[index]['language'],
                            premiered: data[index]['premiered'],
                            rating: data[index]['rating']['average']
                                .toString(),
                            summary: data[index]['summary'],
                            type: data[index]['type'],
                            genres: getGenres(index, data),)));
                    },
                    child: Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 2,
                      shadowColor: Colors.red,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              8.0, 24, 0, 4),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: data[index]['image']['original'] !=
                                          null
                                          ? Image.network(
                                        data[index]['image']['original'],)
                                          : const Text(":( No photos")),
                                  SizedBox(
                                      width: 180,
                                      child: Text(data[index]['name'],
                                        style: const TextStyle(fontSize: 14,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,)),
                                  Column(
                                    children: [
                                      data[index]['rating']['average'] != null
                                          ?
                                      TextButton.icon(onPressed: () {},
                                          icon: Icon(Icons.star,
                                            color: Colors.yellow.withOpacity(
                                                0.8), size: 20,),
                                          label: Text(
                                            data[index]['rating']['average']
                                                .toString(),
                                            style: const TextStyle(fontSize: 11,
                                                fontFamily: 'Satoshi',
                                                color: Colors.white38),))
                                          : TextButton.icon(onPressed: () {},
                                          icon: Icon(Icons.star,
                                            color: Colors.yellow.withOpacity(
                                                0.4), size: 20,),
                                          label: const Text(
                                              "-",
                                              style: TextStyle(fontSize: 10,
                                                  fontFamily: 'Satoshi',
                                                  color: Colors.white38))),
                                      Text(data[index]['language'],
                                          style: const TextStyle(fontSize: 12,
                                              fontFamily: 'Satoshi',
                                              color: Colors.white38))
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 12,),
                              //  const Divider(),
                            ],
                          ),
                        ),
                        subtitle: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF292B37).withOpacity(
                                        0.5),
                                  ),
                                  height: 38,
                                  width: 344,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Text(
                                          "Premiered on : ${data[index]['premiered']}",
                                          style: const TextStyle(fontSize: 11,
                                            fontFamily: 'Satoshi',)),
                                      const VerticalDivider(color: Colors.red,),
                                      Text("${data[index]['runtime']
                                          .toString()} mins",
                                          style: const TextStyle(fontSize: 11,
                                            fontFamily: 'Satoshi',)),
                                      const VerticalDivider(color: Colors.red,),
                                      Text(data[index]['type'],
                                          style: const TextStyle(fontSize: 11,
                                            fontFamily: 'Satoshi',)),
                                    ],
                                  )
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },);

        }

      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Search Your Favourite Shows",style: TextStyle(fontFamily: 'Satoshi',fontSize: 16,color: Colors.white54),),) ;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.close))
    ];
  }
  getGenres(int index,var data) {
    List genres = [];
    var query = data[index]['genres'];
    query.forEach(
            (x) => genres.add(data[index]['genres'])
    );

    return genres;
  }

}

/*Card(
child: ListTile(
title: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(
height: 200,
width: 60,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8)
),
child: Image.network(data[index]['image']['original']),
),
const SizedBox(width: 12,),
Text(data[index]['name']),
Text(data[index]['language'])
],
),
),);*/


