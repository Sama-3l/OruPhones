import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oruphones/features/auth/business_logic/cubits/checkBoxCubit/check_box_cubit.dart';
import 'package:oruphones/features/auth/business_logic/cubits/otpUpdateCubit/otp_update_cubit.dart';
import 'package:oruphones/features/home/business_logic/cubits/CarouselScrollCubit/carouselscroll_cubit.dart';
import 'package:oruphones/features/home/business_logic/cubits/cubit/like_product_cubit.dart';
import 'package:oruphones/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CarouselScrollCubit()),
          BlocProvider(create: (context) => CheckBoxCubit()),
          BlocProvider(create: (context) => OtpUpdateCubit()),
          BlocProvider(create: (context) => LikeProductCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashScreen(),
        ));
  }
}
