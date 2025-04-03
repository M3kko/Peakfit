import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakfit/constants/app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 16.0),
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 24),
                _buildStatsSection(),
                const SizedBox(height: 24),
                _buildActivitySection(),
                const SizedBox(height: 24),
                _buildSettingsSection(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        )
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // PROFILE PICTURE
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                border: Border.all(
                  color: const Color(0xFF1D1B20),
                  width: 3,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile_placeholder.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // EDIT BUTTON
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF1D1B20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(height: 16),
            // USERNAME
            const Text(
              'Broderick Cotter',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF1D1B20),
              ),
            ),
            const SizedBox(height: 4),
            // JOIN DATE
            Text(
              'Member since Mar 2025',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            // Edit profile button
            OutlinedButton(
              onPressed: () {
                // Navigate to edit profile screen
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: const BorderSide(color: Color(0xFF1D1B20), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1D1B20),
                ),
              ),
            ),
          ],
    );
  }

}
