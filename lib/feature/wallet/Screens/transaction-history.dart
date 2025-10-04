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
        'image': e.image,
        'description': e.description,
        'currency': e.currency,
      }),
      ...((affiliate?.totalWithdrawals ?? <dynamic>[]) as List<TotalWithdrawalsModel>)
          .map((e) => {
        'type': 'Withdraw',
        'amount': e.amount,
        'date': e.addedTime,
        'image': e.image,
        'description': e.description,
        'currency': e.currency,
      }),
    ];

    allTransactions.sort(
            (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));

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
          'Your Transactions', // ✅ moved to AppBar
          style: GoogleFonts.roboto(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false, // ✅ aligns closer to back arrow
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              padding: EdgeInsets.only(top: height * .05, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    /// Totals box
                    Container(
                      height: height * .17,
                      width: width * .9,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 173, 185, 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Money Credited : ',
                                style: GoogleFonts.roboto(
                                    fontSize: width * .038,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " AED ${affiliate?.totalCredit ?? ''}",
                                style: GoogleFonts.roboto(
                                    fontSize: width * .04,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Money Withdrawn :',
                                style: GoogleFonts.roboto(
                                    fontSize: width * .038,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " AED ${affiliate?.totalWithrew ?? ''}",
                                style: GoogleFonts.roboto(
                                    fontSize: width * .04,
                                    color: Colors.red[600],
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .01),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RejectedTransaction(affiliate: affiliate),
                                ),
                              );
                            },
                            child: Text(
                              "Review Rejected Transactions ➤",
                              style: GoogleFonts.roboto(
                                  fontSize: width * .035,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .05),

                    /// Transaction list
                    ListView.builder(
                      itemCount: allTransactions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final txn = allTransactions[index];
                        final date = txn['date'] as DateTime;
                        final type = txn['type'] as String;
                        final amount =
                        (txn['amount'] as num).toStringAsFixed(0);
                        final currency = txn['currency'] as String;

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}",
                                    style: GoogleFonts.roboto(
                                        fontSize: width * 0.035),
                                  ),
                                  Text(
                                    type,
                                    style: GoogleFonts.roboto(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    "$currency $amount",
                                    style: GoogleFonts.roboto(
                                      fontSize: width * 0.035,
                                      color: type == 'Credit'
                                          ? Colors.green
                                          : Colors.red,
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

                    /// Dynamic bottom spacing
                    allTransactions.length <= 1
                        ? SizedBox(height: height * .4)
                        : allTransactions.length == 2
                        ? SizedBox(height: height * .5)
                        : allTransactions.length == 3
                        ? SizedBox(height: height * .5)
                        : SizedBox(height: height * .2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}