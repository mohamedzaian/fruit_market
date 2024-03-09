import 'package:flutter/material.dart';

import '../cubit/get_cart/get_cart_cubit.dart';

class SizeConfig
{
  static double? screenHeight;
  static double? screenWidth;
  static double? defultSize ;
  static Orientation? orientation;

  void init(BuildContext context)
  {
    screenWidth=MediaQuery.sizeOf(context).width;
    screenHeight=MediaQuery.sizeOf(context).height;
    orientation=MediaQuery.of(context).orientation;

    defultSize = orientation==Orientation.landscape
    ? screenHeight! * 0.024
        :screenWidth! * 0.024;



  }

}
