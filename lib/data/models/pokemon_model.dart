import 'package:pokedex/data/response/remote/pokemon_response.dart';
import 'package:pokedex/domain/enties/pokemon_entity.dart';

class PokemonModel extends PokemonEntity{

  PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.url
  });

  factory PokemonModel.fromResponse(ItemPokemonResponse itemResponse)=> PokemonModel(
      id: itemResponse.id,
      name: itemResponse.name,
      imageUrl: itemResponse.imageUrl,
      url: itemResponse.url
  );
}