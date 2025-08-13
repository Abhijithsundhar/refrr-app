import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/alertbox.dart';

import '../../../core/common/global variables.dart';
import '../../../core/constants/color-constnats.dart';
import '../../../model/affiliate-model.dart';
import '../../Login/Controller/login-controller.dart';

final affiliateProvider = StateProvider<AffiliateModel?>((ref) => null);

class LanguageSection extends ConsumerStatefulWidget {
  final AffiliateModel? affiliate;
  const LanguageSection({super.key, this.affiliate});

  @override
  ConsumerState<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends ConsumerState<LanguageSection> {
  String selectedLanguage = 'English';

  final List<String> languages = [
    'English',
    'Arabic (عربي)',
    'Hindi (हिन्दी)',
    'Malayalam (മലയാളം)',
    'Russian (Русский)',
    'Japanese (日本語)',
    'Chinese (中国人)',
    'Kannada (ಕನ್ನಡ)',
    'Tamil (தமிழ்)',
    'Telugu (తెలుగు)',
  ];

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.affiliate?.language ?? 'English';
    // Initialize the global provider too
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(affiliateProvider.notifier).state = widget.affiliate;
    });
  }

  void _updateLanguage(String lang) async {
    setState(() {
      selectedLanguage = lang;
    });

    final currentAffiliate = ref.read(affiliateProvider);
    if (currentAffiliate == null) return;

    final updatedAffiliate = currentAffiliate.copyWith(language: lang);

    await ref.read(affiliateControllerProvider.notifier).updateAffiliate(
      context: context,
      affiliateModel: updatedAffiliate,
    );

    ref.read(affiliateProvider.notifier).state = updatedAffiliate;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$lang selected')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final affiliate = ref.watch(affiliateProvider);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * .02),
            Padding(
              padding: EdgeInsets.only(right: width * .46),
              child: Text(
                'Select language',
                style: GoogleFonts.roboto(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: height * .05, horizontal: width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    itemCount: languages.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      final lang = languages[index];
                      final isSelected = selectedLanguage == lang;
                      return GestureDetector(
                        onTap: () => _updateLanguage(lang),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.grey.shade200 : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                lang,
                                style: GoogleFonts.roboto(
                                  fontSize: width * .04,
                                  color: Colors.black,
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check, color: ColorConstants.primaryColor),
                            ],
                          ),
                        ),
                      );
                    },
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
