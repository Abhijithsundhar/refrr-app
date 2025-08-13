import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/wallet/Screens/transaction-history.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/global variables.dart';
import '../../../../core/common/textlength.dart';
import '../../../../core/constants/color-constnats.dart';
import '../../../../model/affiliate-model.dart';

class UpdateWithdrewPage extends StatefulWidget {
  final String title;
  final String amount;
  final DateTime date;
  final String image;
  final String description;
  final String currency;
  final AffiliateModel? affiliate;
  const UpdateWithdrewPage({super.key, required this.title, required this.amount, required this.date,
    required this.image, required this.description, required this.currency, this.affiliate});

  @override
  State<UpdateWithdrewPage> createState() => _UpdateWithdrewPageState();
}

class _UpdateWithdrewPageState extends State<UpdateWithdrewPage> {
  int totalCredit = 0;
  int totalWithdrew = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalCredit = widget.affiliate!.totalCredit ??0;
    totalWithdrew = widget.affiliate!.totalWithrew ??0;
  }
  @override
  Widget build(BuildContext context) {
    final formattedDescription = formatWithLineBreaks(widget.description, 40);

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*.06,),
            Padding(
              padding: EdgeInsets.only(left: width * .05, right: width * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Withdrawn',
                    style: GoogleFonts.roboto(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      // Handle close action here
                      Navigator.pop(context); // or any other logic
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: height*.03,),
            Padding(
              padding:  EdgeInsets.only(left: width*.06,right: width*.06),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30), // Curved edges
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Title
                        SizedBox(height: height*.04,),
                        Padding(
                          padding:  EdgeInsets.only(left: width*.06),
                          child: Text(
                            'CONGRATULATIONS!!',
                            style: GoogleFonts.roboto(fontSize: width*.04,color:ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: height*.02,),
                        ///Image
                        Padding(
                          padding:  EdgeInsets.only(left: width*.06),
                          child: Container(
                            height: height*.24,
                            width: width*.75,
                            color: Colors.red,
                            child: widget.image.isNotEmpty?Image.asset(widget.image) : Image.asset('assets/images/withdrewImageHome.jpeg'),

                          ),
                        ),
                        SizedBox(height: height*.03,),
                        ///Date
                        Padding(
                          padding:  EdgeInsets.only(left: width*.06,right:width*.06 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Amount withdrawn',
                                style: GoogleFonts.roboto(fontSize: width*.035,color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                DateFormat('dd-MM-yyyy').format(widget.date),
                                style: GoogleFonts.roboto(fontSize: width*.033,color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                        ),

                        SizedBox(height: height*.01,),
                        ///amount
                        Padding(
                          padding:  EdgeInsets.only(left: width*.06),
                          child: Text(
                            widget.amount ??'',
                            style: GoogleFonts.roboto(fontSize: width*.05,color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        SizedBox(height: height*.01,),

                        Padding(
                          padding:  EdgeInsets.only(left: width*.06),
                          child: Row(
                            children: [
                              Text(
                                'Total money credited',
                                style: GoogleFonts.roboto(fontSize: width*.03,color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: width*.05,),
                              Text(
                                '   AED $totalCredit',
                                style: GoogleFonts.roboto(fontSize: width*.033,color: Colors.green,
                                    fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: height*.01,),

                        Padding(
                          padding:  EdgeInsets.only(left: width*.06),
                          child: Row(
                            children: [
                              Text(
                                'Total money withdrawn',
                                style: GoogleFonts.roboto(fontSize: width*.03,color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: width*.05,),
                              Text(
                                'AED $totalWithdrew',
                                style: GoogleFonts.roboto(fontSize: width*.033,color: Colors.red,
                                    fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                        ),

                        formattedDescription.isNotEmpty?
                        SizedBox(height: height*.03,):SizedBox(),
                        ///description
                        formattedDescription.isNotEmpty?
                        Padding(
                          padding: EdgeInsets.only(left: width * .06),
                          child: Text(
                            formattedDescription,
                            style: GoogleFonts.roboto(
                              fontSize: width * .04,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ):Text(''),
                        formattedDescription.isNotEmpty?
                        SizedBox(height: height*.03,):SizedBox(),

                        Padding(
                          padding:  EdgeInsets.only(left: width*.06),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionHistory(affiliate : widget.affiliate),));
                            },
                            child: Text(
                              'View Transaction History',
                              style: GoogleFonts.roboto(fontSize: width*.033,color:ColorConstants.secondaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(height: height*.03,),


                      ],
                    ),
                  ),
                  SizedBox(height: height*.05,),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5), // Curved edges

                  ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: width*.01),
                          child: Text('Bring Leads. Earn More.',style: GoogleFonts.roboto(color: Colors.white,fontSize: width*.065,
                              fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: height*.01,),
                        Padding(
                          padding:  EdgeInsets.only(left: width*.01),
                          child: Text('The more leads you share, the more money you make. Start referring and watch'
                              ' your income grow — right from your network.',
                              style: GoogleFonts.roboto(color: Colors.white,fontSize: width*.035,
                              fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
