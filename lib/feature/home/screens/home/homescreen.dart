import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/home/controllor/leads-controller.dart';
import 'package:icanyon/feature/home/screens/home/viewPage.dart';
import 'package:icanyon/feature/profile/Screens/profile.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:upgrader/upgrader.dart';
import '../../../profile/Screens/notification.dart';
import '../connect/connect-page.dart';
import 'notification-page.dart';

class Homescreen extends ConsumerWidget {
  final AffiliateModel? affiliate;
  const Homescreen({super.key, this.affiliate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadsAsync = ref.watch(leadsStreamProvider(''));
    final name = affiliate?.name ?? '';
    final userId = affiliate?.userId ?? '';
    final profile = affiliate?.profile ?? '';

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: UpgradeAlert(
        child: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: ColorConstants.primaryColor,
                      elevation: 0,
                      pinned: true, // keeps app bar fixed
                      floating: false,
                      snap: false,
                      automaticallyImplyLeading: false,
                      titleSpacing: 16,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * .03),
                          Text(
                            name.toUpperCase(),
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: width * 0.05,
                            ),
                          ),
                          Text(
                            userId,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: Colors.transparent,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => ConnectPage(
                        //           affiliate: affiliate,
                        //           leadasync: leadsAsync,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: Icon(
                        //     Icons.add,
                        //     color: Colors.black,
                        //     size: width * .08,
                        //   ),
                        // ),
                        SizedBox(width: width * .03),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 11),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => Profile(affiliate: affiliate),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: width * 0.01),
                              child: CircleAvatar(
                                radius: width * 0.04,
                                backgroundImage: affiliate?.profile != null &&
                                    affiliate!.profile.isNotEmpty
                                    ? NetworkImage(affiliate!.profile)
                                    : const AssetImage(
                                    'assets/images/defulat-profile.png')
                                as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ];
                },
                body: leadsAsync.when(
                  data: (leads) {
                    if (leads.isEmpty) {
                      return const Center(child: Text('No leads available'));
                    }
                    return ListView.builder(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      physics: const BouncingScrollPhysics(),
                      itemCount: leads.length,
                      itemBuilder: (context, i) {
                        return _LeadCard(lead: leads[i], affiliate: affiliate);
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) =>
                      Center(child: Text('Error: $e', style: TextStyle(color: Colors.red))),
                ),
              ),
            ),
            // Black background section with white text
            Stack(
              children: [
                ClipRRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ConnectPage(affiliate: affiliate, leadasync: leadsAsync,),),);
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.8),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Looking for more opportunities?',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Text('Apply now',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: width * 0.01),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.white,
                                  size: width * 0.04,
                                ),
                              ],
                            ),
                          ],
                        ),
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
  }
}

class _LeadCard extends StatelessWidget {
  final dynamic lead; // Replace with your model type if available
  final AffiliateModel? affiliate;
  const _LeadCard({super.key, required this.lead, this.affiliate});

  @override
  Widget build(BuildContext context) {
    final logoUrl =
    (lead.logo != null && lead.logo is String) ? (lead.logo as String) : '';
    final name = (lead.name ?? '').toString();
    final industry = (lead.industry ?? '').toString();
    final firmsCount = (lead.firms is List) ? (lead.firms as List).length : 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with company logo and name
          Row(
            children: [
              Container(
                width: width * 0.15,
                height: width * 0.08,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: logoUrl.isNotEmpty
                      ? Image.network(
                    logoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          'assets/images/noFirmLogo.jpeg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                  )
                      : Image.asset(
                    'assets/images/noFirmLogo.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported,
                        color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isNotEmpty
                          ? name[0].toUpperCase() + name.substring(1)
                          : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Dubai', // Replace with lead.location if available
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.032,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * .03),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                  size: width * .06,
                ),
              )
            ],
          ),

          SizedBox(height: height * .04),

          // Timeline dots
          Padding(
            padding: EdgeInsets.only(left: width * .07, right: width * .07),
            child: Row(
              children: [
                _dot(),
                Expanded(child: _line()),
                _dot(),
                Expanded(child: _line()),
                _dot(),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Labels under timeline
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: width * .05),
                  child: Text(
                    industry,
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '$firmsCount Leads\nAdded',
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Commission\nBased',
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          SizedBox(height: height * .03),

          // Bottom row with avatars and View button
          Row(
            children: [
              SizedBox(
                width: width * 0.4,
                height: width * 0.085,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (int i = 0;
                    i < (imageList.length > 5 ? 5 : imageList.length);
                    i++)
                      Positioned(
                        left: i * (width * 0.04),
                        child: Container(
                          width: width * 0.1,
                          height: width * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            image: DecorationImage(
                              image: AssetImage(imageList[i]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (imageList.length > 5)
                      Positioned(
                        left: 5 * (width * 0.04),
                        child: Container(
                          width: width * 0.1,
                          height: width * 0.1,
                          decoration: BoxDecoration(
                            color: ColorConstants.appBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              '+${imageList.length - 5}',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: width * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) =>
                            ViewPage(lead: lead, affiliate: affiliate)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: width * .03),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'View',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: width * 0.025,
      height: width * 0.025,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
    );
  }

  Widget _line() => Container(height: 1, color: Colors.black);
}