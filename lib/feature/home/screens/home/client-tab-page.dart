import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/global variables.dart';
import '../../../../model/firm-model.dart';
import '../../../../model/leads-model.dart';
import '../../../../model/affiliate-model.dart';
import 'addfirm.dart';
import 'viewSinglePage.dart';

class FirmsPage extends StatefulWidget {
  final List<AddFirmModel> filteredFirms;
  final LeadsModel lead;
  final AffiliateModel? affiliate;

  const FirmsPage({
    super.key,
    required this.filteredFirms,
    required this.lead,
    this.affiliate,
  });

  @override
  State<FirmsPage> createState() => _FirmsPageState();
}

class _FirmsPageState extends State<FirmsPage> {
  late List<AddFirmModel> displayedFirms;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedFirms = List.from(widget.filteredFirms);
    displayedFirms.sort((a, b) => b.createTime.compareTo(a.createTime));
  }

  void onSearch(String query) {
    final result = widget.filteredFirms.where((firm) {
      final name = firm.name?.toLowerCase() ?? '';
      final industry = firm.industryType?.toLowerCase() ?? '';
      final location = firm.location?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) ||
          industry.contains(query.toLowerCase()) ||
          location.contains(query.toLowerCase());
    }).toList();

    result.sort((a, b) => b.createTime.compareTo(a.createTime));

    setState(() {
      displayedFirms = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firms",
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: 'Search firms...',
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.grey.shade600,
                        fontSize: width * 0.038,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: width * 0.05,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey.shade600,
                          size: width * 0.05,
                        ),
                        onPressed: () {
                          searchController.clear();
                          onSearch('');
                        },
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.015,
                      ),
                    ),
                  ),
                ),
              ),

              // Firms List
              Expanded(
                child: displayedFirms.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: width * 0.2,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        searchController.text.isNotEmpty
                            ? 'No firms found for "${searchController.text}"'
                            : 'No firms found',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade600,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (searchController.text.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: TextButton(
                            onPressed: () {
                              searchController.clear();
                              onSearch('');
                            },
                            child: Text(
                              'Clear search',
                              style: GoogleFonts.roboto(
                                color: Colors.blue,
                                fontSize: width * 0.038,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: () async {
                    // Add refresh logic here
                    setState(() {
                      displayedFirms = List.from(widget.filteredFirms);
                      displayedFirms.sort((a, b) => b.createTime.compareTo(a.createTime));
                    });
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                      top: 10,
                      bottom: 100, // Extra space for FAB
                    ),
                    itemCount: displayedFirms.length,
                    itemBuilder: (context, index) {
                      final firm = displayedFirms[index];
                      return buildFirmCard(firm, index);
                    },
                  ),
                ),
              ),
            ],
          ),

          // Floating Action Button
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: width * .027,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: width * .025,
                        backgroundColor: Colors.black,
                        child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: width * .035
                        ),
                      ),
                    ),
                    SizedBox(width: width * .01),
                    Text(
                      'New',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: width * .035,
                        fontWeight: FontWeight.w400,
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

  Widget buildFirmCard(AddFirmModel firm, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * .015),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Viewsinglepage(
                    firm: firm,
                    lead: widget.lead
                )
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF3F3F3),
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        firm.name ?? 'Unknown Firm',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00538E),
                          fontSize: width * .042,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          (displayedFirms.length - index).toString().padLeft(2, '0'),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade500,
                            fontSize: width * 0.035,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Icon(
                          Icons.more_vert_rounded,
                          size: width * .05,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: height * .008),

                // Location
                if (firm.location != null && firm.location!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: height * .005),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: width * 0.035,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: Text(
                            firm.location,
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade600,
                              fontSize: width * .035,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Industry Type
                if (firm.industryType != null && firm.industryType!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: height * .008),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.025,
                        vertical: height * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Text(
                        firm.industryType!,
                        style: GoogleFonts.roboto(
                          fontSize: width * .032,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),

                // Bottom Row - Date and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: width * 0.032,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          DateFormat('dd MMM yyyy').format(firm.createTime),
                          style: GoogleFonts.roboto(
                            fontSize: width * .032,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    // Status (if available)
                    if (firm.status != null && firm.status!.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(firm.status!).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _getStatusColor(firm.status!),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          firm.status!,
                          style: GoogleFonts.roboto(
                            fontSize: width * .03,
                            fontWeight: FontWeight.w500,
                            color: _getStatusColor(firm.status!),
                          ),
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
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFDD903E);
      case 'approved':
        return const Color(0xFF28A745);
      case 'rejected':
        return const Color(0xFFFA1616);
      case 'active':
        return const Color(0xFF1C4DFF);
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}