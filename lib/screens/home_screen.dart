import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/navbar.dart';
import '../constants/app_icons.dart';
import 'leaderboard_screen.dart';
import 'library_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // This list holds the different screens we can navigate to
  final List<Widget> _screens = [
    // Home screen content (index 0)
    Column(
      children: [
        // Main content of home screen
        Expanded(
          child: Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    ),
    // Leaderboard (index 1)
    const LeaderboardScreen(),
    // Library (index 2)
    const LibraryScreen(),
    // Profile (index 3)
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              // Only show header on home screen
              if (_selectedIndex == 0) _buildHeader(),

              // Show the selected screen
              Expanded(
                child: _screens[_selectedIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHeader() {
    // Using a Column to stack the top controls and the main header text
    return Column(
      children: [
        // Top row with Training Mode, Streak, and Notification
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Training Mode toggle
            Container(
              height: 40, // Fixed height to match the streak counter
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B20),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text in Poppins Medium Italic
                  const Text(
                    'Training Mode',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500, // Medium
                      fontSize: 16, // Increased font size
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Green dot indicator
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            // Right side controls: Streak and Notification
            Row(
              children: [
                // Streak counter - also with fixed height
                Container(
                  height: 40, // Fixed height to match training mode
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1B20),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Flame icon
                      SvgPicture.asset(
                        AppIcons.streak,
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.orange,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Number in Poppins Regular
                      const Text(
                        '5',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Notification bell
                SvgPicture.asset(
                  AppIcons.notification,
                  height: 32,
                  width: 32,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF1D1B20), // Using the dark color for the icon itself
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Spacer between top controls and header text
        const SizedBox(height: 40),

        // Main header text "What Do You Want To Do Today?"
        const Text(
          'What Do You Want\nTo Do Today?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 32,
            color: Color(0xFF1D1B20),
            height: 1.2, // Reduces line height slightly for tighter multi-line text
          ),
        ),
      ],
    );
  }
}