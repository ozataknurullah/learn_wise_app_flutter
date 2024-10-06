import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_wise/viewmodels/camera_view_model.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cameraViewModel = Provider.of<CameraViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kamera ve Analiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cameraViewModel.cameraResult != null) ...[
              Image.file(
                File(cameraViewModel.cameraResult!.imagePath),
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: cameraViewModel.analyzePhoto,
                child: const Text("Analiz Et"),
              ),
            ] else ...[
              const Text("Henüz fotoğraf çekilmedi veya PDF yüklenmedi."),
            ],
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "cameraButton",
            onPressed: () => cameraViewModel.takePhoto(),
            child: const Icon(Icons.camera_alt),
            shape: const CircleBorder(), // Kamera butonunu yuvarlak yapar
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: "pdfButton",
            onPressed: () {
              // PDF yükleme işlevi buraya eklenecek
            },
            child: const Icon(Icons.picture_as_pdf),
            shape: const CircleBorder(), // PDF butonunu yuvarlak yapar
          ),
        ],
      ),
    );
  }
}
