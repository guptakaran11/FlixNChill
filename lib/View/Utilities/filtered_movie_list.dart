// ignore_for_file: must_be_immutable
//* Packages

import 'package:flutter/material.dart';

//* Screens
import '../Screens/movies_details.dart';

class FilteredMovieList extends StatelessWidget {
  List<dynamic> movies;

  FilteredMovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesDetailScreen(
                    movie: movie,
                  ),
                ),
              );
            },
            leading: Image.network(
              'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
              width: 70,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            title: Text(movie['title']),
            subtitle: Text(movie['overview']),
          );
        },
      ),
    );
  }
}
