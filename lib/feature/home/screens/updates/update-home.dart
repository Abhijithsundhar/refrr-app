import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/home/screens/updates/update-credit.dart';
import 'package:icanyon/feature/home/screens/updates/update-offer.dart';
import 'package:icanyon/feature/home/screens/updates/update-withdrew.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/global variables.dart';
import '../../../profile/Screens/profile.dart';
import '../home/notification-page.dart';

class UpdateHome extends StatelessWidget {
  final AffiliateModel? affiliate;
  const UpdateHome({super.key, required this.affiliate});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> updateList = [
      {
        'type': 'withdrawal',
        'title': 'Amount Withdrawn',
        'subtitle': 'AED 100',
        'date': DateTime.now(),
        'image': 'assets/images/withdrewUpdate.png',
        'color': Colors.red,
        'firm': 'Fyra',
      },
      {
        'type': 'credit',
        'title': 'Amount Credited',
        'subtitle': 'AED 250',
        'date': DateTime.now(),
        'image': 'assets/images/creditUpdate.png',
        'color': Colors.green,
        'firm': 'Kia Calicut',
      },
      {
        'type': 'offer',
        'title': 'Special Offer',
        'subtitle': 'AED 500',
        'date': DateTime.now(),
        'image': 'assets/images/targetUpdate.png',
        'color': Colors.deepPurple,
        'firm': 'Al Masee',
      },
      {
        'type': 'offer',
        'title': 'sales offer',
        'subtitle': 'AED 250',
        'date': DateTime.now(),
        'image': 'assets/images/offerImage1.png',
        'color': Colors.deepPurple,
        'firm': 'Kia Calicut',
      },
      {
        'type': 'offer',
        'title': '50% on Digital Marketing',
        'subtitle': 'AED 500',
        'date': DateTime.now(),
        'image': 'assets/images/offerImage2.png',
        'color': Colors.deepPurple,
        'firm': 'I-canyon technologies',
      },
    ];

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "UPDATES",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: width * 0.05,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => HomeNotificationPage(affiliate: affiliate)
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
          SizedBox(width: width * .035),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Profile(affiliate: affiliate),
                ),
              );
            },
            child: CircleAvatar(
              radius: width * 0.045,
              backgroundImage: affiliate?.profile != null && affiliate!.profile.isNotEmpty
                  ? NetworkImage(affiliate!.profile)
                  : const AssetImage('assets/images/defulat-profile.png') as ImageProvider,
            ),
          ),
          SizedBox(width: width * 0.04), // spacing from right edge
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: height * .02),
            Padding(
              padding: EdgeInsets.only(left: width*.04,right: width*.04,),
              child: GridView.builder(
                physics:
                const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .9,
                ),
                itemCount: updateList.length,
                itemBuilder: (context, index) {
                  final item = updateList[index];
                  return GestureDetector(
                    onTap: () {
                      // handle navigation based on type
                      switch (item['type']) {
                        case 'withdrawal':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateWithdrewPage(
                                affiliate: affiliate,
                                title: item['title'],
                                amount: item['subtitle'], // subtitle is already "AED 100"
                                date: item['date'],
                                image: item['image'],
                                description: "${item['firm']} has withdrawn ${item['subtitle']}",
                                currency: "AED",
                              ),
                            ),
                          );
                          break;

                        case 'credit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateCreditPage(
                                affiliate: affiliate,
                                title: item['title'],
                                amount: item['subtitle'], // "AED 250"
                                date: item['date'],
                                image: item['image'],
                                description: "${item['firm']} credited ${item['subtitle']}",
                                currency: "AED",                              ),
                            ),
                          );
                          break;

                        case 'offer':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateOfferPage(
                                affiliate: affiliate,
                                title: item['title'],
                                amount: item['subtitle'],
                                date: item['date'],
                                image: item['image'],
                                description: "Special offer from ${item['firm']}",
                                currency: "AED",                              ),
                            ),
                          );
                          break;

                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Unknown type tapped: ${item['type']}")),
                          );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.12,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            item['firm'],
                            style: GoogleFonts.roboto(
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: height*.004),
                          Text(
                            item['title'],
                            style: GoogleFonts.roboto(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: height*.002),
                          Text(
                            item['subtitle'],
                            style: GoogleFonts.roboto(
                              fontSize: width * 0.037,
                              fontWeight: FontWeight.w600,
                              color: item['color'],
                            ),
                          ),
                          SizedBox(height: height*.002),
                          Text(
                            DateFormat('dd-MM-yyyy').format(item['date']),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// === Helper Cards Below ===

  Widget _moneyCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required String amount,
    bool showButtons = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xE5F3F3F3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: GoogleFonts.roboto(
                      fontSize: width * .04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: width * .03,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: width * .04,
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: width * .05, top: height * .02),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * .02, top: height * .01),
                    child: Text(
                      description,
                      style: GoogleFonts.roboto(
                        fontSize: width * .035,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (showButtons) _actionButtons(),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required String amount,
    bool showButtons = false,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xE5F3F3F3),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(icon, color: iconColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: width * .04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.roboto(
                            fontSize: width * .03,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: width * .05, top: height * .02),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left: width * .02, top: height * .01),
                        child: Text(
                          description,
                          style: GoogleFonts.roboto(
                            fontSize: width * .035,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (showButtons) _actionButtons(),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: height * .03,
          right: width * .05,
          child: Center(
            child: Text(
              amount,
              style: GoogleFonts.roboto(
                // decoration: TextDecoration.underline,
                fontSize: width * .04,
                color: Color(0xFF0067B0),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width * .2,
            height: height * .04,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFA1616)),
              color: const Color(0x08FA1616),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'Reject',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: width * .035,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: width * .2,
            height: height * .04,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF33A847)),
              color: const Color(0x0833A847),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'Accept',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: width * .035,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}