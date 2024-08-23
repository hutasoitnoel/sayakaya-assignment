class Pokemon {
  final String id;
  final String name;
  final String? number;
  final String? image;
  final String? classification;
  final List<String>? types;
  final Map<String, String>? weight;
  final Map<String, String>? height;
  final List<String>? resistant;
  final List<String>? weaknesses;
  final double? fleeRate;
  final int? maxHP;
  final int? maxCP;
  final List<String>? evolutions;
  final Map<String, dynamic>? evolutionRequirements;

  Pokemon({
    required this.id,
    required this.name,
    this.number,
    this.image,
    this.classification,
    this.types,
    this.weight,
    this.height,
    this.resistant,
    this.weaknesses,
    this.fleeRate,
    this.maxHP,
    this.maxCP,
    this.evolutions,
    this.evolutionRequirements,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      image: json['image'],
      classification: json['classification'],
      types: json['types'] != null ? List<String>.from(json['types']) : null,
      weight: json['weight'] != null
          ? {
              "minimum": json['weight']['minimum'],
              "maximum": json['weight']['maximum'],
            }
          : null,
      height: json['height'] != null
          ? {
              "minimum": json['height']['minimum'],
              "maximum": json['height']['maximum'],
            }
          : null,
      resistant: json['resistant'] != null
          ? List<String>.from(json['resistant'])
          : null,
      weaknesses: json['weaknesses'] != null
          ? List<String>.from(json['weaknesses'])
          : null,
      fleeRate: json['fleeRate'] != null
          ? (json['fleeRate'] as num).toDouble()
          : null,
      maxHP: json['maxHP'],
      maxCP: json['maxCP'],
      evolutions: json['evolutions'] != null
          ? (json['evolutions'] as List)
              .map((evolution) => evolution['id'] as String)
              .toList()
          : null,
      evolutionRequirements: json['evolutionRequirements'] != null
          ? Map<String, dynamic>.from(json['evolutionRequirements'])
          : null,
    );
  }
}
