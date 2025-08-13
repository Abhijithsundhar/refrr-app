import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/common/global variables.dart';
import '../../core/constants/color-constnats.dart';

class OpportunitiesSinglePage extends StatelessWidget {
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
      body: Padding(
        padding:  EdgeInsets.only(top: height*.02),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only( left: width*.33,bottom: height*.1),
              child: Column(
                children: [
                  Text(
                  'EDUWISDOM',
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),),Text(
                  'Education',
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              width: double.infinity,
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      /// logo
                      Center(
                        child: Container(
                          height: height * .15,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: ColorConstants.texFieldColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset('assets/images/creditImage.png'),
                        ),
                          
                      ),
                      SizedBox(height: height*.02),
                      ///about head
                      Padding(
                        padding:  EdgeInsets.only(right:width*.51),
                        child: Text('About EduWisdom',style:
                        GoogleFonts.roboto(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryColor,
                        ),),
                      ),
                      SizedBox(height: height*.01),
                      ///about notes
                      Padding(
                        padding:  EdgeInsets.only(right:width*.03),
                        child: Text(
                          '''The purpose of education has always been a profound and evolving concept, shaping the way societies grow and individuals thrive. From its earliest roots, education was meant to empower the individual as working force, opening their eyes to the world around them and equipping them with the tools to navigate it. However, over time, this noble vision has been reduced to a surface-level idea: ‘Skilled Education for All.’ While skills are undeniably important, modern education has lost its way by failing to ask the deeper.

This growing dilemma and its consequences inspired a team of visionary professionals to lay the foundation for EduWisdom. At its core, EduWisdom believes that education should be about empowerment and enhancement. It should go beyond mere getting degrees to prepare the individuals for the larger framework of life, fostering a well-crafted educational ecosystem that nurtures curiosity, critical thinking, and holistic growth.

Through EduWisdom, we are reimagining the very heart of education. We are daring to ask the right questions:
What truly is the purpose of education?
⁠Isn’t it about building a generation that can think ahead, innovate, and lead?
⁠Isn’t it about creating a generation that is not just skilled but also deeply equipped with the wisdom to tackle the complexities of the world?''',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: height*.03),
                      ///mode of work
                      Padding(
                        padding:  EdgeInsets.only(right:width*.61),
                        child: Text('Mode of work',style:
                        GoogleFonts.roboto(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryColor,
                        ),),
                      ),
                      SizedBox(height: height*.02),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                               width: width * 0.4,
                               height: height * 0.03,
                               alignment: Alignment.center,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                   color: ColorConstants.buttonColor,
                                   width: 0.5,
                                 ),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: Text(
                                 'Part-time',
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontSize: width * 0.035,
                                   fontWeight: FontWeight.w400,
                                 ),
                               ),
                             ),
                             Container(
                               width: width * 0.4,
                               height: height * 0.03,
                               alignment: Alignment.center,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                   color: ColorConstants.buttonColor,
                                   width: 0.5, // 👈 thinner border
                                 ),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: Text(
                                 'Full-time',
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontSize: width * 0.035,
                                   fontWeight: FontWeight.w400,
                                 ),
                               ),
                             ),
                         ],),
                      SizedBox(height: height*.03),
                      ///Reward system
                      Padding(
                        padding:  EdgeInsets.only(right:width*.58),
                        child: Text('Reward system',style:
                        GoogleFonts.roboto(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryColor,
                        ),),
                      ),
                      SizedBox(height: height*.02),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                               width: width * 0.4,
                               height: height * 0.03,
                               alignment: Alignment.center,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                   color: ColorConstants.buttonColor,
                                   width: 0.5,
                                 ),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: Text(
                                 'Salary',
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontSize: width * 0.035,
                                   fontWeight: FontWeight.w400,
                                 ),
                               ),
                             ),
                             Container(
                               width: width * 0.4,
                               height: height * 0.03,
                               alignment: Alignment.center,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                   color: ColorConstants.buttonColor,
                                   width: 0.5,
                                 ),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: Text(
                                 'Commission',
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontSize: width * 0.035,
                                   fontWeight: FontWeight.w400,
                                 ),
                               ),
                             ),
                         ],),
                      SizedBox(height: height*.03),
                      ///For more information contact
                      Padding(
                        padding:  EdgeInsets.only(right:width*.29),
                        child: Text('For more information contact',style:
                        GoogleFonts.roboto(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryColor,
                        ),),
                      ),
                      SizedBox(height: height*.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Abdul Jihad (Manager)'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('+971 2365801'),
                              Text('+971 4589023'), // example second number
                              Text('+971 7894561'), // example third number
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height*.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Website'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('www.eduwisdomacademy.com'),
                              // example third number
                            ],
                          ),
                        ],
                      ),SizedBox(height: height*.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Office M 02, Building P/1067 C72, Mussaffah, Shabiya-ME-9- Abu Dhabi'),
                              // example third number
                            ],
                          ),
                        ],
                      ),








                      SizedBox(height: 20),
                      ///apply button
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorConstants.buttonColor,
                            borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                          ),
                          child: Text(
                            'Apply Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}