import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Welcome to Maxlux!',
        'message': 'Thank you for joining us. Explore the latest electronics deals and offers on our platform now.',
        'date': '10-20-2025',
      },
      {
        'title': 'Limited Offer!',
        'message': 'Grab your favorite camera at up to 30% off. This weekend only. Hurry!',
        'date': '02-15-2025',
      },
      {
        'title': 'System Maintenance',
        'message': 'We will be undergoing scheduled maintenance on 05 June from 2 AM to 4 AM IST.',
        'date': '02-02-2025',
      },
    ];

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: height * .02),
          Padding(
            padding: EdgeInsets.only(right: width * .51),
            child: Text(
              'Notifications',
              style: GoogleFonts.roboto(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 60),
              width: double.infinity,
              padding: EdgeInsets.only(top: height * .05, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item['title']!,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.04,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            item['date']!,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.032,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        item['message']!,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w300,
                          fontSize: width * 0.038,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
