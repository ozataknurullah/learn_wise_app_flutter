import 'package:flutter/material.dart';
import 'package:learn_wise/viewmodels/ai_asistant_model.dart';
import 'package:provider/provider.dart';

class AIAssistantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aiViewModel = Provider.of<AIAssistantViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              // Arama işlemi yapılabilir.
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kullanıcı Bilgisi ve Özet
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.person, size: 30, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Kullanıcı Adı",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "₹23,870",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Asistan Özeti Kartı
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: aiViewModel.summaryText == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircularProgressIndicator(
                                value: 0.59,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              ),
                              const SizedBox(width: 10),
                              Text("59%", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            aiViewModel.summaryText ?? "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
