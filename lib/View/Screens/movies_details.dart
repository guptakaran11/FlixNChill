//* Packages
import 'package:flutter/material.dart';

//* Services
import '../../Controller/Services/movie_service.dart';

//* Widgets
import '../Widgets/horizontal_view.dart';

class MoviesDetailScreen extends StatefulWidget {
  final dynamic movie;
  const MoviesDetailScreen({super.key, required this.movie});

  @override
  State<MoviesDetailScreen> createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  List<dynamic> similarMovies = [];

  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    MovieServices movieServices = MovieServices();
    similarMovies = await movieServices.similarMovies(widget.movie['id']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie['title']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${widget.movie['backdrop_path']}',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Title: ${widget.movie['title']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Overview: ${widget.movie['overview']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Release Date: ${widget.movie['release_date']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Rating: ${widget.movie['vote_average']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Vote Count: ${widget.movie['vote_count']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Popularity: ${widget.movie['popularity']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Similar Movies',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : HorizontalView(movies: similarMovies),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
