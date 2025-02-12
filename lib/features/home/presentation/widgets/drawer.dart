import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/core/constants/home_page_constants.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/features/auth/presentation/screens/login.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 40),
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
                      ],
                    ),
                  ),
                  if (!isLoggedIn) ...[
                    ElevatedButton(
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  ElevatedButton(
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
                  if (isLoggedIn)
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        "Logout",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: LightColors.black,
                        ),
                      ),
                      onTap: () {},
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
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
      ),
    );
  }
}
