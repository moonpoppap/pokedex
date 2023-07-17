import 'package:pokedex/core/result/app_result.dart';
import 'package:pokedex/data/datasources/remote/datasources/home_remote_datasource.dart';
import 'package:pokedex/data/response/base_response.dart';
import 'package:pokedex/domain/enties/pokemon_entity.dart';
import 'package:pokedex/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImpl({required this.homeRemoteDatasource});

  @override
  Future<AppResult<AppFeedResponse<List<PokemonEntity>>>> getListPokemon(int offset) {
    return homeRemoteDatasource.getListPokemon(offset);
  }
}

