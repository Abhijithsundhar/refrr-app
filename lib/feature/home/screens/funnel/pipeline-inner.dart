import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/feature/home/screens/agent/agent-profile.dart';

class PipeLineInnerPage extends StatelessWidget {
  const PipeLineInnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5FAFF),
        elevation: 0,
        leading: IconButton(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {Navigator.pop(context);},
        ),
        title:  Text(
          'Lead Track',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: width*.05,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFFF5FAFF),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // Company Header
                   Container(
                     padding:  EdgeInsets.only(left: width*.05),
                     child: Row(
                       children: [
                         Container(
                           width: width*.25,
                           height: height*.1,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Center(
                             child: Image.asset(
                               'assets/images/canyonLogo.png',

                             ),
                           ),
                         ),
                         const SizedBox(width: 12),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               'iCanyon Technologies',
                               style: GoogleFonts.roboto(
                                 color: Colors.black,
                                 fontSize: width*.04,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                             Text('Dubai',
                               style: GoogleFonts.roboto(
                                 color: Colors.grey,
                                 fontSize: width*.035,
                                 fontWeight: FontWeight.w400,
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),

                   // Website Development Card
                   Padding(
                     padding:  EdgeInsets.only(left: width*.28),
                     child:  Column(
                       children: [
                         Text(
                           'Website Development',
                           style: GoogleFonts.roboto(
                             fontSize: width*.045,
                             fontWeight: FontWeight.w500,
                             color: const Color(0xFF545454)
                             ,
                           ),
                         ),
                         Text(
                             '23/6/2025',
                             style: GoogleFonts.roboto(
                               fontSize: width*.03,
                               fontWeight: FontWeight.w400,
                               color: const Color(0xFF545454)
                               ,
                             )),
                         SizedBox(height: height*.02,)
                       ],
                     ),
                   ),
                 ],
               ),
            ),
            const SizedBox(height: 20),

            // Prospect Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Prospect Details',
                    style: GoogleFonts.roboto(
                      fontSize: width*.052,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child:  Text(
                      'View profile',
                      style: GoogleFonts.roboto(
                        fontSize: width*.032,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0067B0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: height*.01),

            // Details List
            _buildDetailRow('Name', 'Crown Inox stainless steels'),
            _buildDetailRow('Location', 'Abu Dhabi'),
            _buildDetailRow('Phone No', '0874 345 234'),
            _buildDetailRow('Email ID', 'crowninoxsteels@gmail.com'),

            const SizedBox(height: 24),

            // Lead Source Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Lead Source',
                    style: GoogleFonts.roboto(
                      fontSize: width*.052,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: width*.3,
                    height: height*.05,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child:  Center(
                      child: Text(
                        'Add money',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Lead Source Person
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => AgentProfile(),));
                    },
                    child: CircleAvatar(
                      radius: 29,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey.shade300,
                        child: Image.asset('assets/image 172.png'),
                      ),
                    ),
                  ),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => AgentProfile(),));
                     },
                     child: Text(
                      'Rajeev Lk',
                      style: GoogleFonts.roboto(
                        fontSize: width*.038,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                                       ),
                   ),
                   Text(
                    'Agent',
                    style: GoogleFonts.roboto(
                      fontSize: width*.035,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F6C6C),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Lead Story Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Lead Story',
                    style: GoogleFonts.roboto(
                      fontSize: width*.052,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: width*.3,
                    height: height*.05,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child:  Text(
                        'Update request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

             SizedBox(height: height*.04),

            // Lead Story Timeline
            _buildTimelineItem('25-08-2025', 'Completed', 'Kavya', Color(0xFFE8FFF3)),
            _buildTimelineItem('23-07-2025', 'Invoice raised', 'Kavya', Color(0x12D87912)),
            _buildTimelineItem('24-06-2025', 'Proposal sent', 'Abhijith', Color(0x12D87912)),
            _buildTimelineItem('18-05-2025', 'Contacted', 'Vishnu', Color(0x12D87912)),
            _buildTimelineItem('30-04-2025', 'New lead', 'Arjun', Color(0xFFF2FFF9), isLast: true),

            const SizedBox(height: 24),

            // Lead Handler Section
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Lead Handler',
                style: GoogleFonts.roboto(
                  fontSize: width*.052,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Lead Handler Person
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade300,
                    child: Image.asset('assets/image 172.png'),
                  ),
                  const SizedBox(height: 8),
                   Text('Kavya P J', style: GoogleFonts.roboto(
                      fontSize: width*.038,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style:  GoogleFonts.roboto(
                fontSize: width*.036,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
           Text(':',
            style: GoogleFonts.roboto(
              fontSize: width*.04,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: width*.038,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2E2E2E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String date, String status, String handler, Color bgColor, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: height*.065,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: bgColor,
              // borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date,
                  style: GoogleFonts.roboto(
                    fontSize: width*.036,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757D83),
                  ),
                ),
                Text(
                  status,
                  style: GoogleFonts.roboto(
                    fontSize: width*.036,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757D83),
                  ),
                ),
                Text(handler,
                  style: GoogleFonts.roboto(
                  fontSize: width*.036,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF757D83),
                  ),
                ),
              ],
            ),
          ),
          if (!isLast)
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 1,
            ),
        ],
      ),
    );
  }
}
