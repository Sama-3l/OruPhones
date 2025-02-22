import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/constants/home_page_constants.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/features/auth/presentation/screens/login.dart';
import 'package:oruphones/features/home/business_logic/cubits/StickButtonsCubit/stick_sort_and_filter_cubit.dart';
import 'package:oruphones/features/home/presentation/widgets/best_deals.dart';

import 'package:oruphones/features/home/presentation/widgets/carousel_section.dart';
import 'package:oruphones/features/home/presentation/widgets/drawer.dart';
import 'package:oruphones/features/home/presentation/widgets/faqs.dart';
import 'package:oruphones/features/home/presentation/widgets/get_notified.dart';
import 'package:oruphones/features/home/presentation/widgets/on_your_mind_section.dart';
import 'package:oruphones/features/home/presentation/widgets/socials_section.dart';
import 'package:oruphones/features/home/presentation/widgets/sort_filter_button.dart';
import 'package:oruphones/features/home/presentation/widgets/textfield.dart';
import 'dart:ui';

import 'package:oruphones/features/home/presentation/widgets/top_brands_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isLoggedIn, this.userModel});

  final bool isLoggedIn;
  final UserModel? userModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();
  bool _isPastElement = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollPosition);
  }

  void _checkScrollPosition() {
    // Get the RenderBox of the target widget
    RenderBox? targetBox = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (targetBox != null) {
      double widgetPosition = targetBox.localToGlobal(Offset.zero).dy;
      if (widgetPosition < 0 && !_isPastElement) {
        _isPastElement = true;
        context.read<StickSortAndFilterCubit>().onStick(_isPastElement);
      } else if (widgetPosition >= 0 && _isPastElement) {
        _isPastElement = false;
        context.read<StickSortAndFilterCubit>().onStick(_isPastElement);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: LightColors.white,
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: LightColors.white,
                elevation: 4,
                leading: SizedBox.shrink(),
                flexibleSpace: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: Iconify(
                              drawer,
                              size: 16,
                              color: LightColors.black,
                            ),
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Image.asset(
                            'lib/assets/images/logo.jpg',
                            height: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "India",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: LightColors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 16),
                            child: Iconify(
                              location,
                              size: 20,
                            ),
                          ),
                          widget.isLoggedIn
                              ? IconButton(
                                  onPressed: () {},
                                  iconSize: 24,
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                  ))
                              : TextButton(
                                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      backgroundColor: LightColors.yellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      )),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: LightColors.black,
                                    ),
                                  )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                expandedHeight: 110,
                collapsedHeight: 110,
                flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: LightColors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        border: Border.all(color: LightColors.white.withOpacity(0.2), width: 1),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CustomTextField(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                          BlocBuilder<StickSortAndFilterCubit, StickSortAndFilterState>(
                            builder: (context, state) {
                              if (state is StickButtonsState && state.stickButtons) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    height: 36,
                                    child: Row(children: [
                                      SortFilterButton(
                                        prefixIcon: sort,
                                        title: "Sort",
                                      ),
                                      SortFilterButton(
                                        prefixIcon: filter,
                                        title: "Filter",
                                      ),
                                    ]),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: 36,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: chipCards.length,
                                      itemBuilder: (context, index) => Padding(
                                            padding: EdgeInsets.only(
                                              left: index != 0 ? 4 : 16,
                                              right: index != chipCards.length - 1 ? 4 : 16,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: LightColors.white,
                                                border: Border.all(color: LightColors.white2),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 4,
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      chipCards[index]["new"] != null && chipCards[index]["new"]
                                                          ? Padding(
                                                              padding: const EdgeInsets.only(right: 10.0),
                                                              child: Iconify(
                                                                newLabel,
                                                                size: 12,
                                                              ),
                                                            )
                                                          : SizedBox.shrink(),
                                                      Text(
                                                        chipCards[index]["title"],
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color: LightColors.black,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(controller: _scrollController, padding: EdgeInsets.symmetric(vertical: 10), children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CarouselSection(),
                  OnYourMindSection(),
                  TopBrandsSection(
                    key: _targetKey,
                  ),
                  BestDeals(
                    userModel: widget.userModel,
                  ),
                  FaqsSection(),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            GetNotifiedSection(),
            Container(
              color: LightColors.blackGrey,
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/images/downloadApp.png',
                    width: double.infinity,
                  ),
                  SocialsSection(),
                ],
              ),
            )
          ]),
        ),
      ),
      drawer: DrawerSection(
        isLoggedIn: widget.isLoggedIn,
        user: widget.userModel,
      ),
    );
  }
}
