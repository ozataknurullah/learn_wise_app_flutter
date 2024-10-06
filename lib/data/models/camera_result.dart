class CameraResult {
  final String imagePath;
  final String? analysisResult;

  CameraResult({required this.imagePath, this.analysisResult});

  // Örnek bir JSON dönüşümü (gelecekte backend ile veri alışverişi için kullanılabilir)
  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'analysisResult': analysisResult,
    };
  }
}
