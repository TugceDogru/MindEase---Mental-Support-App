import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': 'lib/assets/icons/home.png', 'iconLight': 'lib/assets/icons/home_light.png', 'label': ''},
      {'icon': 'lib/assets/icons/psychology.png', 'iconLight': 'lib/assets/icons/psychology_light.png', 'label': ''},
      {'icon': 'lib/assets/icons/search.png', 'iconLight': 'lib/assets/icons/search_light.png', 'label': ''},
      {'icon': 'lib/assets/icons/calendar.png', 'iconLight': 'lib/assets/icons/calendar_light.png', 'label': ''},
      {'icon': 'lib/assets/icons/profile.png', 'iconLight': 'lib/assets/icons/profile_light.png', 'label': ''},
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: List.generate(items.length, (i) {
        final iconPath = currentIndex == i ? items[i]['iconLight']! : items[i]['icon']!;
        return BottomNavigationBarItem(
          icon: Image.asset(iconPath, height: 28, width: 28),
          label: items[i]['label'],
        );
      }),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
} 