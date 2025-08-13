import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/home/screens/home/bottombar.dart';
import 'package:icanyon/feature/wallet/Screens/wallethome.dart';
import 'package:icanyon/model/affiliate-model.dart';
import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';

class AllDoneScreen extends StatefulWidget {
   final AffiliateModel? affiliate;
   const AllDoneScreen({super.key, this.affiliate});

   @override
  _AllDoneScreenState createState() => _AllDoneScreenState();
}

class _AllDoneScreenState extends State<AllDoneScreen> {
  @override
  void initState() {
    super.initState();
    // Delay of 1 second before showing the bottom sheet
    Future.delayed(Duration(seconds: 1), () {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        builder: (context) {
          return Container(
            width: double.infinity,
            height: height*.5,
            child: Column(
              children: [
                SizedBox(width: width*.07,),
                SizedBox(
                  width: width*.3,
                    height: height*.2,
                    child: Image.asset('assets/images/bluetick.png')),

                Text(
                  "Please wait for admin's approval!",
                  style: GoogleFonts.roboto(fontSize: width*.04,fontWeight: FontWeight.w400),
                ),
                 SizedBox(height: height*.15,),
                GestureDetector(
                  onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                      BottomBarSection(affiliate: widget.affiliate,),), (route) => false,);
                  },
                  child: Container(
                    height: height * .05,
                    width: width*.9,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorConstants.buttonColor)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Back to home', // Replace with your text
                          style: GoogleFonts.roboto(fontSize: width*.037,color: ColorConstants.buttonColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true, // disables back button
      child: Scaffold(
        backgroundColor:ColorConstants.primaryColor, // Replace with your ColorConstants.primaryColor
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * .35, top: width * .3),
              child: Text(
                'All Done!!!',
                style: GoogleFonts.roboto(
                  fontSize: width * .06,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
