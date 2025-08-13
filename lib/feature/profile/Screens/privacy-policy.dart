import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(children: [
          SizedBox(height: height*.02,),
          Padding(
            padding:  EdgeInsets.only(right: width*.49),
            child: Text(
              'Privacy policy',
              style: GoogleFonts.roboto(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            width: double.infinity,
            padding: EdgeInsets.only(top: height*.05, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.only(bottom: 20,left: width*.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Privacy Policy for Huntrr' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('Effective Date: June 1, 2025' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w400),),
                    SizedBox(height: height*.015),
                    Text('Welcome to Huntrr. We value your trust and are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and protect your information when you use our mobile application' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('1 . Information We Collect' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('We may collect the following types of information:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Personal Information:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.038,fontWeight: FontWeight.w400),),
                    SizedBox(height: height*.015),
                    Text('Name, email address, phone number' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Profile details (e.g., skills, bio, experience)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Portfolio links or uploaded work samples)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Usage Data:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.038,fontWeight: FontWeight.w400),),
                    SizedBox(height: height*.015),
                    Text('Log data (IP address, device type, OS, app version)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Interaction data (pages viewed, clicks, time spent)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),

                    SizedBox(height: height*.015),
                    Text('Location Data:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.038,fontWeight: FontWeight.w400),),
                    SizedBox(height: height*.015),
                    Text('Approximate or precise location (with user permission)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Communication Data:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.038,fontWeight: FontWeight.w400),),
                    SizedBox(height: height*.015),
                    Text('Messages and chats exchanged through the app' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('2 . How We Use Your Information' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('We use the information we collect for the following purposes:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('To create and manage user accounts' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('To match clients with graphic designers and digital marketing professionals' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('To improve user experience and app functionality' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('To communicate updates, offers, and support information' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('To monitor and analyze app usage for performance' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('3 . Sharing of Information' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('We do not sell your personal information. However, we may share your data:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('With clients or firms you engage with through the app' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('With third-party service providers (e.g., hosting, analytics)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('If required by law or to protect our rights' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('In case of a business transfer (e.g., merger, acquisition)' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('4 . Data Security' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('We implement industry-standard security measures to protect your data. However, no method of transmission over the internet or method of electronic storage is 100% secure.' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('5 . Your Rights and Choices' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('You have the right to:' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.038,fontWeight: FontWeight.w400),),
                    SizedBox(height: height*.015),
                    Text('Access, update, or delete your personal information' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Opt-out of promotional communications' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('Request the deactivation of your account' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('6 . Children’s Privacy' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('Our app is not intended for children under the age of 13. We do not knowingly collect personal information from minors.' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('7 . Changes to This Policy' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the new policy in the app' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.015),
                    Text('8 . Contact Us' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.04,fontWeight: FontWeight.w500),),
                    SizedBox(height: height*.015),
                    Text('If you have any questions about this Privacy Policy, you can contact us at' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.02),
                    Text('Email: info@icanyon.com' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    Text('Address: i-Canyon technologies, 7th Floor, T2, Hiliate Business park, Calicut-India' ,style: GoogleFonts.roboto(
                        color: Colors.black,fontSize: width*.033,fontWeight: FontWeight.w300),),
                    SizedBox(height: height*.02),
                  ],
                ),
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
