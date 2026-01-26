import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnhancementSelector extends StatelessWidget {
  final String? selectedOption;
  final Function(String) onSelected;

  const EnhancementSelector({
    super.key,
    required this.selectedOption,
    required this.onSelected,
  });

  final List<Map<String, dynamic>> options = const [
    {'name': 'Noise Removal', 'icon': Icons.grain},
    {'name': 'Sharpening', 'icon': Icons.details},
    {'name': 'Color Restore', 'icon': Icons.color_lens},
    {'name': 'Upscaling', 'icon': Icons.hd},
    {'name': 'Distortion', 'icon': Icons.grid_on},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enhancement Options",
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = selectedOption == option['name'];
              return GestureDetector(
                onTap: () => onSelected(option['name']),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 100,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.withOpacity(0.1),
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        option['icon'],
                        color: isSelected ? Colors.white : Colors.grey,
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        option['name'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
