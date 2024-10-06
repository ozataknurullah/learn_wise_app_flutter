import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_wise/data/models/camera_result.dart';

class CameraViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  CameraResult? _cameraResult;

  CameraResult? get cameraResult => _cameraResult;

  Future<void> takePhoto() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _cameraResult = CameraResult(imagePath: pickedFile.path);
        notifyListeners(); // View'ı güncellemek için kullanılır
      }
    } catch (e) {
      print("Fotoğraf çekme hatası: $e");
    }
  }

  Future<void> analyzePhoto() async {
    // Analiz işlemleri burada yapılacak (backend entegrasyonu veya lokal analiz)
    if (_cameraResult != null) {
      _cameraResult = CameraResult(
        imagePath: _cameraResult!.imagePath,
        analysisResult:
            "Analiz tamamlandı. (Örnek metin)", // Burada gerçek analiz yapılabilir
      );
      notifyListeners();
    }
  }

  void reset() {
    _cameraResult = null;
    notifyListeners();
  }
}
