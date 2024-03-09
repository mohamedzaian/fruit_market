
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/add_product_cubit.dart';
import 'package:fruit_market/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:fruit_market/cubit/get_cart/get_cart_cubit.dart';
import 'package:fruit_market/cubit/get_favorite_product/get_favorite_product_cubit.dart';
import 'package:fruit_market/cubit/get_product/get_data_cubit.dart';
import 'package:fruit_market/cubit/get_stone_fruit/get_stone_fruit_cubit.dart';
import 'package:fruit_market/cubit/login_cubit.dart';
import 'package:fruit_market/models/product_model.dart';
import 'package:fruit_market/screen/splash_screen.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAppCheck.instance.activate();
  await initializeDateFormatting('ar', null);
  Hive.registerAdapter(ProductmodelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Productmodel>(FireStoreKey().feature);





  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => AddProductCubit(),
        ),
        BlocProvider(
          create: (context) => GetDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetFavoriteProductCubit(),
        ),
        BlocProvider(
          create: (context) => GetStoneFruitCubit(

          ),
        ), BlocProvider(
          create: (context) => AddToCartCubit(),
        ),BlocProvider(
          create: (context) => GetCartCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
