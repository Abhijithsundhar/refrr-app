import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/home/screens/home/addfirm.dart';
import '../../../../core/common/alertbox.dart';
import '../../../../core/common/global variables.dart';
import '../../../../core/constants/color-constnats.dart';
import '../../../../core/constants/firebaseConstants.dart';
import '../../../../model/affiliate-model.dart';
import '../../../../model/leads-model.dart';
import '../../../../model/firm-model.dart';
import '../../../../model/serviceLeadModel.dart';
import '../../../../model/services-model.dart';
import '../../controllor/serviceLead-controllor.dart'; // ✅ Import Firm Model

class SelectFirm extends StatelessWidget {
  final LeadsModel lead;
  final AffiliateModel? affiliate;
  final ServiceModel? service;
  const SelectFirm({super.key, required this.lead, this.affiliate, this.service});

  @override
  Widget build(BuildContext context) {
    // ✅ Convert List<AddFirmModel> to List<Map> for UI use
    final List<Map<String, dynamic>> filteredFirms = lead.firms.map((firm) {
      return {
        'name': firm.name ?? '',
        'location': firm.location ?? 'N/A',
        'original': firm, // store original model for usage on tap
      };
    }).toList();

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black,size: width*.06,),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Leads name title
            Padding(
              padding: EdgeInsets.only(left: width * .05, top: height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Firm',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: width * .05,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * .04),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddFirmScreen()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: width * .04,
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.primaryColor,
                          radius: width * .035,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: width * .05,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Firm List Container
            Container(
              width: double.infinity,
              height: height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Column(
                children: [
                  SizedBox(height: height * .03),
                  SizedBox(
                    height: height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: filteredFirms.length,
                        itemBuilder: (context, index) {
                          final firm = filteredFirms[index];
                          return Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  showCommonAlertBox(
                                    context,
                                    'Confirm submission of ${firm['name']??''} as a lead to ${lead.name??''}' ,
                                        () {
                                          // // Create a new Firestore reference
                                          // final docRef = FirebaseFirestore.instance
                                          //     .collection(FirebaseCollections.ServiceLeadsCollection).doc();
                                      // ✅ Create ServiceLeadModel from firm or other data
                                      final serviceLeadModel = ServiceLeadModel(
                                        firmName: firm['name']??'',
                                        marketerId:affiliate?.userId ??'' ,
                                        marketerName:affiliate?.name ??''  ,
                                        serviceName: service?.name ??'',
                                        reference: null,
                                        createTime: DateTime.now(),
                                        leadScore: 0,
                                        leadName: lead.name??'',
                                        leadLogo: lead.logo??'',
                                        location: firm['location'],
                                        statusHistory: [
                                          {
                                            'date':  DateTime.now(),
                                            'status': 'New Lead',
                                          },
                                        ] ,
                                      );
                                      ref.read(serviceLeadsControllerProvider.notifier).addServiceLeads(
                                        serviceLeadsModel: serviceLeadModel, context: context,);
                                    },
                                    'Confirm',
                                  );
                                },
                                child: buildFirmCard(firm, index),
                              );
                            },
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildFirmCard(Map<String, dynamic> firm, int index) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Colors.grey, width: 1.2),
      color:Color(0xFFF3F3F3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Firm Name and Location vertically
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firm['name'] ?? 'Firm Name',
              style: GoogleFonts.roboto(
                fontSize: width * .04,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              firm['location'] ?? 'Location not available',
              style: GoogleFonts.roboto(
                fontSize: width * .03,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}