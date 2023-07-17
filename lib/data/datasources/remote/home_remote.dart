import 'package:dio/dio.dart';
import 'package:pokedex/core/result/app_result.dart';
import 'package:pokedex/data/datasources/remote/datasources/home_remote_datasource.dart';
import 'package:pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/data/response/base_response.dart';
import 'package:pokedex/data/response/remote/pokemon_response.dart';

class HomeRemote implements HomeRemoteDatasource{
  final Dio dio;

  HomeRemote({required this.dio});

  final String _getListPokemon = 'pokemon?limit=12';

  @override
  Future<AppResult<AppFeedResponse<List<PokemonModel>>>> getListPokemon(int offset) async {
    try{
      Response dioResponse = await dio.get('$_getListPokemon&offset=$offset');

      PokemonResponse response = PokemonResponse.fromJson(dioResponse.data);

      List<PokemonModel> listResult = [];

      for(ItemPokemonResponse itemResponse in response.listData){
        listResult.add(PokemonModel.fromResponse(itemResponse));
      }

      return Success(value: AppFeedResponse(countPage: response.countPage, lastPage: response.lastPage, numPage: response.offset, valueFeed: listResult));
    }on DioException catch(e){
      return Error(dioException: e);
    }
  }
}