import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/common/alertbox.dart';
import '../../../../core/common/global variables.dart';
import '../../../../core/constants/color-constnats.dart';

class StatusRequestPage extends StatefulWidget {
  final String status;
  const StatusRequestPage({super.key, required this.status});

  @override
  State<StatusRequestPage> createState() => _StatusRequestPageState();
}

class _StatusRequestPageState extends State<StatusRequestPage> {
  String selectedStatus = '';

  final List<String> statuses = [
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

  Color? getBorderColor(String status) {
    if (status == 'Completed') return Color(0xFF3FFF99);
    if (status == 'Not Qualified' || status == 'Lost') return Color(0xFFFF0000);
    if (status == 'New Lead') return Color(0xFF3FA2FF);
    return Color(0xFFA3B500);
  }


  Icon? getIcon(String status) {
    if (status == selectedStatus) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 18);
    }
    return null;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar:AppBar(
      backgroundColor: ColorConstants.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: width *.22),
              child: Text(
                'Lead Status Update Request',
                style: GoogleFonts.roboto(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: height * .03),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: height * 0.02,
                left: width * .03,
                right: width * .03,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: statuses.map((status) {
                    return GestureDetector(
                      onTap: () {
                        if (status != selectedStatus) {
                          showCommonAlertBox(context,'Do you want to send status change request?',(){},'Yes');
                        }
                      },
                      child: Container(
                        height: height*.06,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: status == selectedStatus
                              ? (getBorderColor(status) ?? Colors.grey).withOpacity(0.05)
                              : Colors.white,
                          border: Border.all(color: getBorderColor(status) ?? Colors.grey,width: width*.001),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only( left: width*.05),
                              child: Text(
                                status,
                                style: GoogleFonts.roboto(
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5E5E5E),
                                ),
                              ),
                            ),
                            if (status == selectedStatus) Padding(
                              padding:  EdgeInsets.only(right: width*.03),
                              child: getIcon(status)!,
                            ),
                          ],
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
  }
}