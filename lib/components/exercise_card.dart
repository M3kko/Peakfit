import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import '../constants/app_icons.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String muscleGroup;
  final String difficulty;
  final String equipment;
  final ExercisePatternType patternType;
  final Color? customColor;
  final VoidCallback? onTap;

  const ExerciseCard({
    Key? key,
    required this.name,
    required this.muscleGroup,
    required this.difficulty,
    required this.equipment,
    this.patternType = ExercisePatternType.diagonal,
    this.customColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get color based on muscle group
    final Color cardColor = customColor ?? _getMuscleGroupColor(muscleGroup);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Pattern layer
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomPaint(
                  painter: ExercisePatternPainter(
                    patternType: patternType,
                    patternColor: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),

            // Content layer
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Left side with name and muscle group
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exercise name
                        Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const Spacer(),

                        // Muscle group tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            muscleGroup,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right side with icons
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Difficulty indicator
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.fitness_center,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              difficulty,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Equipment indicator
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppIcons.workout,
                              height: 14,
                              width: 14,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              equipment,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        const Spacer(),

                        // View details hint
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

// Enum for different pattern types
enum ExercisePatternType {
  diagonal,
  dots,
  zigzag,
  waves,
  grid,
  circularDots,
  minimal
}

// Custom painter for creating the patterns
class ExercisePatternPainter extends CustomPainter {
  final ExercisePatternType patternType;
  final Color patternColor;

  ExercisePatternPainter({
    required this.patternType,
    required this.patternColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = patternColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    switch (patternType) {
      case ExercisePatternType.diagonal:
        _drawDiagonalPattern(canvas, size, paint);
        break;
      case ExercisePatternType.dots:
        _drawDotsPattern(canvas, size, paint);
        break;
      case ExercisePatternType.zigzag:
        _drawZigzagPattern(canvas, size, paint);
        break;
      case ExercisePatternType.waves:
        _drawWavesPattern(canvas, size, paint);
        break;
      case ExercisePatternType.grid:
        _drawGridPattern(canvas, size, paint);
        break;
      case ExercisePatternType.circularDots:
        _drawCircularDotsPattern(canvas, size, paint);
        break;
      case ExercisePatternType.minimal:
        _drawMinimalPattern(canvas, size, paint);
        break;
    }
  }

  void _drawDiagonalPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 20;
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  void _drawDotsPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 20;
    final double radius = 1.5;
    paint.style = PaintingStyle.fill;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  void _drawZigzagPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 15;
    final double amplitude = 8;

    for (double y = spacing; y < size.height; y += spacing * 2) {
      final path = Path();
      path.moveTo(0, y);

      for (double x = 0; x < size.width; x += spacing) {
        path.lineTo(x + spacing / 2, y - amplitude);
        path.lineTo(x + spacing, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  void _drawWavesPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 30;
    final double amplitude = 6;
    final double frequency = 0.1;

    for (double baseY = spacing; baseY < size.height; baseY += spacing) {
      final path = Path();
      path.moveTo(0, baseY);

      for (double x = 0; x < size.width; x += 1) {
        final double y = baseY + math.sin(x * frequency) * amplitude;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  void _drawGridPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 15;

    // Horizontal lines
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Vertical lines
    for (double x = spacing; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  void _drawCircularDotsPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 25;
    final double maxRadius = 8;
    paint.style = PaintingStyle.fill;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        // Vary the size of dots based on position
        final double normalizedX = x / size.width;
        final double normalizedY = y / size.height;
        final double radius = maxRadius * (normalizedX + normalizedY) / 2;

        canvas.drawCircle(Offset(x, y), radius * 0.5, paint);
      }
    }
  }

  void _drawMinimalPattern(Canvas canvas, Size size, Paint paint) {
    // Just add a few subtle elements

    // A thin line at the bottom
    canvas.drawLine(
      Offset(0, size.height - 10),
      Offset(size.width * 0.8, size.height - 10),
      paint,
    );

    // A couple of dots
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.25), 2, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.4), 1.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! ExercisePatternPainter ||
        oldDelegate.patternType != patternType ||
        oldDelegate.patternColor != patternColor;
  }
}