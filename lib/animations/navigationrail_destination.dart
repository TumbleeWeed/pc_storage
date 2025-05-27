import 'package:flutter/material.dart';

class CustomNavigationRailDestination extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isHovered;
  final VoidCallback onTap;

  const CustomNavigationRailDestination({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isHovered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (isHovered) {
      },
      child: Stack(
        children: [
          // Анимированный прямоугольник слева
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),

            left: isSelected ? 0 : -10, // Прямоугольник выдвигается слева
            top: 0,
            bottom: 0,
            width: 4, // Фиксированная ширина прямоугольника
            child: Container(
              color: Colors.white,
            ),

          ),
          // Контент кнопки
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(12),
            width: 200, // Фиксированная ширина контейнера
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.1)
                  : isHovered
                  ? Colors.white.withOpacity(0.05) // Эффект при наведении
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.7), // Цвет иконки неактивный
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.7), // Цвет текста неактивный
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}