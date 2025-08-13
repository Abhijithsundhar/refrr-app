import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/wallet/Screens/rejected-transaction.dart';
import 'package:icanyon/model/total-credit-model.dart';
import 'package:icanyon/model/total-withdrawal-model.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';
import '../../../model/affiliate-model.dart';

class TransactionHistory extends StatelessWidget {
  final AffiliateModel? affiliate;
  const TransactionHistory({super.key, this.affiliate});


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allTransactions = [
      ...(affiliate?.totalCredits ?? <TotalCreditModel>[]).map((e) => {
        'type': 'Credit',
        'amount': e.amount,
        'date': e.addedTime,
        'image':e.image,
        'description':e.description,
        'currency':e.currency,
      }),
      ...((affiliate?.totalWithdrawals ?? <dynamic>[]) as List<TotalWithdrawalsModel>).map((e) => {
        'type': 'Withdraw',
        'amount': e.amount,
        'date': e.addedTime,
        'image':e.image,
        'description':e.description,
        'currency':e.currency,
      }),
    ];

    allTransactions.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));


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
            padding:  EdgeInsets.only(right: width*.4),
            child: Text(
              'Your Transactions',
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
                      height: height * .17,
                      width: width*.9,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 173, 185, 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Money Credited : ', // Replace with your text
                                style: GoogleFonts.roboto(fontSize: width*.038,color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " AED ${affiliate!.totalCredit.toString()??''}", // Replace with your text
                                style: GoogleFonts.roboto(fontSize: width*.04,color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: height*.01),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Money Withdrawn :', // Replace with your text
                                style: GoogleFonts.roboto(fontSize: width*.038,color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " AED ${affiliate!.totalWithrew.toString()??''}", // Replace with your text
                                style: GoogleFonts.roboto(fontSize: width*.04,color: Colors.red[600],
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: height*.01),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  RejectedTransaction( affiliate : affiliate),));
                            },
                            child: Text("Review Rejected Transactions ➤",
                              style: GoogleFonts.roboto(fontSize: width*.035,color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: height*.05),
                    ListView.builder(
                      itemCount: allTransactions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final txn = allTransactions[index];
                        final date = txn['date'] as DateTime;
                        final type = txn['type'] as String;
                        final amount = (txn['amount'] as num).toStringAsFixed(0);
                        final currency = txn['currency'] as String;

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}",
                                    style: GoogleFonts.roboto(fontSize: width * 0.035),
                                  ),
                                  Text(
                                    type,
                                    style: GoogleFonts.roboto(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w400,
                                      // color: type == 'Credit' ? Colors.black87 : Colors.red[600],
                                      color:  Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    "$currency $amount",
                                    style: GoogleFonts.roboto(
                                      fontSize: width * 0.035,
                                      color: type == 'Credit' ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                          ],
                        );
                      },
                    ),
                    allTransactions.length == 1 ?
                    SizedBox(height: height*.4):
                    allTransactions.length == 2 ?
                    SizedBox(height: height*.5):
                    allTransactions.length == 3 ?
                    SizedBox(height: height*.5):
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

