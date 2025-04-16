import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import '../constants/app_icons.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String duration;
  final String difficulty;
  final String category;
  final bool isRecommended;
  final WorkoutPatternType patternType;
  final Color? customColor;

  const WorkoutCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.category,
    this.isRecommended = false,
    this.patternType = WorkoutPatternType.diagonal,
    this.customColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine card size based on whether it's a recommendation or regular card
    final double cardHeight = isRecommended ? 160 : 140;
    final double cardWidth = isRecommended
        ? MediaQuery.of(context).size.width * 0.85
        : MediaQuery.of(context).size.width * 0.6;

    // Get color based on category
    final Color cardColor = customColor ?? _getCategoryColor(category);

    return Container(
      height: cardHeight,
      width: cardWidth,
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Pattern layer
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(
                painter: WorkoutPatternPainter(
                  patternType: patternType,
                  patternColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),

          // Content layer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Spacer(),

                // Workout title
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Workout details row
                Row(
                  children: [
                    // Duration
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.schedule,
                          height: 14,
                          width: 14,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Difficulty
                    Row(
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
                          difficulty,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    if (isRecommended) ...[
                      const Spacer(),
                      // Recommended badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Recommended',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to determine color based on category
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'strength':
        return const Color(0xFF5C6BC0); // Indigo
      case 'cardio':
        return const Color(0xFFEF5350); // Red
      case 'hiit':
        return const Color(0xFFFF7043); // Deep Orange
      case 'yoga':
      case 'flexibility':
        return const Color(0xFF66BB6A); // Green
      case 'recovery':
      case 'stretching':
        return const Color(0xFF26A69A); // Teal
      case 'core':
        return const Color(0xFFFFCA28); // Amber
      case 'full body':
        return const Color(0xFF8D6E63); // Brown
      default:
        return const Color(0xFF5C6BC0); // Default Indigo
    }
  }
}

// Enum for different pattern types
enum WorkoutPatternType {
  diagonal,
  dots,
  zigzag,
  waves,
  grid,
  circularDots
}

// Custom painter for creating the patterns
class WorkoutPatternPainter extends CustomPainter {
  final WorkoutPatternType patternType;
  final Color patternColor;

  WorkoutPatternPainter({
    required this.patternType,
    required this.patternColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = patternColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    switch (patternType) {
      case WorkoutPatternType.diagonal:
        _drawDiagonalPattern(canvas, size, paint);
        break;
      case WorkoutPatternType.dots:
        _drawDotsPattern(canvas, size, paint);
        break;
      case WorkoutPatternType.zigzag:
        _drawZigzagPattern(canvas, size, paint);
        break;
      case WorkoutPatternType.waves:
        _drawWavesPattern(canvas, size, paint);
        break;
      case WorkoutPatternType.grid:
        _drawGridPattern(canvas, size, paint);
        break;
      case WorkoutPatternType.circularDots:
        _drawCircularDotsPattern(canvas, size, paint);
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
    final double radius = 2;
    paint.style = PaintingStyle.fill;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  void _drawZigzagPattern(Canvas canvas, Size size, Paint paint) {
    final double spacing = 20;
    final double amplitude = 10;

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
    final double spacing = 40;
    final double amplitude = 8;
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
    final double spacing = 20;

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
    final double spacing = 30;
    final double maxRadius = 12;
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! WorkoutPatternPainter ||
        oldDelegate.patternType != patternType ||
        oldDelegate.patternColor != patternColor;
  }
}