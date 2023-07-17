import 'package:pokedex/core/result/app_result.dart';
import 'package:pokedex/core/usecases/usecase.dart';
import 'package:pokedex/domain/enties/pokemon_entity.dart';
import 'package:pokedex/domain/repositories/home_repository.dart';

import '../../../data/response/base_response.dart';

class GetPokemon implements UseCase<AppResult<AppFeedResponse<List<PokemonEntity>>>, int>{
  final HomeRepository homeRepository;

  GetPokemon({required this.homeRepository});

  @override
  Future<AppResult<AppFeedResponse<List<PokemonEntity>>>> call(int params) {
    return homeRepository.getListPokemon(params);
  }
}