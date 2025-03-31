import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/navbar.dart';
import '../constants/app_icons.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Training Mode',
          style: TextStyle(
            color: Color(0xFF1D1B20),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1D1B20)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Training stats summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1B20),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Workouts', '12'),
                    _buildStatItem('Streak', '5 days'),
                    _buildStatItem('Time', '4.5 hrs'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Section header
              const Text(
                'Recommended Training',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1B20),
                ),
              ),

              const SizedBox(height: 16),

              // Training recommendations
              Expanded(
                child: ListView(
                  children: [
                    _buildTrainingItem(
                      'Daily Workout',
                      'Full body strength • 25 min',
                      AppIcons.workout,
                    ),
                    _buildTrainingItem(
                      'Recovery Session',
                      'Stretching • 15 min',
                      AppIcons.recover,
                    ),
                    _buildTrainingItem(
                      'Weekly Challenge',
                      'Push-ups • 5 min',
                      AppIcons.trophy,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index != 0) {
            // Go back to main home screen and switch to the tapped tab
            Navigator.pop(context, index);
          }
        },
      ),
    );
  }

  // Helper method to build stat items
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Helper method to build training items
  Widget _buildTrainingItem(String title, String subtitle, String iconPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1D1B20), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 40,
            width: 40,
            colorFilter: const ColorFilter.mode(
              Color(0xFF232A69), // Icon color matching your spec
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1B20),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF1D1B20),
          ),
        ],
      ),
    );
  }
}