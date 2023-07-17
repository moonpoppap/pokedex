import 'package:pokedex/data/models/pokemon_model.dart';

import '../../../../core/result/app_result.dart';
import '../../../response/base_response.dart';

abstract class HomeRemoteDatasource{
  Future<AppResult<AppFeedResponse<List<PokemonModel>>>> getListPokemon(int offset);
}