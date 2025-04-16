import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagesNotesController extends ChangeNotifier {
  TextEditingController notesController = TextEditingController();
  String? _imagePath;
  bool _isImageLoading = false;

  String? get imagePath => _imagePath;
  bool get isImageLoading => _isImageLoading;

  void initializeNotes(String? initialText) {
    notesController = TextEditingController(text: initialText ?? '');
  }



void setImagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }
  Future<void> pickImage(BuildContext context) async {
    try {
      _isImageLoading = true;
      notifyListeners();
      
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    } finally {
      _isImageLoading = false;
      notifyListeners();
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    try {
      _isImageLoading = true;
      notifyListeners();
      
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take photo: ${e.toString()}')),
      );
    } finally {
      _isImageLoading = false;
      notifyListeners();
    }
  }

  void clearImage() {
    _imagePath = null;
    notifyListeners();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  void reset() {
  notesController.clear();
  _imagePath = null;
  _isImageLoading = false;
  notifyListeners();
}
}