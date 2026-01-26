import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppProvider extends ChangeNotifier {
  XFile? _selectedImage;
  XFile? _resultImage; // Placeholder for now
  bool _isProcessing = false;
  String? _selectedEnhancement;

  XFile? get selectedImage => _selectedImage;
  XFile? get resultImage => _resultImage;
  bool get isProcessing => _isProcessing;
  String? get selectedEnhancement => _selectedEnhancement;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        _selectedImage = image;
        _resultImage = null; // Reset result when new image is picked
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void imageSelectEnhancement(String enhancement) {
    _selectedEnhancement = enhancement;
    notifyListeners();
  }

  void clearImage() {
    _selectedImage = null;
    _resultImage = null;
    _selectedEnhancement = null;
    notifyListeners();
  }

  // Mock processing for UI testing
  Future<void> processImage() async {
    if (_selectedImage == null) return;

    _isProcessing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3)); // Simulate network call

    // For now, we just pretend the result is the same as input
    _resultImage = _selectedImage;
    _isProcessing = false;
    notifyListeners();
  }
}
