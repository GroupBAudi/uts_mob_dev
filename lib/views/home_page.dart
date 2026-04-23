import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/custom_loading.dart';
import '../widgets/custom_error.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieProvider>().fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const CustomLoadingWidget()
          : provider.errorMessage.isNotEmpty && provider.movies.isEmpty
              ? CustomErrorWidget(
                  message: provider.errorMessage,
                  onRetry: () => provider.fetchMovies(),
                )
              : Column(
                  children: [
                    if (provider.isOffline)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        color: Colors.orange.shade100,
                        child: Text(
                          provider.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          provider.searchMovies(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari film...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: provider.getGenres().map((genre) {
                            final isSelected =
                                provider.selectedGenre == genre;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(genre),
                                selected: isSelected,
                                onSelected: (_) {
                                  provider.filterByGenre(genre);
                                  provider.searchMovies(searchController.text);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: provider.movies.isEmpty
                          ? const Center(
                              child: Text('Tidak ada data yang cocok.'),
                            )
                          : ListView.builder(
                              itemCount: provider.movies.length,
                              itemBuilder: (context, index) {
                                final movie = provider.movies[index];
                                return MovieCard(movie: movie);
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}