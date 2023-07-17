import 'package:pokedex/core/result/app_result.dart';
import 'package:pokedex/domain/enties/pokemon_entity.dart';

import '../../data/response/base_response.dart';

abstract class HomeRepository{
  Future<AppResult<AppFeedResponse<List<PokemonEntity>>>> getListPokemon(int offset);
}