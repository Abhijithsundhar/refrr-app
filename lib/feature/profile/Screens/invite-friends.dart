import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/model/affiliate-model.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';

class InviteFriends extends StatelessWidget {
  final AffiliateModel? affiliate;
  const InviteFriends({super.key, required this.affiliate});

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
        physics: NeverScrollableScrollPhysics(),
        child: Column(children: [
          SizedBox(height: height*.02,),
          Padding(
            padding:  EdgeInsets.only(right: width*.51),
            child: Text(
              'Invite friends',
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
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      height: height * .3,
                      width: width*.9,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 173, 185, 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Refer a friend and earn more', // Replace with your text
                            style: GoogleFonts.roboto(fontSize: width*.04,color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: height*.01),

                          Container(
                            height: height * .065,
                            width: width*.8,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Invite friends',style: GoogleFonts.roboto(fontSize: width*.038,color: Colors.black,
                                  fontWeight: FontWeight.w400),),
                            ),
                          ),
                          SizedBox(height: height*.04),

                          Padding(
                            padding: EdgeInsets.only(left: width*.025),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.roboto(
                                        fontSize: width * .035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Or invite your friend to Huntrr with your unique\nreferral code : ',
                                        ),
                                        TextSpan(
                                          text: affiliate!.id ?? '',
                                          style: TextStyle(color: Colors.blue), // referral code in blue
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: affiliate!.id ?? ''));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Referral code copied!')),
                                    );
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: width*.02, top: height*.02),
                                    child: Icon(Icons.copy_rounded, color: Colors.grey, size: width * 0.045),
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: height*.06),
                    Padding(
                      padding:  EdgeInsets.only(right: width*.64),
                      child: Text(
                        'Your referrals', // Replace with your text
                        style: GoogleFonts.roboto(fontSize: width*.04,color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: height*.03),
                    Container(
                      height: height * .15,
                      width: width*.9,
                      decoration: BoxDecoration(
                        color:Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * .03, top: height * .045),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2 friends successfully referred',
                                  style: GoogleFonts.roboto(
                                    fontSize: width * .04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * .005),
                                Text(
                                  'View history',
                                  style: GoogleFonts.roboto(
                                    fontSize: width * .04,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Asset Image added to the right
                          Padding(
                            padding: EdgeInsets.only(left: width * .08, top: height * .045),
                            child: Image.asset(
                              'assets/images/Invite-friend.png',
                              height: height * 0.07,
                              width: width * 0.15,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      )
                      ,
                    ),
                    SizedBox(height: height*.2),


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
