import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/textedit-controllors.dart';
import 'package:icanyon/feature/home/controllor/leads-controller.dart';
import 'package:icanyon/model/leads-model.dart';

import '../../../../core/common/global variables.dart';
import '../../../../core/constants/color-constnats.dart';
import '../../../../model/firm-model.dart';

class Viewsinglepage extends StatefulWidget {
  final AddFirmModel firm;
  final LeadsModel lead;
  const Viewsinglepage({super.key, required this.firm, required this.lead});

  @override
  State<Viewsinglepage> createState() => _ViewsinglepageState();
}

class _ViewsinglepageState extends State<Viewsinglepage> {
  final List<String> statusOptions = ['Approved', 'Pending', 'Rejected', 'Invoice'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firmNameController.text = widget.firm.name;
    firmLocationController.text = widget.firm.location;
    firmIndustryController.text = widget.firm.industryType;
    firmAddressController.text = widget.firm.address;
    firmEmailController.text = widget.firm.email;
    firmStatusController.text = widget.firm.status;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title Section
            Padding(
              padding: EdgeInsets.only(left: width * .06),
              child: Text(
                widget.firm.name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: width * .05,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * .06),
              child: Text(
                widget.firm.location,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: width * .04,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            /// White Rounded Container
            Container(
              margin: EdgeInsets.only(top: height * 0.03),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///name
                  Text(
                    'Name',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                  SizedBox(height: height*.01),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.appBlue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      // readOnly: true, // <-- Disable typing
                      decoration: InputDecoration(
                        hintText: firmNameController.text,
                        hintStyle: GoogleFonts.roboto(color: Colors.black, fontWeight:FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  ///status
                  Text(
                    'Status',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                  SizedBox(height: height*.01),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.appBlue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Text(
                        firmStatusController.text,
                        style: GoogleFonts.roboto(
                          color: firmStatusController.text == 'Approved'
                              ? Colors.green
                              : firmStatusController.text == 'Rejected'
                              ? Colors.red
                              : firmStatusController.text == 'Invoice'
                              ? Colors.blue
                              : firmStatusController.text == 'Pending'
                              ? Colors.orange
                              : Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  ///location
                  Text(
                    'Location',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                  SizedBox(height: height*.01),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.appBlue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      // readOnly: true, // <-- Disable typing
                      decoration: InputDecoration(
                        hintText: firmLocationController.text,
                        hintStyle: GoogleFonts.roboto(color: Colors.black, fontWeight:FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  ///Industry
                  Text(
                    'Industry',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                  SizedBox(height: height*.01),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.appBlue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      // readOnly: true, // <-- Disable typing
                      decoration: InputDecoration(
                        hintText: firmIndustryController.text,
                        hintStyle: GoogleFonts.roboto(color: Colors.black, fontWeight:FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  ///Email
                  Text(
                    'Email',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                  SizedBox(height: height*.01),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.appBlue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      // readOnly: true, // <-- Disable typing
                      decoration: InputDecoration(
                        hintText: firmEmailController.text,
                        hintStyle: GoogleFonts.roboto(color: Colors.black, fontWeight:FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  ///Address
                  Text(
                    'Address',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                  SizedBox(height: height*.01),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.appBlue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      // readOnly: true, // <-- Disable typing
                      decoration: InputDecoration(
                        hintText: firmAddressController.text,
                        hintStyle: GoogleFonts.roboto(color: Colors.black, fontWeight:FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: height*.04),

                  ///buttons
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Consumer(builder: (context, ref, child) {
                        return GestureDetector(
                          onTap: () {
                            final updatedFirm = widget.firm.copyWith(
                              name: firmNameController.text,
                              // status: firmStatusController.text,
                              location: firmLocationController.text,
                              industryType: firmIndustryController.text,
                              email: firmEmailController.text,
                              address: firmAddressController.text,
                            );

                            // Clone current firms list
                            final updatedFirmList = [...widget.lead.firms];

                            // Identify firm index based on key fields
                            final index = updatedFirmList.indexWhere((firm) =>
                            firm.name == widget.firm.name &&
                                firm.email == widget.firm.email &&
                                firm.location == widget.firm.location
                            );

                            // Replace at index and update
                            if (index != -1) {
                              updatedFirmList[index] = updatedFirm;

                              final updatedLead = widget.lead.copyWith(firms: updatedFirmList);

                              ref.read(leadsControllerProvider.notifier).updateLeads(
                                leadsModel: updatedLead,
                                context: context,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Firm not found in list")),
                              );
                            }
                          },

                        child: Container(
                        width: width*.8,
                        height: height*.05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                        color: ColorConstants.buttonColor,
                        borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                        ),
                        child: Text(
                        'Save',
                        style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: width*.04,
                        fontWeight: FontWeight.w500,
                        ),
                        ),
            ),
            );
                      },),
                    ],
                  ),
                  SizedBox(height: height*.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
