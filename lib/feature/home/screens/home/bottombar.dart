import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icanyon/model/affiliate-model.dart';
import '../../../../core/common/global variables.dart';
import '../../../wallet/Screens/wallethome.dart';
import '../funnel/funnel-home.dart';
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
    @override
    void initState() {
      super.initState();

    }

    setState(() {
          _selectedIndex = widget.initialIndex!;

          _pages = [
        Homescreen(affiliate: widget.affiliate),
            FunnelHome(affiliate: widget.affiliate,),
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
      // bottomNavigationBar: Container(
      //   height: 60,
      //   color: Colors.white,
      //   child: Center(
      //     child: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         GestureDetector(
      //           onTap: () => _onItemTapped(0),
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //             child: Image.asset(
      //               _selectedIndex == 0
      //                   ? 'assets/images/homeFilled.png'
      //                   : 'assets/images/home-border.png',
      //               height: 28,
      //             ),
      //           ),
      //         ),
      //         SizedBox(width: width*.1,),
      //         GestureDetector(
      //           onTap: () => _onItemTapped(1),
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //             child: Image.asset(
      //               _selectedIndex == 1
      //                   ? 'assets/images/funnelFilled.png'
      //                   : 'assets/images/funnelUnfilled.png',
      //               height: 28,
      //             ),
      //           ),
      //         ),
      //         SizedBox(width: width*.1,),
      //         GestureDetector(
      //           onTap: () => _onItemTapped(2),
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //             child: Image.asset(
      //               _selectedIndex == 2
      //                   ? 'assets/images/filledwallet.png'
      //                   : 'assets/images/outlinewallet.png',
      //               height: 28,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
        bottomNavigationBar: Container(
          height: 50,
          color: Colors.white,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      _selectedIndex == 0 ? Icons.home_filled : Icons.home_filled,
                      size: 28,
                      color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: width * .1),
                GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FaIcon(
                      _selectedIndex == 1 ? Icons.filter_alt : Icons.filter_alt_outlined, // funnel-like
                      size: 28,
                      color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: width * .1),
                GestureDetector(
                  onTap: () => _onItemTapped(2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      _selectedIndex == 2
                          ? Icons.account_balance_wallet_rounded
                          : Icons.account_balance_wallet_outlined,
                      size: 28,
                      color: _selectedIndex == 2 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
