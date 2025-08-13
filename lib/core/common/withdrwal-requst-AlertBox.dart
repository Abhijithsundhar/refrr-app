import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/snackbar.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:icanyon/model/leads-model.dart';

import '../../feature/Login/Controller/login-controller.dart';
import '../../feature/wallet/Screens/donePage.dart';
import '../../model/withdrew-requst-model.dart';
import '../constants/color-constnats.dart';
import 'global variables.dart';

void showWithdrawelRequstDialog(BuildContext context, int enteredAmount,
    AffiliateModel? affiliate, LeadsModel? lead) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: height * .05),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.roboto(
                    fontSize: width * .04,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(text: 'Please confirm your withdrawal request of  '),
                    TextSpan(
                      text: 'AED ${enteredAmount}.',
                      style: GoogleFonts.roboto(
                        fontSize: width * .042,
                        color: ColorConstants.primaryColor,
                        fontWeight:
                            FontWeight.w500, // Slightly bolder if needed
                      ),
                    ),
                    TextSpan(text: ' you requested'),
                  ],
                ),
              ),
              SizedBox(height: height * .05),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return GestureDetector(
                    onTap: () async {
                      if (enteredAmount != 0) {
                        final List<WithdrewrequstModel> updatedRequests = [
                          ...(affiliate!.withdrawalRequest ?? <WithdrewrequstModel>[]),
                          WithdrewrequstModel(
                            amount: enteredAmount,
                            acceptBy: affiliate.userId,
                            currency: 'AED',
                            status: false,
                            requstTime: DateTime.now(),
                            image: '',
                            description: '',
                          )
                        ];


                        final AffiliateModel updateAffiliate = affiliate.copyWith(withdrawalRequest: updatedRequests,);

                        await ref.read(affiliateControllerProvider.notifier)
                            .updateAffiliate(context: context, affiliateModel: updateAffiliate);

                      }
                      showCommonSnackbar(context, 'Withdrew request sent successfully');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllDoneScreen( affiliate : affiliate),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: height * .05,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorConstants.buttonColor,
                        borderRadius: BorderRadius.circular(
                            8), // Optional: rounded corners
                      ),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.roboto(
                            fontSize: width * .04,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: height * .05),
              SizedBox(height: height * .05),

            ],
          ),
        ),
      );
    },
  );
}
