import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../model/affiliate-model.dart';
import '../../../../model/leads-model.dart';

class ShareTab extends StatelessWidget {
  final LeadsModel lead;
  final AffiliateModel? affiliate;
  ShareTab({super.key, required this.lead, this.affiliate});

  // your image lists
  final List<String> shareImageList = [
    'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=1080&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=1080&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=1080&auto=format&fit=crop',
  ];

  final List<String> almasee = [
    'assets/WhatsApp Image 2025-09-22 at 7.01.49 PM.jpeg',
    'assets/WhatsApp Image 2025-09-22 at 7.01.49 PM (1).jpeg',
    'assets/WhatsApp Image 2025-09-22 at 7.01.50 PM.jpeg',
    'assets/WhatsApp Image 2025-09-22 at 7.01.50 PM (1).jpeg',
    'assets/WhatsApp Image 2025-09-22 at 7.01.51 PM.jpeg',
  ];

  final List<String> kia = [
    'assets/WhatsApp Image 2025-09-24 at 2.57.10 PM.jpeg',
    'assets/WhatsApp Image 2025-09-24 at 2.57.10 PM (1).jpeg',
    'assets/WhatsApp Image 2025-09-24 at 2.57.10 PM (2).jpeg',
    'assets/WhatsApp Image 2025-09-24 at 2.57.11 PM.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    // Choose list based on lead name
    List<String> images;
    if (lead.name == "Kia Calicut") {
      images = kia;
    } else if (lead.name == "Al-masee Auditing") {
      images = almasee;
    } else {
      images = shareImageList;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return _PosterCard(imagePath: images[index]);
        },
      ),
    );
  }
}

class _PosterCard extends StatefulWidget {
  const _PosterCard({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final String imagePath; // can be URL or asset

  @override
  State<_PosterCard> createState() => _PosterCardState();
}

class _PosterCardState extends State<_PosterCard> {
  final GlobalKey _posterKey = GlobalKey();

  Future<Uint8List?> _capturePosterBytes() async {
    try {
      final boundary =
      _posterKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint("Error capturing poster: $e");
      return null;
    }
  }

  Future<void> _sharePoster(BuildContext context) async {
    final bytes = await _capturePosterBytes();
    if (bytes == null) {
      _snack(context, 'Failed to capture poster');
      return;
    }

    try {
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/poster_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes, flush: true);

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'image/png', name: 'poster.png')],
        text: 'Check out this poster!',
      );
    } catch (e) {
      _snack(context, 'Share failed: $e');
    }
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool get _isNetwork => widget.imagePath.startsWith("http");

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxImageHeight = MediaQuery.of(context).size.height * 0.6; // Max height constraint

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Poster with gradient
          RepaintBoundary(
            key: _posterKey,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: maxImageHeight,
                  minHeight: 200, // Minimum height to ensure visibility
                ),
                // Removed color to hide grey background
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    // Image with proper aspect ratio
                    Container(
                      child: _isNetwork
                          ? Image.network(
                        widget.imagePath,
                        fit: BoxFit.contain, // Changed to contain to preserve aspect ratio
                        width: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder: (_, __, ___) => Container(
                          height: 300,
                          child: const Center(
                            child: Icon(Icons.broken_image,
                                size: 64, color: Colors.grey),
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                          : Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain, // Changed to contain to preserve aspect ratio
                        width: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder: (_, __, ___) => Container(
                          height: 300,
                          child: const Center(
                            child: Icon(Icons.broken_image,
                                size: 64, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),

                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Download',
                  icon: Icons.save_alt_rounded,
                  onPressed: () async {
                    await _downloadPoster(context);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  label: 'Share',
                  icon: Icons.ios_share_outlined,
                  onPressed: () => _sharePoster(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPoster(BuildContext context) async {
    final bytes = await _capturePosterBytes();
    if (bytes == null) {
      _snack(context, 'Failed to capture poster');
      return;
    }

    try {
      // For Android/iOS, save to downloads or gallery
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/poster_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes, flush: true);

      _snack(context, 'Poster saved successfully!');
      // You might want to use gallery_saver or similar package for actual gallery saving
    } catch (e) {
      _snack(context, 'Download failed: $e');
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200, // Fill color
            // border: Border.all(color: Colors.grey, width: 1.2), // Border
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
