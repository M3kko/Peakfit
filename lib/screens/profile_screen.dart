import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakfit/constants/app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
                  image: AssetImage(''),
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
          ],
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

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Stats',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF1D1B20),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatCard(
              'Workouts',
              '28',
              AppIcons.workout,
              const Color(0xFF4A66F4),
            ),
            _buildStatCard(
              'Streak',
              '5 days',
              AppIcons.streak,
              const Color(0xFFFF5757),
            ),
            _buildStatCard(
              'Badges Earned',
              '12',
              AppIcons.trophy,
              const Color(0xFF2CB67D),
            ),
            _buildStatCard(
              'Hours',
              '7',
              AppIcons.hourglass,
              const Color(0xFFFFA500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String iconPath, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF1D1B20),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF1D1B20),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full activity history
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A66F4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Activity list with limited height and scroll
        SizedBox(
          height: 180, // Increased height to fit three activities comfortably
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildActivityItem(
                'Completed Chest Workout',
                '2 hours ago',
                AppIcons.workout,
              ),
              _buildActivityItem(
                'Achieved New Personal Best',
                'Yesterday',
                AppIcons.trophy,
              ),
              _buildActivityItem(
                'Finished Checklist',
                '3 days ago',
                AppIcons.checklist,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, String iconPath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B20).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF1D1B20),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF1D1B20),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF1D1B20),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF1D1B20),
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingItem('Account Settings', Icons.person_outline),
        _buildSettingItem('Notification Preferences', Icons.notifications_none),
        _buildSettingItem('Privacy Settings', Icons.lock_outline),
        _buildSettingItem('Help & Support', Icons.help_outline),
        _buildSettingItem('Log Out', Icons.logout, isDestructive: true),
      ],
    );
  }

  Widget _buildSettingItem(String title, IconData icon, {bool isDestructive = false}) {
    return InkWell(
      onTap: () {
        // Navigate to specific setting screen
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : const Color(0xFF1D1B20),
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDestructive ? Colors.red : const Color(0xFF1D1B20),
              ),
            ),
            const Spacer(),
            if (!isDestructive)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF1D1B20),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
