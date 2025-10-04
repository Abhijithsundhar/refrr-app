import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icanyon/model/affiliate-model.dart';
import '../../../../core/common/global variables.dart';
import '../../../wallet/Screens/wallethome.dart';
import '../funnel/funnel-home.dart';
import '../updates/update-home.dart';
import 'homescreen.dart';

class BottomBarSection extends StatefulWidget {
  final AffiliateModel? affiliate;
  final int? initialIndex;
  const BottomBarSection({super.key,  this.affiliate,  this.initialIndex =0});

  @override
  State<BottomBarSection> createState() => _BottomBarSectionState();
}

class _BottomBarSectionState extends State<BottomBarSection> {
  int _selectedIndex = 0;
    List<Widget> _pages=[];

  @override
  void initState() {
    super.initState();

    setState(() {
          _selectedIndex = widget.initialIndex!;

          _pages = [
        Homescreen(affiliate: widget.affiliate),
            FunnelHome(affiliate: widget.affiliate,),
            UpdateHome(affiliate: widget.affiliate,),
        Wallethome(affiliate: widget.affiliate,),

      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loader or fallback until _pages is initialized
    if (widget.affiliate == null || _pages.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 45,
        color: Colors.white,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: SvgPicture.asset(
                  _selectedIndex == 0
                      ? 'assets/svg/home-fill.svg'
                      : 'assets/svg/home-unfill.svg',
                  height: 35,
                ),
              ),
              SizedBox(width: width*.12,),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      _selectedIndex == 1
                          ? 'assets/svg/modeling-fill.svg'
                          : 'assets/svg/modeling.svg',
                      height: 35,
                    ),
                    Positioned(
                      left: width*.06,
                        child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.red,
                    ))
                  ],
                ),
              ),
              SizedBox(width: width*.12,),
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      _selectedIndex == 2
                          ? 'assets/svg/mic-fill.svg'
                          : 'assets/svg/mic-unfill.svg',
                      height: 40,
                    ),
                    Positioned(
                      top: height*.007,
                        left: width*.06,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.red,
                        ))
                  ],
                ),
              ),
              SizedBox(width: width*.12,),
                  GestureDetector(
          onTap: () => _onItemTapped(3),
          child: _selectedIndex == 3
              ? SvgPicture.asset(
            'assets/svg/wallet-fill.svg',
            height: 35,
          )
              : SvgPicture.asset(
            'assets/svg/wallet-unfill.svg',
            height: 35,
          ),
                  ),

             ] ),
        ),
        ),
      );


        // bottomNavigationBar: Container(
        //   height: 50,
        //   color: Colors.white,
        //   child: Center(
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         GestureDetector(
        //           onTap: () => _onItemTapped(0),
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //             child: Icon(
        //               _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
        //               size: 28,
        //               color: _selectedIndex == 0 ? Colors.black : Colors.grey,
        //             ),
        //           ),
        //         ),
        //         SizedBox(width: width * .1),
        //         GestureDetector(
        //           onTap: () => _onItemTapped(1),
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //             child: FaIcon(
        //               _selectedIndex == 1 ? Icons.filter_alt : Icons.filter_alt_outlined, // funnel-like
        //               size: 28,
        //               color: _selectedIndex == 1 ? Colors.black : Colors.grey,
        //             ),
        //           ),
        //         ),
        //         SizedBox(width: width * .1),
        //         GestureDetector(
        //           onTap: () => _onItemTapped(2),
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //             child: FaIcon(
        //               _selectedIndex == 2 ? Icons.notifications_on : Icons.notifications_active_outlined, // funnel-like
        //               size: 28,
        //               color: _selectedIndex == 2 ? Colors.black : Colors.grey,
        //             ),
        //           ),
        //         ),
        //         SizedBox(width: width * .1),
        //         GestureDetector(
        //           onTap: () => _onItemTapped(3),
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //             child: Icon(
        //               _selectedIndex == 3
        //                   ? Icons.account_balance_wallet_rounded
        //                   : Icons.account_balance_wallet_outlined,
        //               size: 28,
        //               color: _selectedIndex == 3 ? Colors.black : Colors.grey,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
