import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cinescape/api%20service/api.dart';
import 'package:cinescape/widget/searchMovie.dart';
import 'package:cinescape/widget/topRatedMovieWidget.dart';
import 'package:cinescape/widget/trendingMovieWidget.dart';
import 'package:cinescape/widget/upcomingMovieWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinescape',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const splashScreen(),
    );
  }
}



class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splash: Padding(
        padding: const EdgeInsets.only(top: 44.0),
        child: Container(
       //   color: Colors.orange,
          width: 240,
          //height: 40000,
          child:Image.asset(
          "assets/images/output-onlinegiftools.gif",
          fit: BoxFit.cover,
          filterQuality : FilterQuality.high ,
        ),
        )
      ),
      splashIconSize: 100.0,
      duration: 1400,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(milliseconds: 800),
      nextScreen: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {

  int myIndex=0;

  late Future<List> allMovies;
  late Future<List> allMoviesReversed;
  late Future<List> allUpcomingMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMovies = Api().getMovies();
    allMoviesReversed = Api().getReversedMovies();
    allUpcomingMovies=Api().getUpcomingMovies();
    log("----------------->allMovies = ${allMovies.toString()}");
  }

  callSearchScreen() {
    return showSearch(context: context, delegate: SearchMovie());
  }

  List widgetList = [
    const MyHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 180, child: Image.asset("assets/images/CINESCAPE-11-27-2023.png",filterQuality: FilterQuality.high,)),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Trending Movies" ,style: TextStyle(fontSize: 16,fontFamily: 'Satoshi',fontWeight: FontWeight.w900),),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      child: Stack(
                        children:[ FutureBuilder(
                        future: allMovies,
                  builder: (context, snapshot){
                          if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }else if(snapshot.hasData){
                            return trendingMovieWidget(snapshot: snapshot,);
                          }else{
                            return const Center(child: CircularProgressIndicator(),);
                          }
                  },),
                          Padding(
                            padding: const EdgeInsets.only(top: 166.0),
                            child: Container(
                              height: 190,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.black54,Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 40.0,top:116),
                                      child: Column(
                                        children: [
                                          Icon(Icons.add),
                                          Text(
                                            "List",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 130.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        child: ElevatedButton.icon(
                                          onPressed: null,
                                          label: const Text(
                                            "Play",
                                            style: TextStyle(
                                                fontFamily: 'Satoshi',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          icon: const Icon(Icons.play_arrow,color: Colors.black,),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 40.0,top:118),
                                      child: Column(
                                        children: [
                                          Icon(Icons.info_outline),
                                          Text(
                                            "Info",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ]
                      )),
                  const SizedBox(height: 16,),
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                    child:  Text("Top Rated Movies",style: TextStyle(fontSize: 16,fontFamily: 'Satoshi',fontWeight: FontWeight.w900),),
                  ),
                 // const SizedBox(height: 4,),
                  SizedBox(child: FutureBuilder(
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
                  const SizedBox(height: 16,),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                    child: Text("Upcoming Movies",style: TextStyle(fontSize: 16,fontFamily: 'Satoshi',fontWeight: FontWeight.w900),),
                  ),
                  SizedBox(child: FutureBuilder(
                    future: allUpcomingMovies,
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString()),);
                        }else if(snapshot.hasData){
                          return upcomingMovieWidget(snapshot: snapshot,);
                        }else{
                          return const Center(child: CircularProgressIndicator(),);
                        }
                      },
                  ))
                ],
              ),
            ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            fixedColor: Colors.red,
            showUnselectedLabels: false,
            onTap: (value) {
              if(value != 1) {
                setState(() {
                  myIndex = value;
                });
              }else{
                showSearch(context: context, delegate: SearchMovie());
              }
            },
              currentIndex: myIndex,
              items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search')
          ]),
        )
    );
  }


}



