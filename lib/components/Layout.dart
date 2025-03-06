import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Account_Page.dart';
import 'package:foodqueuedev/components/Homepage.dart';
import 'package:foodqueuedev/components/Order_Page.dart';
import 'package:foodqueuedev/components/Restaurant_Page.dart';
import 'package:foodqueuedev/components/SelectTablePage.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Homepage(pageController: _pageController),
          SelectTablePage(),
          Restaurant_Page(),
          Order_Page(),
          Account_Page(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const TextStyle(
                    color: Color(0xFFFC6E2A),
                    fontSize: 12,
                  );
                }
                return const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                );
              },
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.white,
            height: 65,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, size: 28),
                selectedIcon:
                    Icon(Icons.home_filled, color: Color(0xFFFC6E2A), size: 30),
                label: 'หน้าแรก',
              ),
              NavigationDestination(
                icon: Icon(Icons.table_restaurant_outlined, size: 28),
                selectedIcon: Icon(Icons.table_restaurant,
                    color: Color(0xFFFC6E2A), size: 30),
                label: 'จองโต๊ะ',
              ),
              NavigationDestination(
                icon: Icon(Icons.restaurant_outlined, size: 28),
                selectedIcon:
                    Icon(Icons.restaurant, color: Color(0xFFFC6E2A), size: 30),
                label: 'ร้านอาหาร',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined, size: 28),
                selectedIcon: Icon(Icons.receipt_long,
                    color: Color(0xFFFC6E2A), size: 30),
                label: 'คำสั่งซื้อ',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined, size: 28),
                selectedIcon: Icon(Icons.account_circle,
                    color: Color(0xFFFC6E2A), size: 30),
                label: 'บัญชี',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
