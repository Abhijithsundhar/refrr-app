import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/feature/home/controllor/leads-controller.dart';
import 'agent-profile.dart';

class AddAgent extends ConsumerStatefulWidget {
  const AddAgent({super.key});

  @override
  ConsumerState<AddAgent> createState() => _AddAgentState();
}

class _AddAgentState extends ConsumerState<AddAgent> {
  final TextEditingController phoneController = TextEditingController();
  String? searchedPhone;
  bool isLoading = false;
  bool showConfirm = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> handleSearch() async {
    if (phoneController.text.isEmpty) return;
    if (searchedPhone == phoneController.text) return; // Prevent duplicate search

    FocusScope.of(context).unfocus(); // Dismiss keyboard

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      searchedPhone = phoneController.text.trim();
      isLoading = false;
      showConfirm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Fetch agent only if searchedPhone is not null
    final agentAsync = searchedPhone == null
        ? const AsyncValue.data(null)
        : ref.watch(agentProvider(searchedPhone!));

    return Container(
      height: height * 0.8,
      padding: EdgeInsets.symmetric(horizontal: width * .07, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              'Enter phone number',
              style: GoogleFonts.roboto(
                fontSize: width * 0.033,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),

            // Phone input
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 9876543210',
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.018,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Search button
            SizedBox(
              width: double.infinity,
              height: height * 0.06,
              child: ElevatedButton(
                onPressed: handleSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  'Search',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🧩 Result Section
            agentAsync.when(
              data: (agent) {
                if (agent == null) return const SizedBox();

                return Column(
                  children: [
                    // Agent info card
                    Container(
                      width: double.infinity,
                      height: height * .2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * .025),
                            child: CircleAvatar(
                              radius: width * .1,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: agent.profile != null
                                  ? NetworkImage(agent.profile!)
                                  : null,
                              child: agent.profile == null
                                  ? const Icon(Icons.person, size: 40)
                                  : null,
                            ),
                          ),
                          SizedBox(width: width * .04),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  agent.name,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                Divider(color: Colors.grey.shade400),
                                Text(agent.country),
                                Divider(color: Colors.grey.shade400),
                                Text(agent.industry.isNotEmpty
                                    ? agent.industry[0]
                                    : 'N/A'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AgentProfile(agentModel: agent),
                                ),
                              );
                            },
                            child: const Text('View'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() => showConfirm = true);
                            },
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),

                    // Confirm section
                    if (showConfirm) ...[
                      const SizedBox(height: 25),
                      Text(
                        'Are you sure you want to add this agent?',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: width * .04,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => showConfirm = false),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                final affiliate = ref.watch(affiliateProvider);
                                final updated = agent.copyWith(
                                  affiliateId: affiliate?.id ?? "",
                                );
                                ref
                                    .read(leadsControllerProvider.notifier)
                                    .updateAgents(
                                  agentModel: updated,
                                  context: context,
                                );
                                setState(() {
                                  searchedPhone = null;
                                  phoneController.clear();
                                });
                              },
                              child: const Text('Confirm'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
