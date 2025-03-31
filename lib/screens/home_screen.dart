import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/navbar.dart';
import '../components/home_action.dart';
import '../constants/app_icons.dart';
import 'leaderboard_screen.dart';
import 'library_screen.dart';
import 'profile_screen.dart';
import 'home_screen2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Page controller for the announcement cards
  final PageController _announcementController = PageController();
  int _currentAnnouncementPage = 0;

  // This list holds the different screens we can navigate to
  final List<Widget> _screens = [
    // Each non-home screen
    Container(), // Empty placeholder since we're building home content separately
    const LeaderboardScreen(),
    const LibraryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _announcementController.addListener(() {
      if (_announcementController.page != null) {
        setState(() {
          _currentAnnouncementPage = _announcementController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _announcementController.dispose();
    super.dispose();
  }

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

              // Show content based on selected tab
              Expanded(
                child: _selectedIndex == 0
                    ? _buildHomeContent()
                    : _screens[_selectedIndex],
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

  // Method to build the home content with grid and announcement cards
  Widget _buildHomeContent() {
    return Column(
      children: [
        // Space after header text
        const SizedBox(height: 30),

        // Grid of action buttons
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeAction(
              iconPath: AppIcons.warmup,
              label: 'Warm-Up',
              onTap: () {},
            ),
            HomeAction(
              iconPath: AppIcons.workout,
              label: 'Workout',
              onTap: () {},
            ),
            HomeAction(
              iconPath: AppIcons.recover,
              label: 'Recovery',
              onTap: () {},
            ),
            HomeAction(
              iconPath: AppIcons.schedule,
              label: 'Schedule',
              onTap: () {},
            ),
          ],
        ),

        // Push announcement cards to the bottom
        const Spacer(),

        // Announcement cards
        _buildAnnouncementCards(),

        // Space before navbar
        const SizedBox(height: 20),
      ],
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
            // Training Mode toggle - now with navigation
            GestureDetector(
              onTap: () {
                // Navigate to HomeScreen2 when Training Mode is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen2()),
                ).then((value) {
                  // Handle return value (potentially switching tabs)
                  if (value != null && value is int) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  }
                });
              },
              child: Container(
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

                // Notification bell without background
                SvgPicture.asset(
                  AppIcons.notification,
                  height: 24,
                  width: 24,
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

  // Build the announcement cards carousel
  Widget _buildAnnouncementCards() {
    // Sample announcements with different colors and messages
    final List<Map<String, dynamic>> announcements = [
      {
        'title': 'New Challenge',
        'message': 'Complete 5 workouts this week to earn a special badge!',
        'color': const Color(0xFF4A66F4), // Blue
        'icon': AppIcons.trophy,
      },
      {
        'title': 'Tip of the Day',
        'message': 'Stay hydrated! Drink water before, during, and after workouts.',
        'color': const Color(0xFF2CB67D), // Green
        'icon': AppIcons.recover,
      },
      {
        'title': 'Workout of the Week',
        'message': 'Try our new HIIT routine designed for maximum calorie burn!',
        'color': const Color(0xFFFF5757), // Red
        'icon': AppIcons.workout,
      },
    ];

    return Column(
      children: [
        // Card carousel
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _announcementController,
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      announcement['color'],
                      announcement['color'].withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: announcement['color'].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Icon circle
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            announcement['icon'],
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Text content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              announcement['title'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              announcement['message'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Indicator dots
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            announcements.length,
                (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentAnnouncementPage == index
                    ? const Color(0xFF1D1B20)
                    : const Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}