import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/home/screens/home/bottombar.dart';
import 'package:icanyon/feature/home/screens/home/viewSinglePage.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:icanyon/model/firm-model.dart';
import 'package:icanyon/model/leads-model.dart';
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

  @override
  void initState() {
    super.initState();
    // filteredFirms = widget.lead.firms;
    filteredFirms = List.from(widget.lead.firms);
    filteredFirms.sort((a, b) => b.createTime.compareTo(a.createTime));
  }

  void onSearch(String query) {
    final result = widget.lead.firms.where((firm) {
      final name = firm.name?.toLowerCase() ?? '';
      final industry = firm.industryType?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) || industry.contains(query.toLowerCase());
    }).toList();

    result.sort((a, b) => b.createTime.compareTo(a.createTime)); // sort after filtering

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
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetector(onTap: (){

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                BottomBarSection(initialIndex:1,affiliate: widget.affiliate,)),(route) => false,);
          },
              child: Icon(Icons.wallet,color: Colors.white, size: width * .06)
            // Image.asset('assets/images/wallet.png')

          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: width * .07),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddFirmScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                height: height * .06,
                padding: EdgeInsets.only(left: width * .05, right: width * .04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: onSearch,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // Content container
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.lead.name,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: width * .05,
                        ),
                      ),
                      // Image.asset('assets/images/fillericon.png'),
                    ],
                  ),
                  SizedBox(height: height * .03),

                  // Firms list or message
                  filteredFirms.isEmpty
                      ? Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.1),
                    child: Text(
                      'No firm found',
                      style: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                      : (filteredFirms.length > 4
                      ? SizedBox(
                    height: height * 0.6,
                    child: ListView.builder(
                      itemCount: filteredFirms.length,
                      itemBuilder: (context, index) {
                        final firm = filteredFirms[index];
                        return buildFirmCard(firm, index);
                      },
                    ),
                  )
                      : Column(
                    children: List.generate(
                      filteredFirms.length,
                          (index) => buildFirmCard(filteredFirms[index], index),
                    ),
                  )),

                  SizedBox(height: height * .5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFirmCard(AddFirmModel firm, int index) {
    return Padding(
      padding: EdgeInsets.only(left: width * .01, bottom: height * .02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Viewsinglepage(firm :firm,lead:widget.lead)),
          );
        },
        child: Stack(
          children: [
            Container(
              width: width * 0.9,
              height: height * .16,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Index
                  Padding(
                    padding: EdgeInsets.only(left: width * .05, top: height * .028),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          firm.name ?? '',
                          style: GoogleFonts.roboto(
                            color: ColorConstants.primaryColor,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * .02),
                          child: Text(
                            "${(filteredFirms.length - index).toString().padLeft(2, '0')}",
                            style: GoogleFonts.inter(
                              color: ColorConstants.primaryColor,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Location
                  Padding(
                    padding: EdgeInsets.only(left: width * .047, top: height * .003),
                    child: Text(
                      firm.location??'',
                      style: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Industry Type
                  Padding(
                    padding: EdgeInsets.only(left: width * .047, top: height * .003),
                    child: Text(
                      firm.industryType ?? '',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Created Date
                  Padding(
                    padding: EdgeInsets.only(left: width * .047, top: height * .003),
                    child: Text(
                      DateFormat('dd-MM-yyyy').format(firm.createTime),
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Status
            Positioned(
              top: height * .11,
              right: width * .05,
              child: Container(
                width: width * 0.2,
                height: height * 0.035,
                child: Center(
                  child: Text(
                    firm.status,
                    style: TextStyle(
                      color: firm.status == 'Pending'
                          ? Colors.orange
                          : firm.status == 'Approved'
                          ? Colors.green
                          : firm.status == 'Rejected'
                          ? Colors.red
                          : firm.status == 'Invoice'
                          ? Colors.blue
                          : Colors.black, // default fallback
                      fontSize: width * .04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
