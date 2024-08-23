const String getName = r'''
  query($id: String!) {
    pokemon(id: $id) {
      name
    }
  }
''';
