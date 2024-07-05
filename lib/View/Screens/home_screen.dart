//* Dart Packages
import 'dart:developer';

//* Packages
import 'package:flutter/material.dart';

//* Services
import '../../Controller/Services/movie_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget searchBar() {
    return Container(
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
    printData();
    super.initState();
  }

  printData() {
    MovieServices movieServices = MovieServices();
    final data = movieServices.popularMovies();
    log(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          searchBar(),
        ],
      ),
    );
  }
}
