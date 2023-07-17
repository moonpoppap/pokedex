import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/services/pokemon_service.dart';

import '../../models/pokemon_model.dart';

final pokemonData = FutureProvider<PokemonModel?>((ref) {
  return ref.read(pokemonService).fetchData();
});

