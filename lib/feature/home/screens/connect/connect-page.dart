import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/alertbox.dart';
import 'package:icanyon/feature/home/screens/connect/view-connect.dart';
import 'package:icanyon/feature/home/screens/home/profile-tab-page.dart';
import 'package:icanyon/feature/home/screens/home/tabbarpage.dart';
import 'package:icanyon/model/affiliate-model.dart';

import '../../../../core/common/global variables.dart';
import '../../../../core/constants/color-constnats.dart';
import '../../../../model/leads-model.dart';
import '../../../../model/serviceLeadModel.dart';
import '../../../profile/Screens/profile.dart';
import 'connect-card-tap-page.dart';

class ConnectPage extends StatelessWidget {
  final AffiliateModel? affiliate;
  final AsyncValue<List<LeadsModel>>? leadasync;

  const ConnectPage({super.key, this.affiliate, this.leadasync});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConstants.primaryColor,
            elevation: 0,
            pinned: false,
            floating: false,
            snap: false,
            automaticallyImplyLeading: false,
            titleSpacing: 16,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
                const SizedBox(width: 8),
                Text(
                  'CONNECT',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: width * .05,
                  ),
                ),
              ],
            ),
            actions: [
              SizedBox(width: width * .03),
               Icon(Icons.search_rounded, color: Colors.black,size: width*.065,),
              SizedBox(width: width * .03),

            ],
          ),

          ...leadasync!.when<List<Widget>>(
            data: (leads) {
              if (leads.isEmpty) {
                return const [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('No leads available')),
                  )
                ];
              }
              return [
                // ✅ Filter Row section
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: getFilterBox(leads).map((item) {
                        return GestureDetector(
                          onTap: item['onTap'],
                          child: Container(
                            width: width * 0.28,
                            height: height * 0.045,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3F3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                item['title'],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: width * 0.033,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // ✅ Leads List
                SliverPadding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, i) =>
                          _LeadCard(lead: leads[i], affiliate: affiliate),
                      childCount: leads.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ];
            },
            loading: () => const [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            ],
            error: (e, _) => [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                    child: Text('Error: $e',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// ✅ Moved filter generator OUTSIDE _LeadCard
List<Map<String, dynamic>> getFilterBox(List<LeadsModel> leads) {
  return [
    {
      'title': 'Industry',
      'onTap': () {
        debugPrint("Filter by Industry tapped!"); // TODO: real logic
      },
    },
    {
      'title': 'Location',
      'onTap': () {
        debugPrint("Filter by Location tapped!");
      },
    },
    {
      'title': 'Job',
      'onTap': () {
        debugPrint("Filter by Job tapped!");
      },
    },
  ];
}

/* ========================================================= */

class _LeadCard extends StatelessWidget {
  final dynamic lead;
  final AffiliateModel? affiliate;
  const _LeadCard({super.key, required this.lead, this.affiliate});

  @override
  Widget build(BuildContext context) {
    final logoUrl =
    (lead.logo != null && lead.logo is String) ? (lead.logo as String) : '';
    final name = (lead.name ?? '').toString();
    final industry = (lead.industry ?? '').toString();
    final List<String> locations = [
      "Dubai",
      "Abu Dhabi",
      "Sharjah",
      "Ajman",
      "Fujairah",
      "Ras Al Khaimah",
      "Umm Al Quwain",
      "Al Ain"
    ];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConnectInnerPage(lead: lead)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: width * 0.9,
        height: height * .35, // Increased card height a bit to fit grid
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header row
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
                          errorBuilder: (c, e, s) => Image.asset(
                              'assets/images/noFirmLogo.jpeg',
                              fit: BoxFit.cover),
                        )
                            : Image.asset('assets/images/noFirmLogo.jpeg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.roboto(
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text('Dubai | Education',
                              style: GoogleFonts.roboto(
                                fontSize: width * 0.032,
                                color: Colors.grey[600],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height * .015),
                      child: Icon(Icons.more_vert_rounded,
                          color: Colors.black, size: width * .06),
                    )
                  ],
                ),
                SizedBox(height: height * .02),

                /// Looking at section
                Padding(
                  padding: EdgeInsets.only(right: width * .3),
                  child: Text(
                    'Looking at :',
                    style: GoogleFonts.roboto(
                      fontSize: width * .04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: height * .01),
                /// ✅ Locations Grid
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...List.generate(
                      locations.length > 6 ? 6 : locations.length,
                          (i) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Text(
                          locations[i],
                          style: GoogleFonts.roboto(
                            fontSize: width * .032,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    // Show "+N Cities" pill if more than 5
                    if (locations.length > 6)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Text(
                          "+${locations.length - 6} Cities",
                          style: GoogleFonts.roboto(
                            fontSize: width * .032,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: height * .02),

                /// Looking at section
                Padding(
                  padding: EdgeInsets.only(right: width * .3),
                  child: Text(
                    'Job Type :',
                    style: GoogleFonts.roboto(
                      fontSize: width * .04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: height * .005),
                Text('Full-Time | Part-Time\nCommission Based',
                    style: GoogleFonts.roboto(
                      fontSize: width * 0.032,
                      color: Colors.grey[600],
                    )),
              ],
            ),

            // Apply button
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  connectAlertBox(context,
                      description: 'Are you sure you want to apply for the job at Crown Inox?',
                      onViewPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConnectViewPage(lead: lead),
                          ),
                        );
                      },
                      onConfirmPressed: () {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Apply Now',
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dot() => Container(
    width: width * 0.025,
    height: width * 0.025,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 1),
    ),
  );

  Widget _vline() => Container(width: 1, color: Colors.black);
}