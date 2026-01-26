import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/app_provider.dart';
import '../widgets/enhancement_selector.dart';
import '../widgets/image_upload_widget.dart';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Image Enhancer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transform your photos\nwith AI Magic ✨",
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                ImageUploadWidget(
                  image: provider.selectedImage,
                  onTap: () => _showImagePicker(context, provider),
                ),
                const SizedBox(height: 32),
                if (provider.selectedImage != null) ...[
                  EnhancementSelector(
                    selectedOption: provider.selectedEnhancement,
                    onSelected: provider.imageSelectEnhancement,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.isProcessing
                          ? null
                          : () async {
                              if (provider.selectedEnhancement == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please select an enhancement option"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }
                              await provider.processImage();
                              if (context.mounted &&
                                  provider.resultImage != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResultScreen(),
                                  ),
                                );
                              }
                            },
                      child: provider.isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Enhance Image"),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showImagePicker(BuildContext context, AppProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text("Take Photo"),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
