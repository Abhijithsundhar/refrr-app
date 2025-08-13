import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/wallet/Screens/transaction-history.dart';
import 'package:icanyon/feature/wallet/Screens/withdrawelpage.dart';
import 'package:intl/intl.dart';
import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';
import '../../../model/affiliate-model.dart';
import '../../home/controllor/leads-controller.dart';
import '../../profile/Screens/contact-us.dart';
import '../../profile/Screens/profile.dart';

class Wallethome extends ConsumerStatefulWidget {
  final AffiliateModel? affiliate;
  const Wallethome({super.key, this.affiliate});

  @override
  ConsumerState<Wallethome> createState() => _WallethomeState();
}

class _WallethomeState extends ConsumerState<Wallethome> {
  int totalFirms = 0;
  int totalCreditCount = 0;
  int totalBalance = 0;

  @override
  void initState() {
    super.initState();
    totalBalance = widget.affiliate!.totalBalance;
  }
  @override
  Widget build(BuildContext context) {
    final leads = ref.watch(leadsStreamProvider(''));
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        automaticallyImplyLeading: false, // optional: disables automatic back button
        title: Padding(
          padding: EdgeInsets.only(left: width * .02), // Optional padding
          child: Text(
            'Wallet',
            style: GoogleFonts.roboto(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(affiliate: widget.affiliate),
                  ),
                );
              },
              child: Container(
                width: width * .1,
                height: height * .1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                child: CircleAvatar(
                  backgroundColor: ColorConstants.primaryColor,
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*.03,),
            leads.when(
              data: (data) {
                totalCreditCount = widget.affiliate?.totalCredits.length ?? 0;
                /// ✅ Filter leads based on affiliate name or team membership
                final currentAffiliateName = widget.affiliate?.name ?? '';

                final filteredLeads = data.where((lead) =>
                lead.affiliate == currentAffiliateName || lead.teamMembers.contains(currentAffiliateName)
                ).toList();
                if (filteredLeads.isEmpty) {
                  return Center(
                    child: Text(
                      "No leads available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return Column(
                  children: filteredLeads.map((lead) {
                    final int firmsCount = lead.firms.length ?? 0;
                    return Padding(
                      padding: EdgeInsets.only(left: width * .06, right: width * .06, bottom: height * .02),
                      child: Container(
                        width: double.infinity,
                        height: height * .77,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
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
                          children: [
                            SizedBox(height: height * .04),
                            Text(
                              lead.name.toUpperCase(),
                              style: GoogleFonts.roboto(fontSize: width * .04, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Added Date : ${DateFormat('dd-MM-yyyy').format(lead.createTime)}",
                              style: GoogleFonts.roboto(fontSize: width * .03, color: Colors.black, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: height * .04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Total money \n   credited',
                                  style: GoogleFonts.roboto(
                                    fontSize: width * .035,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Total money \n  withdrawn',
                                  style: GoogleFonts.roboto(
                                    fontSize: width * .035,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: width * .3,
                                    height: height * .09,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: ColorConstants.buttonColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: height * .015),
                                        Text(
                                          'AED ',
                                          style: GoogleFonts.roboto(
                                            color: ColorConstants.buttonColor,
                                            fontSize: width * .04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          widget.affiliate!.totalCredit.toString(),
                                          style: GoogleFonts.roboto(
                                            color: ColorConstants.buttonColor,
                                            fontSize: width * .04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: width * .3,
                                    height: height * .09,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: height * .015),
                                        Text(
                                          'AED ',
                                          style: GoogleFonts.roboto(
                                            color: Colors.red,
                                            fontSize: width * .04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          widget.affiliate!.totalWithrew.toString(),
                                          style: GoogleFonts.roboto(
                                            color: Colors.red,
                                            fontSize: width * .04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .02),
                            Padding(
                              padding: EdgeInsets.only(right: width * .44),
                              child: Text(
                                "Total Firms Added :",
                                style: GoogleFonts.roboto(fontSize: width * .033, color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: height * .002),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width * .07),
                              child: Container(
                                height: height * .05,
                                width: width * .8,
                                decoration: BoxDecoration(
                                  color: ColorConstants.texFieldColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    firmsCount.toString(),
                                    style: GoogleFonts.roboto(fontSize: width * .04, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Padding(
                              padding: EdgeInsets.only(right: width * .53),
                              child: Text(
                                "Total Invoice :",
                                style: GoogleFonts.roboto(fontSize: width * .033, color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: height * .002),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width * .07),
                              child: Container(
                                height: height * .05,
                                width: width * .8,
                                decoration: BoxDecoration(
                                  color: ColorConstants.texFieldColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    totalCreditCount.toString(),
                                    style: GoogleFonts.roboto(fontSize: width * .04, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Padding(
                              padding: EdgeInsets.only(left: width * .07),
                              child: Row(
                                children: [
                                  Text(
                                    "Available Balance : ", style: GoogleFonts.roboto(fontSize: width * .037, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                  Text("AED ${totalBalance}",
                                    style: GoogleFonts.roboto(fontSize: width * .04, color: ColorConstants.buttonColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Padding(
                              padding: EdgeInsets.only(right: width * .31),
                              child: InkWell(
                                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionHistory(affiliate: widget.affiliate),),);
                                },
                                child: Text("View Transaction History",
                                  style: GoogleFonts.roboto(fontSize: width * .037, color: ColorConstants.secondaryColor, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: height * .03),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Withdrawelpage(affiliate: widget.affiliate, lead: lead),),
                                );
                              },
                              child: Container(
                                width: width * .7,
                                height: height * .06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(210, 0, 0, 1.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('Withdraw',
                                  style: GoogleFonts.roboto(fontSize: width * .043, color: Colors.white, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Text(
                              "For any questions or concerns, please contact",
                              style: GoogleFonts.roboto(fontSize: width * .035, color: Colors.black, fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * .27),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactUs(),
                                    ),
                                  );
                                },
                                child: Text(
                                  lead.name,
                                  style: GoogleFonts.roboto(fontSize: width * .037, color: ColorConstants.secondaryColor, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                debugPrint('Leads error: $err\n$stack');
                return Text("Error loading leads", style: TextStyle(color: Colors.red));
              },
            )
          ],
        ),
      ),
    );
  }
}
