import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/result/app_result.dart';
import 'package:pokedex/data/models/app_feed.dart';
import 'package:pokedex/data/response/base_response.dart';
import 'package:pokedex/domain/enties/pokemon_entity.dart';
import 'package:pokedex/domain/usecases/get/get_pokemon.dart';
import 'package:pokedex/presentation/views/reuse/app_page_state.dart';

class HomeController extends StateNotifier<AppPageState>{
  final GetPokemon _getPokemon;

  HomeController({required GetPokemon getPokemon}) :
        _getPokemon = getPokemon,
        super(const AppPageState());

  AppFeed<PokemonEntity> _appFeedPokemonObs = AppFeed(feed: []);

  AppFeed<PokemonEntity> get appFeedPokemonObs => _appFeedPokemonObs;

  Future<void> getPokemon({forceReload = true}) async {
    AppFeed<PokemonEntity> appFeed = _appFeedPokemonObs;

    if(appFeed.feed.isEmpty || forceReload){
      state = state.copyWith(status: AppPageStatus.loading);
      appFeed = AppFeed(
        feed: [],
        numPage: 0,
        lastPage: false,
        countPage: 0
      );
    }

    AppResult<AppFeedResponse<List<PokemonEntity>>> appResult = await _getPokemon.call(appFeed.numPage);

    appResult.whenWithResult((result) {
      appFeed.numPage = result.value.numPage;
      appFeed.lastPage = result.value.lastPage;
      appFeed.feed = result.value.valueFeed;
      appFeed.countPage = result.value.countPage;

      _appFeedPokemonObs = appFeed;

      state = state.copyWith(status: AppPageStatus.success, value: _appFeedPokemonObs);
    }, (error) {
      state = state.copyWith(status: AppPageStatus.failure);
    });
  }
}