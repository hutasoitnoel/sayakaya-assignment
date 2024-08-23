const String getDetails = r'''
  query($id: String!) {
    pokemon(id: $id) {
      id
      number
      name
      image
      weight {
        minimum
        maximum
      }
      height {
        minimum
        maximum
      }
      classification
      types
      resistant
      weaknesses
      fleeRate
      maxHP
      maxCP
      evolutions {
        id
      }
      evolutionRequirements {
        amount
        name
      }
    }
  }
''';
