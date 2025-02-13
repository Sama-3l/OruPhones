import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/constants/home_page_constants.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/presentation/screens/login.dart';
import 'package:oruphones/features/splash_screen/presentation/screens/splash_screen.dart';

class DrawerSection extends StatelessWidget {
  DrawerSection({super.key, required this.isLoggedIn, this.user});

  final bool isLoggedIn;
  final UserModel? user;
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: LightColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 26,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Container(
                    color: LightColors.grey2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 40),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Image.asset(
                              'lib/assets/images/logo.jpg',
                              height: 24,
                            ),
                            IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(
                                  Icons.close,
                                  size: 24,
                                )),
                          ]),
                          if (isLoggedIn)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                    child: Iconify(
                                  profile,
                                  size: 44,
                                )),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user == null || user!.userName == "" ? "User1" : user!.userName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: LightColors.black,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                        Text(
                                          'Joined ${DateFormat('MMM dd, y').format(user!.createdDate)}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: LightColors.indicatorGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isLoggedIn) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightColors.blue,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        shadowColor: LightColors.blue,
                      ),
                      child: Text(
                        'Login/SignUp',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: LightColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightColors.yellow,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      shadowColor: LightColors.yellow,
                    ),
                    child: Text(
                      'Sell Your Phone',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: LightColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                if (isLoggedIn)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        "Logout",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: LightColors.black,
                        ),
                      ),
                      onTap: () async {
                        await func.logout();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()));
                      },
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 8),
              child: GridView.count(
                  crossAxisCount: 3, // 3 columns
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.2, // Adjust size
                  children: List.generate(drawerOptions.length, (index) {
                    return InkWell(
                      onTap: () => print("Clicked: ${drawerOptions[index]['text']}"),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Iconify(
                              isLoggedIn && drawerOptions[index]["loggedInIcon"] != null ? drawerOptions[index]["loggedInIcon"] : drawerOptions[index]["icon"],
                              size: 28,
                              color: Colors.black,
                            ),
                            SizedBox(height: 6),
                            Text(
                              isLoggedIn && drawerOptions[index]["loggedInText"] != null ? drawerOptions[index]["loggedInText"] : drawerOptions[index]["text"],
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: LightColors.black,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }
}
