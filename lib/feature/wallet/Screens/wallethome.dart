import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/wallet/Screens/transaction-history.dart';
import 'package:icanyon/feature/wallet/Screens/withdrawelpage.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color-constnats.dart';
import '../../../model/affiliate-model.dart';
import '../../home/controllor/leads-controller.dart';
import '../../home/screens/home/notification-page.dart';
import '../../profile/Screens/contact-us.dart';
import '../../profile/Screens/profile.dart';

// TODO: Make sure these imports point to your actual files
// import '../../wallet/Screens/transaction_history.dart';
// import '../../wallet/Screens/withdrawelpage.dart';

// TODO: Make sure these types/values exist in your project:
// - AffiliateModel
// - ColorConstants
// - leadsStreamProvider
// - TransactionHistory
// - Withdrawelpage

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

  final List<String> company = [
    'I-Canyon Technologies',
    'Fyra Travels',
    'Al Maase Auditing',
    'Kia Calicut',
  ];

  @override
  void initState() {
    super.initState();
    totalBalance = widget.affiliate!.totalBalance;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final leads = ref.watch(leadsStreamProvider(''));

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: width * .02, top: height * .02),
          child: Text(
            'WALLET',
            style: GoogleFonts.roboto(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: height * .02),
            child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => HomeNotificationPage(affiliate: widget.affiliate)
                    ),
                  );
                },
                child: Stack(
                    children: [
                      SvgPicture.asset('assets/svg/update_unfill.svg',height: 28),
                      Positioned(child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: Center(child: Text('3',style: GoogleFonts.roboto(
                            fontSize: width*.02,color: Colors.white
                        ),)),
                      ))
                    ])),
          ),
          SizedBox(width: width * .035),
          Padding(
            padding: EdgeInsets.only(right: width * 0.04, top: height * .02),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Profile(affiliate: widget.affiliate),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.03),
                child: CircleAvatar(
                  radius: width * 0.04,
                  backgroundImage: widget.affiliate?.profile != null &&
                      widget.affiliate!.profile.isNotEmpty
                      ? NetworkImage(widget.affiliate!.profile)
                      : const AssetImage(
                      'assets/images/defulat-profile.png')
                  as ImageProvider,
                ),
              ),
            ),
          ),
        ],
      ),

      // ✅ Only body is scrollable, AppBar stays fixed
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Render one card per company (cards = company.length)
          children: List.generate(company.length, (index) {
            final companyName = company[index];
            return Padding(
              padding: EdgeInsets.only(
                left: width * .06,
                right: width * .06,
                bottom: height * .02,
                top: height * .03,
              ),
              child: Container(
                width: double.infinity,
                height: height * .77,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * .04),
                    // Company name from list
                    Text(
                      companyName,
                      style: GoogleFonts.roboto(
                        fontSize: width * .04,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Added Date : ${DateFormat('dd-MM-yyyy').format(widget.affiliate?.createTime ?? DateTime.now())}",
                      style: GoogleFonts.roboto(
                        fontSize: width * .03,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
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
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFF33A847)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: height * .015),
                                Text(
                                  'AED ',
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xFF33A847),
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  widget.affiliate?.totalCredit.toString() ??
                                      "0",
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
                              color: Colors.white,
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
                                  widget.affiliate?.totalWithrew.toString() ??
                                      "0",
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
                        style: GoogleFonts.roboto(
                          fontSize: width * .033,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: height * .002),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: width * .07),
                      child: Container(
                        height: height * .05,
                        width: width * .8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // Show count from company list
                            company.length.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: width * .04,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.only(right: width * .53),
                      child: Text(
                        "Total Invoice :",
                        style: GoogleFonts.roboto(
                          fontSize: width * .033,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: height * .002),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: width * .07),
                      child: Container(
                        height: height * .05,
                        width: width * .8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (widget.affiliate?.totalCredits.length ?? 0)
                                .toString(),
                            style: GoogleFonts.roboto(
                              fontSize: width * .04,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
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
                            "Available Balance : ",
                            style: GoogleFonts.roboto(
                              fontSize: width * .037,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            // "AED ${widget.affiliate?.availableBalance ?? 0}",
                            "AED 965",
                            style: GoogleFonts.roboto(
                              fontSize: width * .04,
                              color: const Color(0xFF33A847),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.only(right: width * .31),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionHistory(
                                  affiliate: widget.affiliate),
                            ),
                          );
                        },
                        child: Text(
                          "View Transaction History",
                          style: GoogleFonts.roboto(
                            fontSize: width * .037,
                            color: ColorConstants.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .03),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Withdrawelpage(
                              affiliate: widget.affiliate,
                              lead: null, // since no leads now
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: width * .7,
                        height: height * .06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(210, 0, 0, 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Withdraw',
                          style: GoogleFonts.roboto(
                            fontSize: width * .043,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "For any questions or concerns, please contact",
                          style: GoogleFonts.roboto(
                            fontSize: width * .035,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * .27),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()),
                              );
                            },
                            child: Text(
                              // widget.affiliate?.name ?? "",
                              "I-canyon Technologies",
                              style: GoogleFonts.roboto(
                                fontSize: width * .037,
                                color: ColorConstants.secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}