import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import '../../../../core/common/global variables.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> transactions = [
      {"date": "30-05-2025", "status": "Withdrawn", "amount": "AED 250", "type": "withdraw"},
      {"date": "25-05-2025", "status": "Credited", "amount": "AED 250", "type": "credit"},
      {"date": "24-05-2025", "status": "Credited", "amount": "AED 100", "type": "credit"},
      {"date": "18-05-2025", "status": "Credited", "amount": "AED 300", "type": "credit"},
      {"date": "12-05-2025", "status": "Withdrawn", "amount": "AED 100", "type": "withdraw"},
      {"date": "07-05-2025", "status": "Credited", "amount": "AED 170", "type": "credit"},
      {"date": "06-05-2025", "status": "Credited", "amount": "AED 300", "type": "credit"},
    ];
    final visibleTx = showAll ? transactions : transactions.take(5).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: width * .04, right: width * .04),
          child: Column(
            children: [
               SizedBox(height: height*.02),
              /// Money Withdrawal Request
              _moneyCard(
                icon: Icons.account_balance_wallet,
                iconColor: Colors.orange,
                title: 'Money Withdrawal Request',
                subtitle: '5 days ago',
                description: 'Jacob Sacaria requested to withdraw AED 250',
                amount: 'AED 250',
                showButtons: true,
              ),

              SizedBox(height: height*.04),

              // Status Change Request
              _statusCard(
                icon: Icons.person,
                iconColor: Colors.blue,
                title: 'Status Change Request',
                subtitle: '7 days ago',
                description: 'Jacob Sacaria has requested to change status from Follow up needed to Proposal sent',
                amount: 'View lead status',
                showButtons: true,
              ),

              SizedBox(height: height*.05,),

              /// Financial Summary
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Total Money Credited',style: GoogleFonts.roboto(color: Color(0xFF575757),
                        fontWeight: FontWeight.w400,fontSize: width*.035
                      ),),
                      SizedBox(height: height*.005,),
                      Container(
                        height: height*.07,
                        width: width*.44,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF3F3F3)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(15),
                          child: Text('AED 1500',style: GoogleFonts.roboto( color: Colors.green, fontWeight: FontWeight.w500,fontSize: width*.043),),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: width*.03,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Total Money Credited',style: GoogleFonts.roboto(color: Color(0xFF575757),
                        fontWeight: FontWeight.w400,fontSize: width*.035
                      ),),
                      SizedBox(height: height*.005,),
                      Container(
                        height: height*.07,
                        width: width*.44,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF3F3F3)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(15),
                          child: Text('AED 1500',style: GoogleFonts.roboto( color: Color(0xFFB41010)
                              , fontWeight: FontWeight.w500,fontSize: width*.043),),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: height*.04,),

              Padding(
                padding:  EdgeInsets.only(right: width*.45),
                child: Text('View Transaction History', style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,fontSize: width*.04,color: Color(0xFF0067B0)
                ),),
              ),
              SizedBox(height: height*.03,),
              Column(
                children: [
                  ...visibleTx.map(
                        (tx) => Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tx["date"],
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                            Text(tx["status"],
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            Text(
                              tx["amount"],
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: tx["type"] == "credit"
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        showAll ? "See less" : "Show more",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: height*.05,),

              /// Action Buttons
              _buildActionButton('Add Money', Icons.add),
              const SizedBox(height: 12),
              _buildActionButton('Add Offer', Icons.add),
              SizedBox(height: height * .05),

            ],
          ),
        ),
      ),
    );
  }

  Widget _moneyCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required String amount,
    bool showButtons = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xE5F3F3F3),
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    title,
                    style:  GoogleFonts.roboto(
                      fontSize: width*.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                       style:  GoogleFonts.roboto(
                       fontSize: width*.03,
                       color: Colors.grey,
                       fontWeight: FontWeight.w400,
                  ),)
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: height*.03),
                child: Text(amount,
                  style:  GoogleFonts.roboto(
                    fontSize: width*.04,
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding:  EdgeInsets.only(left: width*.05,top: height*.02),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.01),
                    child: Text(
                      description,
                      style:  GoogleFonts.roboto(
                        fontSize: width*.035,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (showButtons) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Your action here
                            },
                            child: Container(
                              width: width*.2,
                              height: height*.04,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFFA1616)),
                                color: Color(0x08FA1616), // background color
                                borderRadius: BorderRadius.circular(30), // rounded corners
                              ),
                              child:  Center(
                                child: Text(
                                  'Reject',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: width*.035,
                                  ),
                                ),
                              ),
                            ),
                          ),
                           SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // Your action here
                            },
                            child: Container(
                              width: width*.2,
                              height: height*.04,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF33A847)),
                                color: Color(0x0833A847), // background color
                                borderRadius: BorderRadius.circular(30), // rounded corners
                              ),
                              child:  Center(
                                child: Text(
                                  'Accept',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: width*.035,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _statusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required String amount,
    bool showButtons = false,
  }) {
    return Stack(
      children: [
        Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xE5F3F3F3),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),

                // Make this section flexible
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.roboto(
                          fontSize: width * .03,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: width * .05, top: height * .02),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * .02, top: height * .01),
                      child: Text(
                        description,
                        style: GoogleFonts.roboto(
                          fontSize: width * .035,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ),
                    if (showButtons) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: width * .2,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFFA1616)),
                                  color: const Color(0x08FA1616),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Reject',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: width * .035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: width * .2,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF33A847)),
                                  color: const Color(0x0833A847),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Accept',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: width * .035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        Positioned(
           top: height*.03,
            left: width*.61,
            child: Container(
          width: width * .28,
          height: height * .045,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(color: ColorConstants.appBlue),
          ),
          child: Center(
            child: Text(
              amount,
              style: GoogleFonts.roboto(
                fontSize: width * .03,
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget _financialSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Total Money Credited
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Money Credited",
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: width * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "AED 1500",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),

        // Total Money Withdrawn
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Money Withdrawn",
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: width * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "AED 500",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(10),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: width*.04,
              fontWeight: FontWeight.w400,
              color: Color(0xFF575757)
            ),
          ),
          Icon(icon, color: Color(0xFF575757)
          ),
        ],
      ),
    );
  }
}
