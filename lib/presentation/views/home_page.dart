import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/colors.dart';
import 'package:pokedex/presentation/widgets/pokemon_card.dart';

import '../../data/reopsitories/pokemon_repository.dart';

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
    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset){
        print('scrolllllllll');
        // ref.watch(pokemonData);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _data = ref.watch(pokemonData);
    // print('_data_data $_data');
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
                _data.when(
                    data: (data) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        // padding: const EdgeInsets.all(4.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _data.value?.listData?.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return PokemonCard(data: _data.value!.listData![index]);
                          },
                          // children: [
                          //   PokemonCard(data: _data.value.listData[]),
                          //   PokemonCard(),
                          //   PokemonCard(),
                          // ],
                        ),
                      );
                    },
                    error: (error, stackTrace) => Text('Error: $error'),
                    loading: () => const CircularProgressIndicator())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
