import 'package:flutter/material.dart';
import '../components/navbar.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // We'll move the header here later
        SizedBox(height: 24),
        Expanded(
          child: Center(
            child: Text(
              'PeakFit Home Screen Content',
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning,',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'James',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}