import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  PokemonItemResponse data;
  PokemonCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 3,
                offset: Offset(0, 1),
                spreadRadius: 1,
              )
            ],
          ),
          // BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(8),
          // ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            // padding: EdgeInsets.only(top: 48),
            height: 44,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(7)
            ),
          ),
        ),
        ///อีกวิธีนึง นอกจาก Align คือใช้ Position
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     // padding: EdgeInsets.only(top: 48),
        //     height: 48,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //         color: const Color(0xFFEFEFEF),
        //         borderRadius: BorderRadius.circular(7)
        //     ),
        //   ),
        // ),

        ///pokemon name
        Positioned(
          bottom: 4,
          left: 0,
          right: 0,
          child: Text(
            data.name ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF1C1C1C),
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),),
        ),

        ///pokemon image
        Align(
          alignment: Alignment.center,
          child: Image.network(
            data.imageUrl ?? '',
            height: 72.h,
            width: 72.w,
          ),
        ),
        
        ///pokemon number
        Positioned(
            top: 4,
            right: 8,
            child: Text(
              formatID(data.id ?? ''),
              style: TextStyle(
                color: const Color(0xFF666666),
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
              ),
            )
        )
      ],
    );
  }

  String formatID(String id){
    String formattedNumber = id.toString().padLeft(3, '0');
    String formattedResult = '#$formattedNumber';

    return formattedResult;
  }
}
