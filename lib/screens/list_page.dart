import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vscode/classes/pokemon.dart';

// Screens
import 'details_page.dart';

// Services
import 'package:vscode/clients/pokemon_service_client.dart';

class ListPage extends StatefulWidget {
  final PokemonServiceClient pokemonServiceClient;

  const ListPage({super.key, required this.pokemonServiceClient});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ListPage> {
  static const int _pageSize = 20;
  int _fetchedItemCount = 0;

  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      fetchPokemons(pageKey);
    });
  }

  Future<void> fetchPokemons(int pageKey) async {
    try {
      final List<Pokemon> fetchedPokemons = await widget.pokemonServiceClient
          .fetchPokemonList(pageKey + _pageSize);

      final List<Pokemon> newItems = fetchedPokemons.sublist(_fetchedItemCount);

      _fetchedItemCount += newItems.length;

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = _fetchedItemCount;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/pokedex_icon.png')),
        title: const Text(
          "Pokedex",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: PagedListView<int, dynamic>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          itemBuilder: (context, pokemon, index) => ListTile(
            leading: Image.network(
              pokemon.image ?? '',
              width: 50,
            ),
            title: Text('#${pokemon.number} ${pokemon.name}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    id: pokemon.id,
                    pokemonServiceClient: widget.pokemonServiceClient,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
