import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatelessWidget {
  final XFile? image;
  final VoidCallback onTap;

  const ImageUploadWidget({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [10, 8],
        strokeWidth: 2,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: kIsWeb
                      ? Image.network(
                          image!.path, // On web, XFile path is a blob URL
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Upload Image",
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tap to select from gallery or camera",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
