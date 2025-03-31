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

    return InkWell(
      // InkWell provides tap feedback with ripple effect
      onTap: () {
        // When tapped, trigger the callback with a slight delay for animation
        Future.delayed(const Duration(milliseconds: 100), () {
          onItemTapped(index);
        });
      },
      // Make the touch target larger than the icon itself
      borderRadius: BorderRadius.circular(12),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Adds padding to increase tap target
        child: TweenAnimationBuilder(
          // This animation runs whenever a property changes
          tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut, // Smooth animation curve
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: SvgPicture.asset(
                iconPath,
                height: 28,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}