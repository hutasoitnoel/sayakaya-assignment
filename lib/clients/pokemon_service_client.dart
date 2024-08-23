import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vscode/classes/pokemon.dart';
import 'package:vscode/queries/getList.dart';
import 'package:vscode/queries/getDetails.dart';
import 'package:vscode/queries/getName.dart';

class PokemonServiceClient {
  final GraphQLClient _client;

  PokemonServiceClient(this._client);

  Future<List<Pokemon>> fetchPokemonList(int first) async {
    final QueryOptions options = QueryOptions(
      document: gql(getList),
      variables: {
        'first': first,
      },
    );
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final List<dynamic> pokemonList = result.data?['pokemons'] ?? [];
    return pokemonList.map((json) => Pokemon.fromJson(json)).toList();
  }

  Future<Pokemon> fetchPokemonDetails(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getDetails),
      variables: {
        'id': id,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final pokemonData = result.data?['pokemon'];
    if (pokemonData == null) {
      throw Exception('No Pokémon found');
    }

    return Pokemon.fromJson(pokemonData);
  }

  Future<Pokemon> fetchPokemonName(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getName),
      variables: {
        'id': id,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final pokemonData = result.data?['pokemon'];
    if (pokemonData == null) {
      throw Exception('No Pokémon found');
    }

    return Pokemon.fromJson(pokemonData);
  }
}
