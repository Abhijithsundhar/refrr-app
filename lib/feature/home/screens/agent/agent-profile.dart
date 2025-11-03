import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/home/screens/agent/agent-account-tab.dart';
import 'package:icanyon/feature/home/screens/agent/agent-personal-info.dart';
import 'package:icanyon/model/agent_model.dart';

import 'agent-careerprefer-page.dart';
import 'agent-prefessional-info.dart';

class AgentProfile extends StatefulWidget {
  final AgentModel agentModel;
  const AgentProfile({Key? key,required this.agentModel}) : super(key: key);

  @override
  State<AgentProfile> createState() => _AgentProfileState();
}

class _AgentProfileState extends State<AgentProfile>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          SvgPicture.asset('assets/svg/settings.svg'),
          SizedBox(width: width * .025),
        ],
      ),

      /// Bottom Bar with Contact Row
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left side (Profile image + Name + Location)
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.agentModel.profile),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.agentModel.name,
                        style: GoogleFonts.roboto(
                          fontSize: width*.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.agentModel.country,
                        style: GoogleFonts.roboto(
                          fontSize: width*.035,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// Right side (icons)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle message action
                      print('Message tapped');
                      // Add your message functionality here
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0x1A0FDCEA),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: SvgPicture.asset('assets/svg/whatsapp.svg', width: 22,
                        height: 22,
                        fit: BoxFit.contain,)),
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      // Handle phone call action
                      print('Phone tapped');
                      // Add your phone call functionality here
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0x1A0FDCEA),
                        shape: BoxShape.circle,
                      ),
                      child:Center(
                        child: SvgPicture.asset(
                          'assets/svg/phonecall.svg',
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          /// Profile Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: width * .04, right: width * .04),
              child: Row(
                children: [
                  /// Profile image
                  Container(
                    width: width * .27,
                    height: height * .2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.agentModel.profile,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: width * .02),

                  /// Name + Stats
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         widget.agentModel.name,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: width * .055,
                          ),
                        ),
                        Text(
                          widget.agentModel.country,
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: width * .04,
                          ),
                        ),
                        SizedBox(height: height * .03),
                        Row(
                          children: [
                            _statBox('21', 'Total\nLeads'),
                            SizedBox(width: width * .015),
                            _statBox('89%', 'Leads\nQuality'),
                            SizedBox(width: width * .015),
                            _statBox('10', 'Total\nAgents'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          /// Add space before TabBar
          SliverToBoxAdapter(
            child: SizedBox(height: height * .03),
          ),

          /// Sticky TabBar with fixed height
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              child: Container(
                height: 48,
                width: double.infinity,
                color: Colors.grey[100],
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.roboto(
                    fontSize: width * .037,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.roboto(
                    fontSize: width * .035,
                    fontWeight: FontWeight.w400,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  tabs: const [
                    Tab(text: 'Account'),
                    Tab(text: 'Personal info'),
                    Tab(text: 'Professional info'),
                    Tab(text: 'Career preference'),
                  ],
                ),
              ),
            ),
          ),
        ],

        /// Tab Content
        body: TabBarView(
          controller: _tabController,
          children: [
            /// Account Tab
            AccountTab(),

            /// Personal Info Tab
            PersonalInfoPage(),

            /// Professional Info Tab
            PrefessionalInfoPage(),

            /// Career Preferences Tab
            CareerPreferancePage(),
          ],
        ),
      ),
    );
  }

  /// --- Helper UI builders ---

  Widget _statBox(String value, String label) {
    return Container(
      width: width * .2,
      height: height * .1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black,width: width*.002),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.roboto(
              color: ColorConstants.appBlue,
              fontSize: width * .06,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: width * .03,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6F6F6F),
            ),
          ),
        ],
      ),
    );
  }
}

/// Fixed Sliver delegate with explicit height
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverTabBarDelegate({required this.child});

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}