import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// Screens
import 'screens/list_page.dart';
// Services
import 'clients/pokemon_service_client.dart';

void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink('https://graphql-pokemon2.vercel.app');

  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );

  final pokemonServiceClient = PokemonServiceClient(client);

  runApp(MyApp(pokemonServiceClient: pokemonServiceClient));
}

class MyApp extends StatelessWidget {
  final PokemonServiceClient pokemonServiceClient;

  const MyApp({Key? key, required this.pokemonServiceClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListPage(pokemonServiceClient: pokemonServiceClient),
    );
  }
}
