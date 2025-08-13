import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/opportunities/opportunities-singleview.dart';

import '../../core/common/global variables.dart';

class Opportunities extends StatefulWidget {
  const Opportunities({super.key});

  @override
  State<Opportunities> createState() => _OpportunitiesState();
}

class _OpportunitiesState extends State<Opportunities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SingleChildScrollView(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///heading
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: width*.05, top: height*.07),
                  child: Text('Opportunities',style:  GoogleFonts.roboto(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: width * .14, left: width * .5),
                  child: CircleAvatar(
                    radius: width * .037, // Slightly larger radius for better visibility
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: width * .035, // Slightly larger radius for better visibility
                      backgroundColor: ColorConstants.primaryColor, // Set background color
                      child: Icon(
                        Icons.question_mark_sharp,
                        color: Colors.white,
                        size: width * .044,
                      ),
                    ),
                  ),
                )

              ],
            ),
            SizedBox(height: height*.02,),
            ///search
            Padding(
              padding:  EdgeInsets.all(15),
              child: Container(
                height: height*.06,
                padding: EdgeInsets.only( left: width*.05,right: width*.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            ///listview builder

            ListView.builder(
              itemCount: 5,
              shrinkWrap: true, // Makes ListView take only required space
              physics: NeverScrollableScrollPhysics(), // Disables its own scroll
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: width*.05,bottom: height*.02),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,   MaterialPageRoute(builder: (context) => OpportunitiesSinglePage(),));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: width * 0.9,
                          height: height*.28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width*.05,top: height*.028),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "I-CANYON TECHNOLOGIES",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(right: width*.1),
                                      child: Text(
                                        "open",
                                        style: GoogleFonts.inter(
                                          color: ColorConstants.primaryColor,
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width*.047,),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin,size: width*.04,),
                                    Text(
                                      "Dubai",
                                      style: GoogleFonts.inder(
                                        color: Colors.black,
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * .02),
                              Padding(
                                padding: EdgeInsets.only(left: width*.028,),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Container(
                                      width: width * .03,
                                      height: height * .15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/homecardicon.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Technology & Branding", style: GoogleFonts.roboto(fontSize: width * 0.035)),
                                          SizedBox(height: height * .04),
                                          Text("43 Firms Added", style: GoogleFonts.roboto(fontSize: width * 0.035)),
                                          SizedBox(height: height * .04),
                                          Text("Commission Based", style: GoogleFonts.roboto(fontSize: width * 0.035)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: height * .23,
                          right: width*.09,
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.035,
                            decoration: BoxDecoration(
                              color: ColorConstants.buttonColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "Apply Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.031,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
