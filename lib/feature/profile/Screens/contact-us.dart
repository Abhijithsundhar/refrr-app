import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Contact Us",        // ✅ moved here
          style: GoogleFonts.roboto(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,     // ✅ aligns closer to back arrow
      ),

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: height * .05, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, left: width * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Phone number
                SizedBox(height: height * .03),
                Padding(
                  padding: EdgeInsets.only(left: width * .2),
                  child: Text(
                    'Phone Number',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: width * .035,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: height * .01),
                Row(
                  children: [
                    SizedBox(width: width * .04),
                    const Icon(Icons.phone_forwarded, color: Colors.black87),
                    SizedBox(width: width * .092),
                    SelectableText(
                      '+91 9955510101',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: width * .035,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(indent: width * .2),

                /// Email
                SizedBox(height: height * .02),
                Padding(
                  padding: EdgeInsets.only(left: width * .2),
                  child: Text(
                    'Email',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: width * .035,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: height * .01),
                Row(
                  children: [
                    SizedBox(width: width * .04),
                    const Icon(Icons.mail, color: Colors.black87),
                    SizedBox(width: width * .092),
                    SelectableText(
                      'info@icanyon.com',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: width * .035,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(indent: width * .2),

                /// Address
                SizedBox(height: height * .02),
                Padding(
                  padding: EdgeInsets.only(left: width * .2),
                  child: Text(
                    'Address',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: width * .035,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: height * .01),
                Row(
                  children: [
                    SizedBox(width: width * .04),
                    const Icon(Icons.location_pin, color: Colors.black87),
                    SizedBox(width: width * .092),
                    SelectableText(
                      'i-Canyon technologies,\n7th floor, T2, Hilite Business Park,\nCalicut - India',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: width * .035,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(indent: width * .2),
                SizedBox(height: height * .4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}