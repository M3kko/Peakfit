import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnnouncementCard extends StatefulWidget {
  const AnnouncementCard({Key? key}) : super(key: key);

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample announcements - in a real app, these would come from a backend
  final List<Map<String, dynamic>> _announcements = [
    {
      'title': 'New Workout Added',
      'description': 'Try our new HIIT cardio routine for maximum calorie burn!',
      'icon': 'workout',
      'color': Color(0xFF4A66F4),
    },
    {
      'title': 'Join the Challenge',
      'description': 'Complete 3 workouts this week to earn bonus points',
      'icon': 'trophy',
      'color': Color(0xFFFF5757),
    },
    {
      'title': 'Recovery Tip',
      'description': 'Remember to drink water after your workout sessions',
      'icon': 'recover',
      'color': Color(0xFF2CB67D),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _announcements.length,
            itemBuilder: (context, index) {
              return _buildAnnouncementCard(_announcements[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _announcements.length,
                (index) => _buildDotIndicator(index),
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: announcement['color'].withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            announcement['color'],
            announcement['color'].withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Left side with icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/${announcement['icon']}_icon.svg',
                  height: 30,
                  width: 30,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right side with text
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
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    announcement['description'],
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
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? const Color(0xFF1D1B20)
            : const Color(0xFFD9D9D9),
      ),
    );
  }
}