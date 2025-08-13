import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/textedit-controllors.dart';
import 'package:icanyon/feature/Login/Controller/login-controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/common/alertbox.dart';
import '../../../core/common/global variables.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/constants/color-constnats.dart';
import '../../home/screens/home/bottombar.dart';
import '../../profile/Screens/contact-us.dart';
import '../Controller/auth-controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {


  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    // final connectivityStatus = ref.watch(connectivityProvider);
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Column(
                  children: [
                    // Top container with Hello text
                    Container(
                      height: height * .35,
                      width: double.infinity,
                      color: ColorConstants.primaryColor,
                      child: Padding(
                        padding:  EdgeInsets.only(top: height*.13,left: width*.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello!',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: width * .08,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Welcome to refrr',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: width * .035,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * .1),
                    // Bottom white container
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(45),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * .05),
                                // Login text
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * .01, left: width * .06),
                                  child: Text("Login",
                                      style: GoogleFonts.roboto(
                                          fontSize: width * .06,
                                          fontWeight: FontWeight.w800)),
                                ),
                                SizedBox(height: height * .04),
                                // User ID field
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * .05, right: width * .05),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.texFieldColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: loginUserIdController,
            
                                      style: TextStyle(color: Colors.grey),
                                      decoration: InputDecoration(
                                        hintText: 'User ID',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * .04),
                                // Password field
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * .05, right: width * .05),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.texFieldColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: loginPasswordController,
                                      style: TextStyle(color: Colors.grey),
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * .04),
                                // Login button
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * .05, right: width * .05),
                                  child: GestureDetector(
                                    onTap: ()  {
                                      if (loginUserIdController.text.trim().isEmpty) {
                                        showCommonSnackbars(
                                          context: context,
                                          message: "Please enter your userID",
                                        );
                                        return;
                                      } else if (loginPasswordController.text.trim().isEmpty) {
                                        showCommonSnackbars(
                                          context: context,
                                          message: "Please enter your password",
                                        );
                                        return;
                                      }
                                      else{
                                        ref.read(loginControllerProvider.notifier).affiliateLogin(
                                          context: context,
                                          userId: loginUserIdController.text.trim()??'',
                                          password: loginPasswordController.text.trim()??'',
                                          clear: () {
                                            loginUserIdController.clear();
                                            loginPasswordController.clear();
                                          },
                                        );
                                        print('Login button clicked');
                                        print(loginUserIdController.text);
                                        print(loginPasswordController.text);
                                        print('Login button clicked');
                                      }
                                    },
                                    child: Container(
                                      width: width * .9,
                                      height: height * .07,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: width * .004,
                                        ),
                                        borderRadius: BorderRadius.circular(width * .03),
                                      ),
                                      child: Center(
                                        child: loginState
                                            ? SizedBox(
                                          height: 24, // Spinner size
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                          ),
                                        )
                                            :  Text(
                                          'Login',
                                          style: GoogleFonts.roboto(
                                            fontSize: width * .04,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * .02),
                                // Contact us
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * .05, right: width * .05),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'If you are a new user',
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontSize: width * .035),
                                      ),
                                      SizedBox(width: width * .01),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ContactUs()),
                                          );
                                        },
                                        child: Text(
                                          'Contact Us',
                                          style: GoogleFonts.roboto(
                                              color: Color.fromRGBO(0, 103, 176, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: width * .035),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * .1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            
                // Circular image (increased size)
                Positioned(
                  top: height * .228,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: width * .22, // Increased from .15 to .2
                      backgroundImage: AssetImage('assets/images/lo.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
  }
}
