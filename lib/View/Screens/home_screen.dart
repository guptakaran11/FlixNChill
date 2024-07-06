//* Dart Packages
// import 'dart:developer';

//* Packages
import 'package:flutter/material.dart';

//* Services
import '../../Controller/Services/movie_service.dart';

//* Widgets
import '../Widgets/movie_slider.dart';
import '../Widgets/horizontal_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> popularMovies = [];
  List<dynamic> topRatedMovies = [];
  List<dynamic> upcomingMovies = [];
  List<dynamic> filteredMovies = [];

  bool isSearchEmpty = true;
  bool isLoading = true;

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: const TextField(
        autocorrect: true,
        decoration: InputDecoration(
          hintText: "Search Movies...",
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchMovies();
    super.initState();
  }

  fetchMovies() async {
    MovieServices movieServices = MovieServices();
    popularMovies = await movieServices.popularMovies();
    topRatedMovies = await movieServices.topRatedMovies();
    upcomingMovies = await movieServices.upcomingMovies();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          searchBar(),
          isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "TopRated Movies",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MovieSlider(topRatedMovies: topRatedMovies),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Upcoming Movies",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HorizontalView(movies: upcomingMovies),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Popular Movies",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HorizontalView(movies: popularMovies),
                  ],
                ),
        ],
      ),
    );
  }
}
