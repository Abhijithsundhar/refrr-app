// Import statements
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/home/screens/home/bottombar.dart';
import 'package:icanyon/feature/home/screens/home/select-firm.dart';
import 'package:icanyon/feature/home/screens/home/viewSinglePage.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:icanyon/model/firm-model.dart';
import 'package:icanyon/model/leads-model.dart';
import 'package:icanyon/model/services-model.dart';
import 'package:intl/intl.dart';
import 'addfirm.dart';

class ViewPage extends StatefulWidget {
  final LeadsModel lead;
  final AffiliateModel? affiliate;

  const ViewPage({super.key, required this.lead, this.affiliate});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List<AddFirmModel> filteredFirms = [];
  TextEditingController searchController = TextEditingController();
  List<ServiceModel> allServices = [];

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
  }

  void onSearch(String query) {
    final result = widget.lead.firms.where((firm) {
      final name = firm.name?.toLowerCase() ?? '';
      final industry = firm.industryType?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) || industry.contains(query.toLowerCase());
    }).toList();

    result.sort((a, b) => b.createTime.compareTo(a.createTime));

    setState(() {
      filteredFirms = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BottomBarSection(initialIndex: 2, affiliate: widget.affiliate)),
                    (route) => false,
              );
            },
            child: Icon(Icons.wallet, color: Colors.white, size: width * .06),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: width * .07),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddFirmScreen()));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Lead name
          Padding(
            padding: EdgeInsets.only(left: width * .05),
            child: Text(
              widget.lead.name,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: width * .05,
                color: Colors.white,
              ),
            ),
          ),

          // Tabs Section
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Container(
                margin: EdgeInsets.only(top: height * .02),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * .035),

                    /// Tab bar with bubble
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .03),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEFDFE),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TabBar(
                          isScrollable: false,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BubbleTabIndicator(
                            indicatorHeight: 40,
                            indicatorColor: const Color(0xFFC1F6FA),
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              child: Text('Service',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * .035)),
                            ),
                            Tab(
                              child: Text('Firms',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * .035)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: height * .015),

                    /// Tab Views
                    Expanded(
                      child: TabBarView(
                        children: [
                          /// 🔹 Service Tab
                          allServices.isEmpty
                              ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: height * 0.1),
                              child: Text('No service found',
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey,
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                              : SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: height * 0.09),
                            child: Column(
                              children: List.generate(allServices.length, (index) {
                                final service = allServices[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04, vertical: width * 0.02),
                                  child: Container(
                                    height: 286,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F3F3),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        /// Image & Text
                                        Column(
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
                                              child: service.image.isNotEmpty
                                                  ? ClipRRect(
                                                borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: service.image,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 157,
                                                ),
                                              )
                                                  : const Center(
                                                child: Icon(Icons.image,
                                                    size: 50, color: Colors.grey),
                                              ),
                                            ),

                                            /// Details Section
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03,
                                                  vertical: height * 0.012),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /// Service Name
                                                  Text(
                                                    service.name.length > 17
                                                        ? '${service.name.toUpperCase().substring(0, 17)}...'
                                                        : service.name.toUpperCase(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                      color: const Color(0xFF00538E),
                                                      fontSize: width * .045,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),

                                                  SizedBox(height: height * .012),

                                                  /// Price Range
                                                  Row(
                                                    children: [
                                                      Text('Range :',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: width * .035)),
                                                      Text(
                                                          ' AED ${service.startingPrice} - ${service.endingPrice}',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: width * .035)),
                                                    ],
                                                  ),

                                                  /// Commission
                                                  Row(
                                                    children: [
                                                      Text('Commission :',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: width * .035)),
                                                      Text(' ${service.commission}%'.toUpperCase(),
                                                          style: GoogleFonts.roboto(
                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: width * .035)),
                                                    ],
                                                  ),

                                                  /// Leads Given
                                                  Row(
                                                    children: [
                                                      Text('Lead Given :',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: width * .035)),
                                                      Text(' 20',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: width * .035)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// "Lead" Button
                                        Positioned(
                                          top: height * .29,
                                          left: width * .57,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SelectFirm(
                                                    affiliate: widget.affiliate,
                                                    lead: widget.lead,
                                                    service: service,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: height * .05,
                                              width: width * .32,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: width * .07),
                                                  CircleAvatar(
                                                    radius: width * .025,
                                                    backgroundColor: Colors.grey,
                                                    child: Icon(Icons.add,
                                                        color: Colors.white,
                                                        size: width * .05),
                                                  ),
                                                  SizedBox(width: width * .02),
                                                  Text('Lead',
                                                      style: GoogleFonts.roboto(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: width * .035,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),

                          /// 🔹 Firm Tab
                          SingleChildScrollView(
                            padding:
                            EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 80),
                            child: Column(
                              children: [
                                if (filteredFirms.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(top: height * .1),
                                    child: Text('No firm found',
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey,
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w500)),
                                  )
                                else
                                  ...List.generate(filteredFirms.length, (index) {
                                    final firm = filteredFirms[index];
                                    return buildFirmCard(firm, index);
                                  }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 👇 Existing existing (unchanged) method for building firm-card
  Widget buildFirmCard(AddFirmModel firm, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * .02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Viewsinglepage(firm: firm, lead: widget.lead)),
          );
        },
        child: Container(
          width: width * 0.9,
          height: height * .16,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: EdgeInsets.all(width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name and Index
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firm.name ?? '',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00538E),
                        fontSize: width * .04,
                      ),
                    ),
                    Text(
                      '${(filteredFirms.length - index).toString().padLeft(2, '0')}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .005),
                Text(
                  firm.location ?? '',
                  style: GoogleFonts.roboto(color: Colors.grey, fontSize: width * .035),
                ),
                Text(
                  firm.industryType ?? '',
                  style: GoogleFonts.roboto(fontSize: width * .038, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(firm.createTime),
                      style: GoogleFonts.roboto(fontSize: width * .033),
                    ),
                    SizedBox(width:width*.49 ,),
                    Text(
                      firm.status ?? '',
                      style: GoogleFonts.roboto(fontSize: width * .038, fontWeight: FontWeight.w600,
                        color: firm.status == 'Pending' ? Color(0xFFDD903E):firm.status == 'Approved'? Color(0xFFDD903E)
                            :firm.status == 'Rejected'? Color(0xFFFA1616) :Color(0xFF1C4DFF)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}