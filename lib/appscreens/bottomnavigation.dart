
import 'package:agri_saathi/appscreens/historyscreen.dart';
import 'package:agri_saathi/appscreens/homescreen.dart';
import 'package:agri_saathi/appscreens/profilescreen.dart';
import 'package:agri_saathi/appscreens/searchscreen.dart';
import 'package:agri_saathi/appscreens/servicescreen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() =>
      _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_outlined, 'label': 'Home', 'activeIcon': Icons.home, 'page': Homescreen()},
    {'icon': Icons.search_outlined, 'label': 'Search', 'activeIcon': Icons.search, 'page': Searchscreen()},
    {'icon': Icons.miscellaneous_services, 'label': 'Service', 'activeIcon': Icons.miscellaneous_services_outlined, 'page': Servicescreen()},
    {'icon': Icons.history_outlined, 'label': 'History', 'activeIcon': Icons.history, 'page': Historyscreen()},
    {'icon': Icons.person_outline, 'label': 'Profile', 'activeIcon': Icons.person, 'page': Profilescreen()},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navItems[_selectedIndex]['page'],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _navItems.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> item = entry.value;

            bool isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? item['activeIcon'] : item['icon'],
                      color: isSelected ? Colors.green : Colors.grey,
                      size: 28,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        item['label'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

