import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/model/affiliate-model.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';
import '../../../model/withdrew-requst-model.dart';

class RejectedTransaction extends StatelessWidget {
  final AffiliateModel? affiliate;
  const RejectedTransaction({super.key, required this.affiliate});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allTransactions = [
      ...(affiliate?.withdrawalRequest
          ?.where((e) => e.status == true)
          .map((e) => {
        'type': 'Rejected',
        'amount': e.amount,
        'date': e.requstTime,
        'reason': 'No reason provided',
      }) ??
          <Map<String, dynamic>>[]),
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
              'Rejected Transactions',
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
                    SizedBox(height: height*.05),
                    ListView.builder(
                      itemCount: allTransactions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final txn = allTransactions[index];
                        final date = txn['date'] as DateTime;
                        final type = txn['type'] as String;
                        final amount = txn['amount'];
                        final reason = txn['reason'] as String;


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
                                      fontWeight: FontWeight.w500,
                                      // color: type == 'Credit' ? Colors.black87 : Colors.red[600],
                                      color:  Colors.red,
                                    ),
                                  ),
                                  Text(
                                    "AED ${amount.toString()}",
                                    style: GoogleFonts.roboto(
                                      fontSize: width * 0.035,
                                      color: type == 'Rejected' ? Colors.black : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 4),
                                child: Text(
                                  "Reason: ${txn['reason']}",
                                  style: GoogleFonts.roboto(
                                    fontSize: width * 0.032,
                                    color: Colors.grey[700],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: height*.5),
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
