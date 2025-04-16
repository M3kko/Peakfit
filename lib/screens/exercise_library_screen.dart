import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_icons.dart';
import '../components/exercise_card.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  // Current filter selection
  String _selectedFilter = 'All';

  // Search text controller
  final TextEditingController _searchController = TextEditingController();

  // List of available filter options
  final List<String> _filterOptions = [
    'All',
    'Chest',
    'Back',
    'Shoulders',
    'Biceps',
    'Triceps',
    'Legs',
    'Abs',
    'Cardio',
  ];

  // Example exercise data - in a real app, this would come from a database
  final List<Map<String, dynamic>> _exercises = [
    {
      'name': 'Bench Press',
      'muscleGroup': 'Chest',
      'difficulty': 'Intermediate',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.grid,
    },
    {
      'name': 'Push-up',
      'muscleGroup': 'Chest',
      'difficulty': 'Beginner',
      'equipment': 'Bodyweight',
      'patternType': ExercisePatternType.minimal,
    },
    {
      'name': 'Incline Dumbbell Press',
      'muscleGroup': 'Chest',
      'difficulty': 'Intermediate',
      'equipment': 'Dumbbells',
      'patternType': ExercisePatternType.diagonal,
    },
    {
      'name': 'Cable Fly',
      'muscleGroup': 'Chest',
      'difficulty': 'Intermediate',
      'equipment': 'Cables',
      'patternType': ExercisePatternType.zigzag,
    },
    {
      'name': 'Pull-up',
      'muscleGroup': 'Back',
      'difficulty': 'Intermediate',
      'equipment': 'Bodyweight',
      'patternType': ExercisePatternType.diagonal,
    },
    {
      'name': 'Lat Pulldown',
      'muscleGroup': 'Back',
      'difficulty': 'Beginner',
      'equipment': 'Machine',
      'patternType': ExercisePatternType.waves,
    },
    {
      'name': 'Barbell Row',
      'muscleGroup': 'Back',
      'difficulty': 'Intermediate',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.grid,
    },
    {
      'name': 'Seated Cable Row',
      'muscleGroup': 'Back',
      'difficulty': 'Beginner',
      'equipment': 'Cables',
      'patternType': ExercisePatternType.circularDots,
    },
    {
      'name': 'Overhead Press',
      'muscleGroup': 'Shoulders',
      'difficulty': 'Intermediate',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.dots,
    },
    {
      'name': 'Lateral Raise',
      'muscleGroup': 'Shoulders',
      'difficulty': 'Beginner',
      'equipment': 'Dumbbells',
      'patternType': ExercisePatternType.minimal,
    },
    {
      'name': 'Reverse Fly',
      'muscleGroup': 'Shoulders',
      'difficulty': 'Beginner',
      'equipment': 'Dumbbells',
      'patternType': ExercisePatternType.waves,
    },
    {
      'name': 'Barbell Curl',
      'muscleGroup': 'Biceps',
      'difficulty': 'Beginner',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.minimal,
    },
    {
      'name': 'Hammer Curl',
      'muscleGroup': 'Biceps',
      'difficulty': 'Beginner',
      'equipment': 'Dumbbells',
      'patternType': ExercisePatternType.diagonal,
    },
    {
      'name': 'Tricep Pushdown',
      'muscleGroup': 'Triceps',
      'difficulty': 'Beginner',
      'equipment': 'Cables',
      'patternType': ExercisePatternType.zigzag,
    },
    {
      'name': 'Skull Crusher',
      'muscleGroup': 'Triceps',
      'difficulty': 'Intermediate',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.grid,
    },
    {
      'name': 'Squat',
      'muscleGroup': 'Legs',
      'difficulty': 'Intermediate',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.diagonal,
    },
    {
      'name': 'Leg Press',
      'muscleGroup': 'Legs',
      'difficulty': 'Beginner',
      'equipment': 'Machine',
      'patternType': ExercisePatternType.waves,
    },
    {
      'name': 'Deadlift',
      'muscleGroup': 'Legs',
      'difficulty': 'Advanced',
      'equipment': 'Barbell',
      'patternType': ExercisePatternType.grid,
    },
    {
      'name': 'Lunge',
      'muscleGroup': 'Legs',
      'difficulty': 'Beginner',
      'equipment': 'Bodyweight',
      'patternType': ExercisePatternType.minimal,
    },
    {
      'name': 'Leg Extension',
      'muscleGroup': 'Legs',
      'difficulty': 'Beginner',
      'equipment': 'Machine',
      'patternType': ExercisePatternType.dots,
    },
    {
      'name': 'Crunches',
      'muscleGroup': 'Abs',
      'difficulty': 'Beginner',
      'equipment': 'Bodyweight',
      'patternType': ExercisePatternType.minimal,
    },
    {
      'name': 'Plank',
      'muscleGroup': 'Abs',
      'difficulty': 'Beginner',
      'equipment': 'Bodyweight',
      'patternType': ExercisePatternType.dots,
    },
    {
      'name': 'Russian Twist',
      'muscleGroup': 'Abs',
      'difficulty': 'Intermediate',
      'equipment': 'Medicine Ball',
      'patternType': ExercisePatternType.circularDots,
    },
    {
      'name': 'Treadmill Running',
      'muscleGroup': 'Cardio',
      'difficulty': 'Beginner',
      'equipment': 'Machine',
      'patternType': ExercisePatternType.waves,
    },
    {
      'name': 'Jump Rope',
      'muscleGroup': 'Cardio',
      'difficulty': 'Beginner',
      'equipment': 'Jump Rope',
      'patternType': ExercisePatternType.zigzag,
    },
    {
      'name': 'Cycling',
      'muscleGroup': 'Cardio',
      'difficulty': 'Beginner',
      'equipment': 'Bicycle',
      'patternType': ExercisePatternType.diagonal,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter exercises based on selected category and search query
  List<Map<String, dynamic>> _getFilteredExercises() {
    String searchTerm = _searchController.text.toLowerCase();

    return _exercises.where((exercise) {
      // Apply muscle group filter
      bool matchesFilter = _selectedFilter == 'All' ||
          exercise['muscleGroup'].toString().toLowerCase() == _selectedFilter.toLowerCase();

      // Apply search filter if text is entered
      bool matchesSearch = searchTerm.isEmpty ||
          exercise['name'].toString().toLowerCase().contains(searchTerm) ||
          exercise['equipment'].toString().toLowerCase().contains(searchTerm) ||
          exercise['difficulty'].toString().toLowerCase().contains(searchTerm);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredExercises = _getFilteredExercises();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1D1B20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Exercise Library',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF1D1B20),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search exercises...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filter chips
          SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filterOptions.length,
                itemBuilder: (context, index) {
                  final filter = _filterOptions[index];
                  final isSelected = _selectedFilter == filter;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        filter,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                  );
                },
              ),
            ),
          ),

          // Divider
          const Divider(height: 1),

          // Results count
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              '${filteredExercises.length} exercises found',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Exercise list
          Expanded(
            child: filteredExercises.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: filteredExercises.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
                return ExerciseCard(
                  name: exercise['name'],
                  muscleGroup: exercise['muscleGroup'],
                  difficulty: exercise['difficulty'],
                  equipment: exercise['equipment'],
                  patternType: exercise['patternType'],
                  onTap: () => _showExerciseDetails(exercise),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Empty state when no exercises match the filter
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.workout,
            height: 64,
            width: 64,
            colorFilter: ColorFilter.mode(
              Colors.grey[400]!,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No exercises found',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your search or filter',
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

  // Show bottom sheet with exercise details
  void _showExerciseDetails(Map<String, dynamic> exercise) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ExerciseDetailsSheet(exercise: exercise),
    );
  }
}

// Exercise details bottom sheet component
class _ExerciseDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const _ExerciseDetailsSheet({
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    // Get color based on muscle group
    final Color headerColor = _getMuscleGroupColor(exercise['muscleGroup']);

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header with exercise name and muscle group
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: headerColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Exercise name
                    Text(
                      exercise['name'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Muscle group and difficulty
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            exercise['muscleGroup'],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            exercise['difficulty'],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Exercise details content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Equipment section
                    _buildInfoSection(
                      title: 'Equipment',
                      icon: Icons.fitness_center,
                      content: exercise['equipment'],
                    ),

                    const SizedBox(height: 24),

                    // How to perform section
                    _buildInfoSection(
                      title: 'How to Perform',
                      icon: Icons.play_circle_outline,
                      content: _getExerciseInstructions(exercise['name']),
                    ),

                    const SizedBox(height: 24),

                    // Tips section
                    _buildInfoSection(
                      title: 'Tips & Form Cues',
                      icon: Icons.lightbulb_outline,
                      content: _getExerciseTips(exercise['name']),
                    ),

                    const SizedBox(height: 24),

                    // Variations section
                    _buildInfoSection(
                      title: 'Variations',
                      icon: Icons.shuffle,
                      content: _getExerciseVariations(exercise['name']),
                      isList: true,
                    ),

                    const SizedBox(height: 24),

                    // Add to Workout button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${exercise['name']} added to your workout'),
                            backgroundColor: headerColor,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: headerColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add to Workout',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build info sections
  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required String content,
    bool isList = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.grey[700],
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Section content
        isList
            ? _buildListContent(content)
            : Text(
          content,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Helper method to build list content
  Widget _buildListContent(String content) {
    final items = content.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Helper methods to get exercise content (in a real app, this would come from a database)
  String _getExerciseInstructions(String exerciseName) {
    // Sample instructions for a few exercises
    switch (exerciseName) {
      case 'Bench Press':
        return 'Lie on a flat bench with your feet firmly on the ground. Grip the barbell slightly wider than shoulder-width. Lower the bar to your mid-chest, then press upward until your arms are fully extended. Maintain a slight arch in your lower back and keep your shoulder blades retracted throughout the movement.';
      case 'Push-up':
        return 'Start in a plank position with hands shoulder-width apart. Lower your body until your chest nearly touches the floor. Keep your elbows at about a 45-degree angle to your body. Push back up to the starting position while maintaining a straight line from head to heels.';
      case 'Squat':
        return 'Stand with feet shoulder-width apart. Hold a barbell across your upper back. Bend your knees and hips to lower your body, keeping your chest up and back straight. Lower until your thighs are parallel to the ground, then drive through your heels to return to the starting position.';
      default:
        return 'Position yourself properly with good posture. Perform the movement with controlled form through the full range of motion. Focus on engaging the target muscles throughout the exercise.';
    }
  }

  String _getExerciseTips(String exerciseName) {
    // Sample tips for a few exercises
    switch (exerciseName) {
      case 'Bench Press':
        return 'Keep your wrists straight and directly above your elbows. Drive your feet into the ground for stability. Focus on pushing yourself away from the bar rather than pushing the bar up. Control the eccentric (lowering) phase for better muscle development.';
      case 'Push-up':
        return 'Keep your core tight throughout the movement. Don\'t let your hips sag or pike up. For more chest engagement, place hands slightly wider. For more tricep engagement, keep hands closer together.';
      case 'Squat':
        return 'Keep your weight in your heels and midfoot. Don\'t let your knees cave inward. Brace your core throughout the movement. Focus on hip drive when ascending from the bottom position.';
      default:
        return 'Breathe properly - exhale during exertion. Focus on mind-muscle connection. Prioritize proper form over heavier weights. Slow down the movement to increase time under tension.';
    }
  }

  String _getExerciseVariations(String exerciseName) {
    // Sample variations for a few exercises
    switch (exerciseName) {
      case 'Bench Press':
        return 'Incline Bench Press\nDecline Bench Press\nClose-Grip Bench Press\nDumbbell Bench Press\nFloor Press';
      case 'Push-up':
        return 'Diamond Push-up\nWide-Grip Push-up\nIncline Push-up\nDecline Push-up\nPlyometric Push-up';
      case 'Squat':
        return 'Front Squat\nGoblet Squat\nSplit Squat\nBulgarian Split Squat\nOverhead Squat';
      default:
        return 'Lighter variation with higher reps\nHeavier variation with lower reps\nSlower tempo variation\nSingle-limb variation\nMachine-assisted variation';
    }
  }

  // Helper method to determine color based on muscle group
  Color _getMuscleGroupColor(String muscleGroup) {
    switch (muscleGroup.toLowerCase()) {
      case 'chest':
        return const Color(0xFF5C6BC0); // Indigo
      case 'back':
        return const Color(0xFF26A69A); // Teal
      case 'shoulders':
        return const Color(0xFFEF5350); // Red
      case 'biceps':
        return const Color(0xFF66BB6A); // Green
      case 'triceps':
        return const Color(0xFFFF7043); // Deep Orange
      case 'legs':
        return const Color(0xFF8D6E63); // Brown
      case 'glutes':
        return const Color(0xFF7E57C2); // Deep Purple
      case 'abs':
        return const Color(0xFFFFCA28); // Amber
      case 'full body':
        return const Color(0xFF42A5F5); // Blue
      case 'cardio':
        return const Color(0xFFEC407A); // Pink
      default:
        return const Color(0xFF78909C); // Blue Grey
    }
  }
}