import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:icanyon/model/leads-model.dart';

import '../../../core/common/global variables.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/common/withdrwal-requst-AlertBox.dart';

class Withdrawelpage extends StatefulWidget {
  final AffiliateModel? affiliate;
  final LeadsModel? lead;
  const Withdrawelpage({super.key, this.affiliate, this.lead});

  @override
  State<Withdrawelpage> createState() => _WithdrawelpageState();
}

class _WithdrawelpageState extends State<Withdrawelpage> {
  TextEditingController withdrewAmount = TextEditingController();
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
            padding:  EdgeInsets.only(right: width*.6),
            child: Text(
              'Withdrawal',
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
            padding: EdgeInsets.only(top: 60, left: 16, right: 16),
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
                        color: Color.fromRGBO(0, 103, 176, 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Available Balance', // Replace with your text
                            style: GoogleFonts.roboto(fontSize: width*.037,color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'AED ${widget.affiliate!.totalBalance}', // Replace with your text
                            style: GoogleFonts.roboto(fontSize: width*.1,color: ColorConstants.buttonColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*.05),
                    Padding(
                      padding:  EdgeInsets.only(right: width*.49),
                      child: Text(
                        "Enter withdrawal amount",
                        style: GoogleFonts.roboto(fontSize: width*.035,color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: height*.01),

                    Container(
                      height: height * .06,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: ColorConstants.texFieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: withdrewAmount,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center, // vertical alignment
                          decoration: InputDecoration(
                            labelText: '',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height*.11),
                    GestureDetector(
                        onTap: () {
                          final inputText = withdrewAmount.text.trim();

                          if (inputText.isEmpty) {
                            showCommonSnackbar(context, 'Please enter the amount to withdrew');
                            return;
                          }

                          final enteredAmount = int.tryParse(inputText) ?? 0;

                          if (enteredAmount > widget.affiliate!.totalBalance) {
                            showCommonSnackbar(context, 'Amount must be less than or equal to available balance');
                            return;
                          }

                          showWithdrawelRequstDialog(context,enteredAmount,widget.affiliate,widget.lead);
                        },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                        ),
                        child: Text(
                          'Request',
                          style: GoogleFonts.roboto(fontSize: width*.04,color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(height: height*.05),
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
