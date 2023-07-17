import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/colors.dart';
import 'package:pokedex/data/models/app_feed.dart';
import 'package:pokedex/domain/enties/pokemon_entity.dart';
import 'package:pokedex/presentation/views/home/provider.dart';
import 'package:pokedex/presentation/views/reuse/app_page_state.dart';
import 'package:pokedex/presentation/widgets/home/pokemon_card.dart';

import '../../../data/reopsitories/pokemon_repository_impl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homePageStateProvider.notifier).getPokemon();
    });
    // controller.addListener(() {
    //   // if(controller.position.maxScrollExtent == controller.offset){
    //   //   print('scrolllllllll');
    //   //   // ref.watch(pokemonData);
    //   // }
    //
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final dataObs = ref.watch(homePageStateProvider);

    Widget widgetBuilder = Container();

    if(dataObs.status == AppPageStatus.initial || dataObs.status == AppPageStatus.loading){
      widgetBuilder = const CircularProgressIndicator();
    }else if(dataObs.status == AppPageStatus.success){
      final data = dataObs.value as AppFeed<PokemonEntity>;

      widgetBuilder = Container(
        margin: const EdgeInsets.all(4.0),
        // padding: const EdgeInsets.all(4.0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.feed.length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return PokemonCard(data: data.feed[index]);
          },
          // children: [
          //   PokemonCard(data: _data.value.listData[]),
          //   PokemonCard(),
          //   PokemonCard(),
          // ],
        ),
      );
    }else{
      widgetBuilder = const Text('Error');
    }

    return Container(
      color: PokedexColors.primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: PokedexColors.primary,
          body: SingleChildScrollView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/pokeball.png',
                            height: 24.h,
                            width: 24.w,
                            color: Colors.white,
                          ),
                          SizedBox(width: 16.w,),
                          Text(
                            'Pokédex',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              // controller: _searchController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIconColor: PokedexColors.primary,
                                hintText: 'Search',
                                prefixIcon: const Icon(Icons.search,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Colors.white,
                            ),
                            child: Image.asset('assets/images/text_format.png',
                              height: 16.h,
                              width: 16.w,
                              color: PokedexColors.primary,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                    ],),
                ),
                widgetBuilder
              ],
            ),
          ),
        ),
      ),
    );
  }
}
