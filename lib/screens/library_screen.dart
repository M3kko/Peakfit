import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_icons.dart';
import '../components/workout_card.dart';
import 'exercise_library_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // Tab selection state
  bool _showWorkouts = true;

  // List of recommended workouts for better maintainability
  final List<Map<String, dynamic>> _recommendedWorkouts = [
    {
      'title': 'Upper Body Strength Builder',
      'duration': '45 min',
      'difficulty': 'Intermediate',
      'category': 'Strength',
      'patternType': WorkoutPatternType.diagonal,
    },
    {
      'title': 'HIIT Cardio Blast',
      'duration': '30 min',
      'difficulty': 'Advanced',
      'category': 'HIIT',
      'patternType': WorkoutPatternType.zigzag,
    },
    {
      'title': 'Core Foundations',
      'duration': '35 min',
      'difficulty': 'Beginner',
      'category': 'Core',
      'patternType': WorkoutPatternType.dots,
    },
  ];

  // List of strength workouts
  final List<Map<String, dynamic>> _strengthWorkouts = [
    {
      'title': 'Full Body Circuit',
      'duration': '40 min',
      'difficulty': 'Intermediate',
      'category': 'Full Body',
      'patternType': WorkoutPatternType.grid,
    },
    {
      'title': 'Leg Day Essentials',
      'duration': '45 min',
      'difficulty': 'Intermediate',
      'category': 'Strength',
      'patternType': WorkoutPatternType.waves,
    },
    {
      'title': 'Push Day Focus',
      'duration': '35 min',
      'difficulty': 'Advanced',
      'category': 'Strength',
      'patternType': WorkoutPatternType.diagonal,
    },
    {
      'title': 'Pull Day Power',
      'duration': '35 min',
      'difficulty': 'Advanced',
      'category': 'Strength',
      'patternType': WorkoutPatternType.dots,
    },
  ];

  // List of recovery workouts
  final List<Map<String, dynamic>> _recoveryWorkouts = [
    {
      'title': 'Full Body Stretch',
      'duration': '20 min',
      'difficulty': 'Beginner',
      'category': 'Recovery',
      'patternType': WorkoutPatternType.waves,
    },
    {
      'title': 'Yoga for Recovery',
      'duration': '30 min',
      'difficulty': 'Beginner',
      'category': 'Yoga',
      'patternType': WorkoutPatternType.dots,
    },
    {
      'title': 'Mobility Flow',
      'duration': '25 min',
      'difficulty': 'Intermediate',
      'category': 'Flexibility',
      'patternType': WorkoutPatternType.zigzag,
    },
    {
      'title': 'Foam Roller Routine',
      'duration': '15 min',
      'difficulty': 'Beginner',
      'category': 'Recovery',
      'patternType': WorkoutPatternType.circularDots,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Don't add bottom padding to avoid interfering with navbar
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab switcher
            _buildTabSwitcher(),

            // Header Section
            _buildHeaderSection(),

            // Main content area
            Expanded(
              child: _showWorkouts
                  ? _buildWorkoutsTab()
                  : _buildExerciseTab(),
            ),
          ],
        ),
      ),
    );
  }

  // Tab switching UI component
  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Workouts tab
            _buildTabOption(
              title: 'Workouts',
              isSelected: _showWorkouts,
              onTap: () => setState(() => _showWorkouts = true),
            ),

            const SizedBox(width: 24),

            // Exercises tab
            _buildTabOption(
              title: 'Exercises',
              isSelected: !_showWorkouts,
              onTap: () => _navigateToExerciseLibrary(),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle navigation to exercise library
  void _navigateToExerciseLibrary() {
    setState(() => _showWorkouts = false);

    // Navigate to exercise library
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExerciseLibraryScreen()),
    ).then((_) {
      // When returning from exercise library, switch back to workouts tab
      setState(() {
        _showWorkouts = true;
      });
    });
  }

  // Individual tab option
  Widget _buildTabOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 16,
          color: isSelected
              ? const Color(0xFF1D1B20)
              : Colors.grey[500],
        ),
      ),
    );
  }

  // Header section with title and subtitle
  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Library',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 32,
              color: Color(0xFF1D1B20),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _showWorkouts
                ? 'Find workouts tailored to your fitness goals'
                : 'Browse exercises by muscle group or equipment',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Exercise tab content - just a transitional placeholder with no automatic navigation
  Widget _buildExerciseTab() {
    return GestureDetector(
      onTap: _navigateToExerciseLibrary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.workout,
              height: 48,
              width: 48,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Exercise Library',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1B20),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap to browse exercises',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Workouts tab content
  Widget _buildWorkoutsTab() {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        // Recommended section
        _buildWorkoutSection(
          title: 'Recommended For Your Goals',
          subtitle: 'Workouts tailored to your specific fitness goals',
          iconPath: AppIcons.trophy,
          height: 160,
          workoutsList: _recommendedWorkouts,
          isRecommended: true,
        ),

        const SizedBox(height: 16),

        // Strength & Endurance section
        _buildWorkoutSection(
          title: 'Build Strength & Endurance',
          subtitle: 'General workouts to improve fitness',
          iconPath: AppIcons.workout,
          height: 140,
          workoutsList: _strengthWorkouts,
        ),

        const SizedBox(height: 16),

        // Recovery section
        _buildWorkoutSection(
          title: 'Recover & Restore',
          subtitle: 'Workouts to help your body recover and prevent injury',
          iconPath: AppIcons.recover,
          height: 140,
          workoutsList: _recoveryWorkouts,
        ),

        // Space for navbar
        SizedBox(height: MediaQuery.of(context).padding.bottom + 80),
      ],
    );
  }

  // Reusable workout section builder
  Widget _buildWorkoutSection({
    required String title,
    required String subtitle,
    required String iconPath,
    required double height,
    required List<Map<String, dynamic>> workoutsList,
    bool isRecommended = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
          child: _buildSectionHeader(title, subtitle, iconPath),
        ),

        const SizedBox(height: 8),

        // Horizontal workout list
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            itemCount: workoutsList.length,
            itemBuilder: (context, index) {
              // Get the current workout data
              final workout = workoutsList[index];

              return Container(
                margin: EdgeInsets.only(
                    right: index < workoutsList.length - 1 ? 16.0 : 0.0
                ),
                child: WorkoutCard(
                  title: workout['title'],
                  duration: workout['duration'],
                  difficulty: workout['difficulty'],
                  category: workout['category'],
                  patternType: workout['patternType'],
                  isRecommended: isRecommended,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Section header builder
  Widget _buildSectionHeader(String title, String subtitle, String iconPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 20,
              width: 20,
              colorFilter: const ColorFilter.mode(
                Color(0xFF1D1B20),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1D1B20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}