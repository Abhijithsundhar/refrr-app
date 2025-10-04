import 'package:flutter/material.dart';
import 'package:icanyon/core/constants/color-constnats.dart';

import '../../../../core/common/global variables.dart';
import '../agent/agent-add-page.dart';
import '../agent/agent-profile.dart';

class ViewAllAgents extends StatelessWidget {
  const ViewAllAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: width * .03),
          child: IconButton(
            hoverColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: width * .06,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
            size: width * .06,
          ),
          SizedBox(width: width * .03),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          SizedBox(width: width * .03),
          Padding(
            padding: EdgeInsets.only(
              left: width * .035,
              top: height * .015,
              bottom: height * .01,
            ),
            child: Text(
              "ALL AGENTS",
              style: TextStyle(
                fontSize: height * .015,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: width * .03),
          // GridView
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // ✅ 4 per row now
                childAspectRatio: 0.8, // adjust height vs width
              ),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                final bool isFirst = index == 0;

                void handleTap() {
                  if (isFirst) {
                    // New Agent -> Add firm
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const AddAgent(),
                    );

                  }  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AgentProfile()),
                    );
                  }
                }

                return Padding(
                  padding: EdgeInsets.only(
                    left: width * .02,
                    top: height * .01,
                    right: width * .02,
                  ),
                  child: GestureDetector(
                    onTap: handleTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width * .18,
                          height: width * .16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: isFirst
                                ? Border.all(
                                color: ColorConstants.appBlue, width: 1)
                                : null,
                          ),
                          child: Center(
                            child: isFirst
                                ? Icon(Icons.add,
                                color: Colors.black, size: width * .07)
                                : ClipOval(
                              child: Image.asset(
                                imageList[index],
                                fit: BoxFit.cover,
                                width: width * .18,
                                height: width * .16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isFirst ? "New\nAgent" : 'Abhijith \nSundhar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: height * .012,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
