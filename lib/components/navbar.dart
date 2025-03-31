import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/custom_icons.dart';

class CustomNavBar extends StatelessWidget {
  // This index tells us which tab is currently selected
  final int selectedIndex;

  // This callback function will be triggered when a tab is tapped
  final Function(int) onItemTapped;

  // Constructor with required parameters
  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width to help with responsive spacing
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate item spacing based on screen width
    // The formula creates equal spacing between items
    final itemSpacing = (screenWidth - (32 * 2)) / 3; // 32 is horizontal padding on each side

    return Container(
      // Add a shadow at the top of the navbar
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2), // Shadow positioned above the navbar
          ),
        ],
      ),
      // Apply the specified padding
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Row(
        // This distributes the icons evenly across the available space
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home icon
          _buildNavItem(AppIcons.home, 0, context),

          // Trophy icon
          _buildNavItem(AppIcons.trophy, 1, context),

          // Library icon
          _buildNavItem(AppIcons.library, 2, context),

          // User icon
          _buildNavItem(AppIcons.user, 3, context),
        ],
      ),
    );
  }

  // Helper method to build each navigation item
  Widget _buildNavItem(String iconPath, int index, BuildContext context) {
    // Check if this item is the currently selected one
    final isSelected = selectedIndex == index;

    return GestureDetector(
      // When this item is tapped, call the onItemTapped callback with this item's index
      onTap: () => onItemTapped(index),
      child: SvgPicture.asset(
        iconPath,
        // Set a consistent height for all icons
        height: 32,
        // Change the color based on selection state
        colorFilter: ColorFilter.mode(
          isSelected
              ? Theme.of(context).primaryColor  // Selected color (from theme)
              : Colors.black.withOpacity(0.5),  // Unselected color
          BlendMode.srcIn,
        ),
      ),
    );
  }
}