import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oruphones/features/auth/business_logic/cubits/checkBoxCubit/check_box_cubit.dart';
import 'package:oruphones/features/auth/business_logic/cubits/BottomSheetCubit/bottom_sheet_page_cubit.dart';
import 'package:oruphones/features/auth/business_logic/cubits/otpUpdateCubit/otp_update_cubit.dart';
import 'package:oruphones/features/home/business_logic/cubits/CarouselScrollCubit/carouselscroll_cubit.dart';
import 'package:oruphones/features/home/business_logic/cubits/LikeProduct/like_product_cubit.dart';
import 'package:oruphones/features/home/business_logic/cubits/ExpandFaqCubit/expand_faq_cubit.dart';
import 'package:oruphones/features/home/business_logic/cubits/StickButtonsCubit/stick_sort_and_filter_cubit.dart';
import 'package:oruphones/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oruphones/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
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
          BlocProvider(create: (context) => ExpandFaqCubit()),
          BlocProvider(create: (context) => BottomSheetPageCubit()),
          BlocProvider(create: (context) => StickSortAndFilterCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashScreen(),
        ));
  }
}
