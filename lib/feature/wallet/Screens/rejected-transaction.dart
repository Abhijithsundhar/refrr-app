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
          ?.where((e) => e.status == true) // status == true = rejected?
          .map((e) => {
        'type': 'Rejected',
        'amount': e.amount,
        'date': e.requstTime,
        'reason': 'No reason provided',
      }) ??
          <Map<String, dynamic>>[]),
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
          'Rejected Transactions',  // ✅ moved here
          style: GoogleFonts.roboto(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false, // ✅ aligns left, closer to back arrow
      ),

      body: allTransactions.isEmpty
          ? Center(
        child: Text(
          "No transaction rejected yet",
          style: GoogleFonts.roboto(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      )
          : Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        padding:
        EdgeInsets.only(top: height * .03, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(45)),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          itemCount: allTransactions.length,
          itemBuilder: (context, index) {
            final txn = allTransactions[index];
            final date = txn['date'] as DateTime;
            final type = txn['type'] as String;
            final amount = txn['amount'];
            final reason = txn['reason'] as String;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "AED ${amount.toString()}",
                        style: GoogleFonts.roboto(
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 4, bottom: 8),
                  child: Text(
                    "Reason: $reason",
                    style: GoogleFonts.roboto(
                      fontSize: width * 0.032,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Divider(color: Colors.grey[300]),
              ],
            );
          },
        ),
      ),
    );
  }
}