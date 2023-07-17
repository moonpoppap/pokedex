import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/pokemon_model.dart';

class PokemonService {
  Dio dio = Dio();
  // int offset = 0;
  // int limit = 12;

  Future<PokemonModel?> fetchData({int? offset, int limit = 12}) async {
    try {
      Response response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset');
      // print('response.data response.data ${response.data}');
      if(response.statusCode == 200){
        PokemonModel pokemonModel = PokemonModel.fromJson(response.data);
        // print(pokemonModel);
        return pokemonModel;
      }else {
        print('response.statusCode != 200');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

final pokemonService = Provider<PokemonService>((ref) => PokemonService());
