import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/home/screens/home/addfirm.dart';
import 'package:icanyon/feature/home/screens/home/bottombar.dart';
import 'package:icanyon/feature/home/screens/home/profile-tab-page.dart';
import 'package:icanyon/feature/home/screens/home/select-firm.dart';
import 'package:icanyon/feature/home/screens/home/share-tab-page.dart';
import 'package:icanyon/feature/home/screens/home/view-all-agents.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:icanyon/model/firm-model.dart';
import 'package:icanyon/model/leads-model.dart';
import 'package:icanyon/model/services-model.dart';
import 'package:intl/intl.dart';
import '../agent/agent-add-page.dart';
import '../agent/agent-profile.dart';

class ViewPage extends StatefulWidget {
  final LeadsModel lead;
  final AffiliateModel? affiliate;

  const ViewPage({super.key, required this.lead, this.affiliate});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> with SingleTickerProviderStateMixin {
  List<AddFirmModel> filteredFirms = [];
  List<ServiceModel> allServices = [];

  final List<String> agentNames = [
    "Jamshid",
    "Jamshid",
    "Vishnu",
    "Fathima",
    "Rajan",
    "Aisha",
    "Rahul"
  ];
   TabController? _tabController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    filteredFirms = List.from(widget.lead.firms);
    filteredFirms.sort((a, b) => b.createTime.compareTo(a.createTime));
    allServices = widget.lead.firms
        .expand((firm) => firm.services ?? [])
        .where((service) => service.delete == false)
        .toList()
        .cast<ServiceModel>();

    _tabController = TabController(length: 4, vsync: this,);
    _tabController?.addListener(() {
      setState(() {
        _currentIndex = _tabController!.index;
      });
    });
  }
    @override
  void dispose() {
      _tabController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                size: width * .06, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.lead.name,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: width * .05,
              color: Colors.black,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBarSection(
                      initialIndex: 3,
                      affiliate: widget.affiliate,
                    ),
                  ),
                      (route) => false,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: width * .04),
                child: Image.asset(
                  'assets/images/walletIconServicePage.png',
                  width: width * .07,
                  height: width * .07,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        /// 👇 Floating rounded button on bottom-right
        floatingActionButton: _currentIndex == 2
            ? GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFirmScreen(affiliate:widget.affiliate,leads: widget.lead,),
              ),
            );
          },
          child: Container(
            height: height * 0.07,
            width: width * 0.25,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: width * 0.05,
                ),
                SizedBox(width: width*.002,),
                Text(
                  'Add',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.035,
                  ),
                ),
              ],
            ),
          ),
        )

            : null,

        body: NestedScrollView(
          headerSliverBuilder: (context, inner) => [
            /// Avatars area
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: width * .02),
                  SizedBox(
                    height: height * .13,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.length + 1,
                      itemBuilder: (context, index) {
                        final isFirst = index == 0;
                        final isLast = index == imageList.length;
                        final String displayName =
                        (!isFirst && !isLast && index < agentNames.length)
                            ? agentNames[index]
                            : "";

                        return Padding(
                          padding: EdgeInsets.only(
                              left: width * .035,
                              top: height * .01,
                              right: width * .02),
                          child: InkWell(
                            onTap: () {
                              if (isFirst) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (_) => const AddAgent(),
                                );
                              } else if (isLast) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ViewAllAgents()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AgentProfile()));
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: width * .15,
                                  height: width * .15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: (isFirst || isLast)
                                        ? Border.all(
                                        color: ColorConstants.appBlue,
                                        width: 1)
                                        : null,
                                  ),
                                  child: ClipOval(
                                    child: isFirst
                                        ? Icon(Icons.add,
                                        color: Colors.black,
                                        size: width * .07)
                                        : isLast
                                        ? Icon(Icons.arrow_forward,
                                        color: Colors.black,
                                        size: width * .07)
                                        : Image.asset(imageList[index],
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  isFirst
                                      ? "New\nAgent"
                                      : isLast
                                      ? "View All"
                                      : displayName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: width * .03,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: width * .025),
                ],
              ),
            ),

            /// Sticky TabBar
            SliverPersistentHeader(
              pinned: false,
              delegate: _SliverTabBarDelegate(
                Container(
                  height: height * .055,
                  width: width * 0.9,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.025),
                  decoration: BoxDecoration(
                    color: const Color(0x080FDCEA),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0x3300ADB9), width: 1),
                  ),
                  child: TabBar(
                    // controller: _tabController,
                    dividerColor: Colors.transparent,
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: GoogleFonts.roboto(
                        fontSize: width * .035,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    unselectedLabelColor: Colors.black,
                    indicator: ShapeDecoration(
                      color: const Color(0x330FDCEA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side:
                        const BorderSide(color: Color(0x3300ADB9), width: 1),
                      ),
                    ),
                    tabs: const [
                      Tab(text: 'Service'),
                      Tab(text: 'Share'),
                      Tab(text: 'Clients'),
                      Tab(text: 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ],

          /// Tab Content
          body: TabBarView(
            children: [
              /// Service tab
              allServices.isEmpty
                  ? Center(
                child: Text(
                  'No service found',
                  style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500),
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.only(bottom: height * .1),
                itemCount: allServices.length,
                itemBuilder: (context, index) {
                  final s = allServices[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: width * 0.02),
                    child: Stack(
                      children: [
                        Container(
                          height: 275,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 157,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: s.image.isNotEmpty
                                    ? ClipRRect(
                                  borderRadius:
                                  const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: s.image,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : const Center(
                                  child: Icon(Icons.image,
                                      size: 50,
                                      color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(width * 0.03),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(s.name.toUpperCase(),
                                        style: GoogleFonts.roboto(
                                            fontSize: width * .045,
                                            fontWeight: FontWeight.w600,
                                            color:
                                            const Color(0xFF00538E))),
                                    SizedBox(height: height * .01),
                                    Text("Range : AED ${s.startingPrice} - ${s.endingPrice}"),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Commission : ", // label
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: "${s.commission}%", // value
                                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text("Leads Given : 3", style: const TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: height * 0.26,
                          left: width * 0.56,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SelectFirm(
                                          lead: widget.lead,
                                          affiliate: widget.affiliate,
                                          service: s)));
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.black),
                                  borderRadius:
                                  BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: width * 0.025,
                                    backgroundColor: Colors.grey.shade300,
                                    child: Icon(Icons.add,
                                        color: Colors.white,
                                        size: width * 0.047),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Text('Lead',
                                      style: GoogleFonts.roboto(
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

              /// Share tab
              ShareTab(lead: widget.lead, affiliate: widget.affiliate),

              /// Clients tab
              filteredFirms.isEmpty
                  ? Center(
                  child: Text('No firm found',
                      style: GoogleFonts.roboto(
                          color: Colors.grey,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w500)))
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredFirms.length,
                itemBuilder: (context, i) => buildFirmCard(
                    filteredFirms[i],
                    i,
                    width,
                    height,
                    filteredFirms.length),
              ),

              /// Profile tab
              ProfileTab(lead: widget.lead),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirmCard(
      AddFirmModel firm, int index, double width, double height, int totalLength) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * .02),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: EdgeInsets.all(width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(firm.name ?? '',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            fontSize: width * .04,
                            color: const Color(0xFF00538E))),
                    Icon(Icons.more_vert_rounded, size: width * .055)
                  ]),
              Text(firm.location ?? '',
                  style: GoogleFonts.roboto(
                      fontSize: width * .035, color: Colors.grey)),
              Text(firm.industryType ?? '',
                  style: GoogleFonts.roboto(
                      fontSize: width * .038,
                      fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Text(DateFormat("dd-MM-yyyy").format(firm.createTime),
                      style: GoogleFonts.roboto(fontSize: width * .033)),
                  const Spacer(),
                  Text(
                    (totalLength - index).toString(),
                    style: GoogleFonts.roboto(
                        fontSize: width * .04,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// For pinned TabBar
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _tabBarWidget;
  _SliverTabBarDelegate(this._tabBarWidget);

  @override
  double get minExtent =>
      _tabBarWidget is PreferredSizeWidget ? (_tabBarWidget).preferredSize.height : 50;

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBarWidget,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}