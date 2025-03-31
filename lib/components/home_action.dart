import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAction extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const HomeAction({
    Key? key,
    required this.iconPath,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 148, // Fixed width as specified
        height: 148, // Fixed height as specified
        decoration: BoxDecoration(
          // Transparent fill with border
          border: Border.all(
            color: const Color(0xFF1D1B20), // Border color
            width: 4, // Border thickness
          ),
          borderRadius: BorderRadius.circular(18), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon placeholder with specified size and color
            SvgPicture.asset(
              iconPath,
              width: 64,
              height: 64,
              colorFilter: const ColorFilter.mode(
                Color(0xFF232A69), // Icon color
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12), // Spacing between icon and text
            // Label text with specified styling
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Helvetica Neue', // You may need to add this font to your project
                fontWeight: FontWeight.bold,
                color: Color(0xFF03030E), // Text color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}