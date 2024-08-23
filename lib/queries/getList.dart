const String getList = r'''
  query($first: Int!) {
    pokemons(first: $first) {
      id
      number
      name
      image
    }
  }
''';
