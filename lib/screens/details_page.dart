import 'package:flutter/material.dart';
import 'package:vscode/classes/pokemon.dart';
import 'package:vscode/clients/pokemon_service_client.dart';

class DetailsPage extends StatefulWidget {
  final PokemonServiceClient pokemonServiceClient;
  final String id;

  const DetailsPage({
    super.key,
    required this.id,
    required this.pokemonServiceClient,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget buildInfoCard(String title, String content) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(content),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokémon Details"),
      ),
      body: FutureBuilder<Pokemon>(
        future: widget.pokemonServiceClient.fetchPokemonDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Pokémon found'));
          }

          final pokemon = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      pokemon.image ?? '',
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${pokemon.name} (#${pokemon.number ?? 'N/A'})',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Row 1
                  Row(
                    children: [
                      Expanded(
                        child: buildInfoCard(
                            'Classification', pokemon.classification ?? 'N/A'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildInfoCard(
                            'Type(s)', pokemon.types?.join(', ') ?? 'N/A'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Row 2
                  Row(
                    children: [
                      Expanded(
                        child: buildInfoCard('Weight',
                            '${pokemon.weight?['minimum'] ?? 'N/A'} - ${pokemon.weight?['maximum'] ?? 'N/A'}'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildInfoCard('Height',
                            '${pokemon.height?['minimum'] ?? 'N/A'} - ${pokemon.height?['maximum'] ?? 'N/A'}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Row 3
                  Row(
                    children: [
                      Expanded(
                        child: buildInfoCard('Resistances',
                            pokemon.resistant?.join(', ') ?? 'N/A'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Row 4
                  Row(
                    children: [
                      Expanded(
                        child: buildInfoCard('Weaknesses',
                            pokemon.weaknesses?.join(', ') ?? 'N/A'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Row 5
                  Row(
                    children: [
                      Expanded(
                        child: buildInfoCard(
                            'Flee Rate',
                            pokemon.fleeRate != null
                                ? '${(pokemon.fleeRate! * 100).toInt()}%'
                                : 'N/A'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildInfoCard(
                            'Max HP', pokemon.maxHP?.toString() ?? 'N/A'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildInfoCard(
                            'Max CP', pokemon.maxCP?.toString() ?? 'N/A'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Row 6
                  Row(
                    children: [
                      Expanded(
                        child: buildInfoCard(
                            'Evolutions',
                            pokemon.evolutions != null &&
                                    pokemon.evolutions!.isNotEmpty
                                ? pokemon.evolutions!.join(', ')
                                : 'No evolutions found'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildInfoCard(
                          'Evolution requirements',
                          pokemon.evolutionRequirements != null
                              ? '${pokemon.evolutionRequirements!['amount']} ${pokemon.evolutionRequirements!['name']}'
                              : '-',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
