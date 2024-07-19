import 'package:flutter/material.dart';
import '../../Controller/Services/movie_service.dart';
import '../Widgets/movie_slider.dart';
import '../Widgets/horizontal_view.dart';
import '../Utilities/filtered_movie_list.dart';

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

  void filterMovies(String query) {
    setState(() {
      filteredMovies = popularMovies
              .where((movie) =>
                  movie['title'].toLowerCase().contains(query.toLowerCase()))
              .toList() +
          upcomingMovies
              .where((movie) =>
                  movie['title'].toLowerCase().contains(query.toLowerCase()))
              .toList() +
          topRatedMovies
              .where((movie) =>
                  movie['title'].toLowerCase().contains(query.toLowerCase()))
              .toList();
      if (query.isEmpty) {
        isSearchEmpty = true;
      } else {
        isSearchEmpty = false;
      }
    });
  }

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
      child: TextField(
        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              isSearchEmpty = true;
            });
          } else {
            filterMovies(value);
          }
        },
        autocorrect: true,
        decoration: const InputDecoration(
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
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : !isSearchEmpty
                          ? Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'Filtered Movies',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  child:
                                      FilteredMovieList(movies: filteredMovies),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    "Top Rated Movies",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                MovieSlider(topRatedMovies: topRatedMovies),
                                const SizedBox(height: 20),
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
                                const SizedBox(height: 20),
                                HorizontalView(movies: upcomingMovies), // this is the widget such that to create the list of cards ion horizontally
                                const SizedBox(height: 20),
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
                                const SizedBox(height: 20),
                                HorizontalView(movies: popularMovies),
                              ],
                            ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: searchBar(),
          ),
        ],
      ),
    );
  }
}
