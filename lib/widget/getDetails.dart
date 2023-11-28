import 'dart:developer';


import 'package:cinescape/api%20service/api.dart';
import 'package:cinescape/widget/topRatedMovieWidget.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class GetDetails extends  StatefulWidget{
   const GetDetails(
      {super.key,
      required this.image,
      required this.name,
      required this.summary,
      required this.rating,
      required this.genres,
      required this.language,
      required this.type,
      required this.premiered});

  final String name;
  final String language;
  final String rating;
  final List<dynamic> genres;
  final String image;
  final String summary;
  final String type;
  final String premiered;

  @override
  State<GetDetails> createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  late Future<List> allMoviesReversed;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMoviesReversed = Api().getReversedMovies();
    log("----------------->checking something at genres :- ${widget.genres.length}");

  }

  @override
  Widget build(BuildContext context) {

    String target = widget.summary.replaceAll(RegExp(r'<[^>]*>'),'');
    log("---------------------->target = $target");
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 394.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                      child: ReadMoreText(
                        target ,
                        style: const TextStyle(fontSize: 16, fontFamily: 'Satoshi'),
                        trimCollapsedText: 'Show More',
                        trimExpandedText: '   Show Less',
                        trimMode: TrimMode.Line,
                        trimLength: 4,
                        moreStyle:const TextStyle(fontSize: 12, fontFamily: 'Satoshi',color: Colors.white60),
                        lessStyle: const TextStyle(fontSize: 12, fontFamily: 'Satoshi',color: Colors.white60),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF292B37).withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF292B37).withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.cast,
                              size: 24,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF292B37).withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.download_outlined,
                              size: 24,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF292B37).withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              size: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recommended",style : TextStyle(fontSize: 16, fontFamily: 'Satoshi') ),
                          Text("See All",style : TextStyle(fontSize: 16, fontFamily: 'Satoshi',color: Colors.white24) ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                        child: FutureBuilder(
                          future: allMoviesReversed,
                          builder: (context, snapshot) {
                            if(snapshot.hasError){
                              return Center(child: Text(snapshot.error.toString()),);
                            }else if(snapshot.hasData){
                              return TopRatedMovieWidget(snapshot: snapshot,);
                            }else{
                              return const Center(child: CircularProgressIndicator(),);
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
          Stack(
          children: [
            Container(
              color: Colors.black,
              child: Hero(
                tag: 'movieBackground',
                child: Opacity(
                    opacity: 0.4,
                    child: Image.network(
                      widget.image,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: 240,
                      width: double.infinity,
                    )),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 240.0),
                  child: Container(
                    color: Colors.black,
                    height: 192,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.favorite_border,
                          size: 28,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.white60.withOpacity(0.4),
                                  )
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                widget.image,
                                height: 250,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 110.0, left: 96),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    color: Colors.red.withOpacity(0.4),
                                  )
                                ]),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF292B37).withOpacity(0.5),
                              ),
                              child:Text(widget.language,style: const TextStyle(fontSize: 12, fontFamily: 'Satoshi',))
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF292B37).withOpacity(0.5),
                            ),
                            child: Text(widget.premiered,style: const TextStyle(fontSize: 12, fontFamily: 'Satoshi',)),
                          ),

                          widget.genres.length > 1 ?
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF292B37).withOpacity(0.5),
                              ),
                              height: 38,
                              width: 116,
                              child:ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:widget.genres.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      if(index.isOdd )
                                      const VerticalDivider(color: Colors.red,),
                                      Text(widget.genres[0][index], style: const TextStyle(fontSize: 12, fontFamily: 'Satoshi',) ),


                                    ],
                                  );
                                },)
                          )
                              :  Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF292B37).withOpacity(0.5),
                              ),
                             /* height: 38,
                              width: 116,*/
                              child: Text(widget.genres[0][0].toString(), style: const TextStyle(fontSize: 12, fontFamily: 'Satoshi',) ),


                          ),
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF292B37).withOpacity(0.5),
                              ),
                              child:Text(widget.type,style: const TextStyle(fontSize: 12, fontFamily: 'Satoshi',))
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      color: Colors.red.withOpacity(0.2),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 20, fontFamily: 'Satoshi',fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),

          ],
        ),
      ]
      ),
    ));
  }
}
