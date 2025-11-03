import 'package:flutter/material.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import '../../../../core/common/global variables.dart';
import '../../../../model/agent_model.dart';
import '../agent/agent-add-page.dart';
import '../agent/agent-profile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewAllAgents extends StatelessWidget {
  final List<AgentModel> agentModelList;
  const ViewAllAgents({super.key, required this.agentModelList});

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
          Icon(Icons.search, color: Colors.black, size: width * .06),
          SizedBox(width: width * .03),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: EdgeInsets.only(
              left: width * .035,
              top: height * .015,
              bottom: height * .01,
            ),
            child: Text(
              "ALL AGENTS",
              style: TextStyle(
                fontSize: height * .018,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // GridView
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: width * .02),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 per row
                childAspectRatio: 0.8, // height/width ratio
              ),
              itemCount: agentModelList.length + 1, // +1 for "Add Agent"
              itemBuilder: (context, index) {
                final bool isFirst = index == 0;

                // Handle tap
                void handleTap() {
                  if (isFirst) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const AddAgent(),
                    );
                  } else {
                    final agent = agentModelList[index - 1];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AgentProfile(agentModel: agent),
                      ),
                    );
                  }
                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .008),
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
                              child: agentModelList[index - 1].profile !=
                                  null &&
                                  agentModelList[index - 1]
                                      .profile
                                      .isNotEmpty
                                  ? CachedNetworkImage(
                                imageUrl: agentModelList[index - 1]
                                    .profile,
                                fit: BoxFit.cover,
                                width: width * .18,
                                height: width * .16,
                              )
                                  : Icon(Icons.person,
                                  color: Colors.grey,
                                  size: width * .07),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          isFirst
                              ? "New\nAgent"
                              : (agentModelList[index - 1].name ?? ''),
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
