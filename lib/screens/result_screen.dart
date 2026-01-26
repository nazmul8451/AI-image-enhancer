import 'dart:io';
import 'package:before_after/before_after.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enhancement Result"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.selectedImage == null || provider.resultImage == null) {
            return const Center(child: Text("No image to display"));
          }

          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BeforeAfter(
                        before: kIsWeb
                            ? Image.network(
                                provider.selectedImage!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(provider.selectedImage!.path),
                                fit: BoxFit.cover,
                              ),
                        after: kIsWeb
                            ? Image.network(
                                provider.resultImage!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(provider.resultImage!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // TODO: Implement Share
                              },
                              icon: const Icon(Icons.share),
                              label: const Text("Share"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Implement Save
                              },
                              icon: const Icon(Icons.download),
                              label: const Text("Save"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Comparison View",
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
