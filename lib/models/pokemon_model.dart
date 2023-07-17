class PokemonModel {
  String? next;
  int? count;
  List<PokemonItemResponse>? listData = [];

  PokemonModel.fromJson(Map<String, dynamic> parsedJson) {
    // Map<String, dynamic> result = parsedJson['results'];
    count = parsedJson['count'];
    next = parsedJson['next'];

    // listData = []; ทำไมต้องมีบรรทัดนี้นะ
    for(Map<String, dynamic> item in parsedJson['results']){
      // print(item);
      listData?.add(PokemonItemResponse.fromJson(item));
    }
  }
}

class PokemonItemResponse {
  String? name, imageUrl, id, url;

  PokemonItemResponse.fromJson(Map<String, dynamic> parsedJson){
    name = parsedJson['name'];
    url = parsedJson['url'];
    imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${int.parse(getId(url ?? ''))}.png';
    // print('imageUrlimageUrl $imageUrl');
    id = getId(url ?? '');
  }


  String getId(String url){
    List<String> parts = url.split("/");
    String number = parts[parts.length - 2];
    return number;
  }
}