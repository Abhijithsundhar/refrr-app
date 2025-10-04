import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/home/screens/funnel/pipeline-inner.dart';
import 'package:icanyon/feature/home/screens/funnel/status-RequestPage.dart';
import 'package:intl/intl.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:icanyon/model/serviceLeadModel.dart';
import '../../../../core/constants/servicelead-color.dart';
import '../../../profile/Screens/profile.dart';
import '../../controllor/serviceLead-controllor.dart';
import '../home/notification-page.dart';

class FunnelHome extends ConsumerStatefulWidget {
  final AffiliateModel? affiliate;
  const FunnelHome({super.key, this.affiliate});

  @override
  ConsumerState<FunnelHome> createState() => _FunnelHomeState();
}

class _FunnelHomeState extends ConsumerState<FunnelHome> {
  String? selectedStatus;
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedFirm;
  @override
  void initState() {
    String? getLatestStatus(List<Map<String, dynamic>> statusHistory) {
      if (statusHistory.isEmpty) return null;

      // Sort by date to get the latest status
      statusHistory.sort((a, b) {
        final aDate = (a['date'] as Timestamp?)?.toDate() ?? DateTime(2000);
        final bDate = (b['date'] as Timestamp?)?.toDate() ?? DateTime(2000);
        return bDate.compareTo(aDate); // descending
      });

      return statusHistory.first['status']?.toString();
    }

    super.initState();
  }
  String getTimeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
    } else if (diff.inDays == 1) {
      return "Yesterday";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return "$weeks week${weeks > 1 ? 's' : ''} ago";
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return "$months month${months > 1 ? 's' : ''} ago";
    } else {
      final years = (diff.inDays / 365).floor();
      return "$years year${years > 1 ? 's' : ''} ago";
    }
  }

  final List<String> statusList = [
    'New Lead',
    'Contacted',
    'Interested',
    'Follow-up-Needed',
    'Proposal Sent',
    'Negotiation',
    'Converted',
    'Invoice Raised',
    'Work in Progress',
    'Completed',
    'Not Qualified',
    'Lost'
  ];
  void _pickDateRange() async {
    final DateTime now = DateTime.now();

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(now.year, now.month, now.day),
      // helpText: 'Select a date range', // Optional UI text
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
    }
  }

  void _selectStatus() {
    final List<String> statusList = [
      'New Lead',
      'Contacted',
      'Interested',
      'Follow-Up-Needed',
      'Proposal Sent',
      'Negotiation',
      'Converted',
      'Invoice Raised',
      'Work in Progress',
      'Completed',
      'Not Qualified',
      'Lost',
    ];

    Color getBackgroundColor(String status) {
      switch (status) {
        case 'New Lead':
          return const Color(0xFFF5FAFF);
        case 'Completed':
          return const Color(0xFFF0FFF7);
        case 'Not Qualified':
        case 'Lost':
          return const Color(0xFFFFF2F2);
        default:
          return const Color(0xFFFAFBF2) ;
      }
    }

    Color getTextColor(String status) {
      switch (status) {
        case 'New Lead':
          return const Color(0xFF3FA2FF);
        case 'Completed':
          return const Color(0xFF3FFF99);
        case 'Not Qualified':
        case 'Lost':
          return const Color(0xFFFF7979);
        default:
          return const Color(0xFFCFD879);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🧭 Title & Close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lead status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 🎯 Status Wrap Buttons - aligned like your image
              Center(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: statusList.map((status) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedStatus = status;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        decoration: BoxDecoration(
                          color: getBackgroundColor(status),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: getTextColor(status).withOpacity(0.25),
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5E5E5E),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
  void _selectFirm(List<ServiceLeadModel> leads) async {
    // Unique lead names only (no duplicates)
    final uniqueLeadNames = leads.map((e) => e.leadName).toSet().toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: width * 0.05,
            right: width * 0.05,
            top: height * 0.02,
          ),
          child: SizedBox(
            height: height * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Lead',
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: width * 0.07),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Unique Lead Names List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: uniqueLeadNames.map((leadName) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: width * .03,
                            left: width * .03,
                            bottom: height * .01,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedFirm = leadName; // holds the selected lead name
                              });
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFF3F3F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              side: BorderSide(
                                color: const Color(0xFF828282),
                                width: width * .001,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 24,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                leadName,
                                style: GoogleFonts.roboto(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w500,
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
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> getFilterBox(List<ServiceLeadModel> leads) {

    return [
      {
        'title': 'All',
        'onTap': () {
          setState(() {
            selectedFirm = null;
            selectedStatus = null;
            fromDate = null;
            toDate = null;
          });
        },
      },
      {
        'title': selectedStatus ?? 'Status',
        // 'icon': Icons.arrow_drop_down,
        'onTap': _selectStatus,
      },
      {
        'title': fromDate != null && toDate != null
            ? "${DateFormat('dd/MM/yy').format(fromDate!)} - ${DateFormat('dd/MM/yy').format(toDate!)}"
            : 'Period',
        // 'icon': Icons.calendar_month_sharp,
        'onTap': _pickDateRange,
      },
      {
        'title': selectedFirm ?? 'Firms',
        // 'icon': Icons.arrow_drop_down,
        'onTap': () => _selectFirm(
            ref.read(serviceLeadsStreamProvider).asData?.value ?? []),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final leadsAsync = ref.watch(serviceLeadsStreamProvider);
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        automaticallyImplyLeading: false, // Hide default back button if any
        title: Text('PIPELINE',
          style: GoogleFonts.roboto(
            fontSize: width * .05,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
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
          SizedBox(width: width * .035),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile(affiliate: widget.affiliate),),);
            },
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.03),
              child: CircleAvatar(
                radius: width * 0.04,
                backgroundImage: widget.affiliate?.profile != null && widget.affiliate!.profile.isNotEmpty
                    ? NetworkImage(widget.affiliate!.profile)
                    : const AssetImage('assets/images/defulat-profile.png') as ImageProvider,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: height*.02,),
            SizedBox(
    width: double.infinity,
    // Ensure that minimum height fills the viewport
    child: ConstrainedBox(
    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - kToolbarHeight - height * 0.12,), // or tweak as needed
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: width * .03, right: width * .03, bottom: 30,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: leadsAsync.when(
                  data: (allLeads) {
                    List<ServiceLeadModel> filtered = allLeads;
                    // Get latest status
                    String? getLatestStatus(List<Map<String, dynamic>> history) {
                      if (history.isEmpty) return null;
                      history.sort((a, b) {
                        final aDate = (a['date'] as Timestamp?)?.toDate() ?? DateTime(2000);
                        final bDate = (b['date'] as Timestamp?)?.toDate() ?? DateTime(2000);
                        return bDate.compareTo(aDate);
                      });
                      return history.first['status']?.toString() ?? '';
                    }

                    // Apply filters
                    if (selectedStatus != null) {
                      filtered = filtered.where((lead) {
                        final latestStatus = getLatestStatus(lead.statusHistory);
                        return latestStatus?.toLowerCase() == selectedStatus?.toLowerCase();
                      }).toList();
                    }

                    if (fromDate != null && toDate != null) {
                      filtered = filtered.where((lead) {
                        return lead.createTime.isAfter(fromDate!.subtract(const Duration(days: 1))) &&
                            lead.createTime.isBefore(toDate!.add(const Duration(days: 1)));
                      }).toList();
                    }

                    if (selectedFirm != null) {
                      filtered = filtered.where((lead) => lead.firmName == selectedFirm).toList();
                    }

                    filtered.sort((a, b) => b.createTime.compareTo(a.createTime));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Filter Row
                        SizedBox(height: height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: getFilterBox(allLeads).map((item) {
                            return GestureDetector(
                              onTap: item['onTap'],
                              child: Container(
                                width: width * 0.22,
                                height: height * 0.043,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F3F3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    item['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                      fontSize: width * 0.03,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: height * 0.02),

                        /// Leads Grid or No Data Info
                        if (filtered.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: Center(child: Text("No leads found")),
                          )
                        else
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PipeLineInnerPage(),));
                            },
                            child: GridView.builder(
                              itemCount: filtered.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: width * 0.04,
                                mainAxisSpacing: height * 0.02,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final item = filtered[index];
                                final latestStatus = getLatestStatus(item.statusHistory) ?? '';
                                final statusColors = getStatusColors(latestStatus);
                                return buildLeadCard(item, statusColors, latestStatus);
                              },
                            ),
                          ),
                        SizedBox(height: height * 0.1),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error loading leads')),
                ),
              ),
            ),
            )],
        ),
      ),    );
  }

  Widget buildLeadCard(ServiceLeadModel item, StatusColors statusColors, String latestStatus) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: statusColors.border, width: width * .0015),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 👈 makes card height flexible
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 🟦 Top colored section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: statusColors.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * .02, vertical: height * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: width * .036,
                      backgroundColor: statusColors.border,
                      child: CircleAvatar(
                        radius: width * .035,
                        backgroundColor: Colors.white,
                        backgroundImage: widget.affiliate!.profile.isNotEmpty
                            ? NetworkImage(widget.affiliate!.profile)
                            : const AssetImage('assets/images/defulat-profile.png')
                        as ImageProvider,
                      ),
                    ),
                    SizedBox(width: width * .02),
                    Expanded(
                      child: Text(
                        widget.affiliate!.name,
                        style: GoogleFonts.roboto(
                          fontSize: width * .035,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height * .015),
                      child: Icon(Icons.more_vert_rounded,
                          color: Colors.black, size: width * .05),
                    )
                  ],
                ),
                SizedBox(height: height * .008),
                Text(
                  item.leadName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: width * .035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item.location,
                  style: GoogleFonts.roboto(
                    fontSize: width * .027,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          /// 🔽 Bottom section
          Container(
            width: double.infinity, // 👈 expand to full width
            decoration: BoxDecoration(
              color: statusColors.bigBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.025),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getTimeAgo(item.createTime),
                    style: GoogleFonts.roboto(
                      fontSize: width * .025,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * .004),
                  Text(
                    item.firmName,
                    style: GoogleFonts.roboto(
                      fontSize: width * .03,
                      fontWeight: FontWeight.w500,
                      // color: Colors.blue[900],
                    ),
                  ),
                  Text(
                    item.serviceName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: width * .04,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: height * .008),
                  Text(
                    'Status',
                    style: GoogleFonts.roboto(
                      fontSize: width * .027,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * .003),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatusRequestPage(status: latestStatus),
                        ),
                      );
                    },
                    child: Container(
                      height: height * .04,
                      width: width * .35, // little more space for text
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: statusColors.border,
                          width: width * .001,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          latestStatus,
                          style: GoogleFonts.roboto(
                            fontSize: width * .03,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
