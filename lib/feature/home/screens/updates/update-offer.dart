import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/global variables.dart';
import '../../../../core/common/textlength.dart';
import '../../../../core/constants/color-constnats.dart';
import '../../controllor/offer-controller.dart';

class UpdateOfferPage extends ConsumerStatefulWidget {
  final String title;
  final String amount;
  final DateTime date;
  final String image;
  final String description;
  final String currency;
  final AffiliateModel? affiliate;

  const UpdateOfferPage( {
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.image,
    required this.description,
    required this.currency,
    this.affiliate,
  });

  @override
  ConsumerState<UpdateOfferPage> createState() => _UpdateOfferPageState();
}

class _UpdateOfferPageState extends ConsumerState<UpdateOfferPage> {
  @override
  Widget build(BuildContext context) {
    final formattedDescription = formatWithLineBreaks(widget.description, 40);

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,

      /// ✅ Sticky AppBar
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Offers',
          style: GoogleFonts.roboto(
            fontSize: width * 0.06,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Handle close action here
              Navigator.pop(context); // or any other logic
            },
            child:Padding(
              padding:  EdgeInsets.only(right: width*.04),
              child: Icon(Icons.close, color: Colors.black),
            ),
          ),
        ],
      ),

      /// ✅ Main Content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * .02),

            /// ⭐ Highlighted Offer Card (Top)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .06),
              child: _buildOfferCard(
                title: widget.title,
                image: widget.image,
                amount: widget.amount,
                currency: widget.currency,
                date: widget.date,
                description: formattedDescription,
              ),
            ),

            SizedBox(height: height * .03),

            /// 🔄 Other Active Offers (List)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .06),
              child: Consumer(builder: (context, ref, _) {
                final offerAsync = ref.watch(offerStreamProvider(''));

                return offerAsync.when(
                  data: (offers) {
                    // Filter out the currently displayed offer
                    final filteredOffers = offers.where((offer) =>
                    offer.name != widget.title ||
                        offer.amount != widget.amount ||
                        offer.description != widget.description);

                    if (filteredOffers.isEmpty) {
                      return Text(
                        "No other offers available",
                        style: GoogleFonts.roboto(
                          fontSize: width * .04,
                          color: Colors.white,
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredOffers.length,
                      separatorBuilder: (context, index) => SizedBox(height: height * .02),
                      itemBuilder: (context, index) {
                        final offer = filteredOffers.elementAt(index);
                        return _buildOfferCard(
                          title: offer.name,
                          image: offer.image ?? '',
                          amount: offer.amount,
                          currency: offer.currency ?? '',
                          date: offer.endDate,
                          description: formatWithLineBreaks(offer.description, 40),
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: Padding(
                      padding: EdgeInsets.all(height * .02),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  error: (err, stack) => Text(
                    'Error loading offers: $err',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),

            SizedBox(height: height * .03),
          ],
        ),
      ),
    );
  }

  /// 🧱 Reusable Offer Card Builder
  Widget _buildOfferCard({
    required String title,
    required String image,
    required String amount,
    required String currency,
    required DateTime date,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * .06,
        vertical: height * .03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🎯 Title
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: width * .04,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: height * .015),

          /// 🖼 Image
        Container(
          height: height * .24,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: image.startsWith('http')
              ? Image.network(image, fit: BoxFit.cover)
              : Image.asset(
            image.isNotEmpty ? image : 'assets/images/offerImage1.png',
            fit: BoxFit.cover,
          ),
        ),

          SizedBox(height: height * .03),

          /// 💵 Offer Info
          Text(
            'Offer Amount',
            style: GoogleFonts.roboto(
              fontSize: width * .04,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: height * .01),

          Text(
            '$currency $amount',
            style: GoogleFonts.roboto(
              fontSize: width * .04,
              color: Colors.green,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: height * .01),

          /// ⌛ Valid Until
          Row(
            children: [
              Text(
                'Valid Until:',
                style: GoogleFonts.roboto(
                  fontSize: width * .04,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: width * .02),
              Text(
                DateFormat('dd-MM-yyyy').format(date),
                style: GoogleFonts.roboto(
                  fontSize: width * .04,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: height * .02),

          /// 📝 Description
          Text(
            description,
            style: GoogleFonts.roboto(
              fontSize: width * .04,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),

          SizedBox(height: height * .04),

          /// 🎉 Hurry Message
          Row(
            children: [
              const Expanded(child: Divider(color: Colors.grey)),
              const SizedBox(width: 8),
              const CircleAvatar(radius: 4, backgroundColor: Colors.grey),
              const SizedBox(width: 8),
              Text(
                'Hurry Up!!!',
                style: GoogleFonts.roboto(
                  fontSize: width * .045,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(radius: 4, backgroundColor: Colors.grey),
              const SizedBox(width: 8),
              const Expanded(child: Divider(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}