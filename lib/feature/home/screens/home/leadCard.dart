import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../model/affiliate-model.dart';

class LeadCard extends StatelessWidget {
  final dynamic lead; // Replace with LeadsModel if available
  final AffiliateModel? affiliate;
  final VoidCallback? onViewTap;
  final VoidCallback? onMenuTap;

  const LeadCard({
    super.key,
    required this.lead,
    this.affiliate,
    this.onViewTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final logoUrl = (lead.logo != null && lead.logo is String) ? (lead.logo as String) : '';
    final name = (lead.name ?? '').toString();
    final industry = (lead.industry ?? '').toString();
    final firmsCount = (lead.firms is List) ? (lead.firms as List).length : 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with company logo and name
          Row(
            children: [
              Container(
                width: width * 0.15,
                height: width * 0.08,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: logoUrl.isNotEmpty
                      ? Image.network(
                    logoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, color: Colors.grey),
                  )
                      : const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Dubai', // Replace with lead.location if available
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.032,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: onMenuTap,
              ),
            ],
          ),

          SizedBox(height: height * .04),

          // Timeline dots
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .07),
            child: Row(
              children: [
                _dot(width),
                Expanded(child: _line()),
                _dot(width),
                Expanded(child: _line()),
                _dot(width),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Labels under timeline
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: width * .1),
                  child: Text(
                    industry,
                    style: GoogleFonts.roboto(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '$firmsCount Firms\nAdded',
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Commission\nBased',
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          SizedBox(height: height * .03),

          // Bottom row with avatars and View button
          Row(
            children: [
              SizedBox(
                width: width * 0.25,
                height: width * 0.085,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(left: 0, child: _avatar('A', Colors.blue[400], width)),
                    Positioned(left: width * 0.04, child: _avatar('B', Colors.orange[400], width)),
                    Positioned(left: width * 0.08, child: _avatar('+2', Colors.green[400], width)),
                    if (firmsCount > 3)
                      Positioned(
                        left: width * 0.12,
                        child: Container(
                          width: width * 0.08,
                          height: width * 0.08,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00BCD4),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              '+${firmsCount - 3}',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: width * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onViewTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'View',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(double width) {
    return Container(
      width: width * 0.025,
      height: width * 0.025,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
    );
  }

  Widget _line() => Container(height: 1, color: Colors.black);

  Widget _avatar(String text, Color? bg, double width) {
    return Container(
      width: width * 0.085,
      height: width * 0.085,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
        backgroundColor: bg ?? Colors.grey[400],
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: width * 0.028,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
