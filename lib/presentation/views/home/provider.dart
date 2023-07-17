import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/datasources/remote/datasources/home_remote_datasource.dart';
import 'package:pokedex/data/datasources/remote/home_remote.dart';
import 'package:pokedex/data/reopsitories/pokemon_repository_impl.dart';
import 'package:pokedex/domain/repositories/home_repository.dart';
import 'package:pokedex/domain/usecases/get/get_pokemon.dart';
import 'package:pokedex/presentation/views/home/home_controller.dart';

import '../../../config/network/app_dio_option.dart';
import '../reuse/app_page_state.dart';

final homeRemoteDataSource = Provider<HomeRemoteDatasource>((ref) => HomeRemote(dio: ref.read(getDioOption).initDioOption()));

final homeRepositoryProvider = Provider<HomeRepository>((ref) => HomeRepositoryImpl(
    homeRemoteDatasource: ref.read(homeRemoteDataSource)
));

final getPokemon = Provider((ref) => GetPokemon(homeRepository: ref.read(homeRepositoryProvider)));

final homePageStateProvider = StateNotifierProvider<HomeController, AppPageState>(
      (ref) => HomeController(
    getPokemon: ref.read(getPokemon),
  ),
);