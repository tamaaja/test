import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabularapp/controller/controller.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Iris Flower Prediction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input untuk feature pertama (sepal length)
            TextField(
              decoration: InputDecoration(labelText: 'Sepal Length'),
              controller: predictionProvider.sepalLengthController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(0, double.tryParse(value) ?? 0.0);
              },
            ),
            // Input untuk feature kedua (sepal width)
            TextField(
              decoration: InputDecoration(labelText: 'Sepal Width'),
              controller: predictionProvider.sepalWidthController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(1, double.tryParse(value) ?? 0.0);
              },
            ),
            // Input untuk feature ketiga (petal length)
            TextField(
              decoration: InputDecoration(labelText: 'Petal Length'),
              controller: predictionProvider.petalLengthController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(2, double.tryParse(value) ?? 0.0);
              },
            ),
            // Input untuk feature keempat (petal width)
            TextField(
              decoration: InputDecoration(labelText: 'Petal Width'),
              controller: predictionProvider.petalWidthController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(3, double.tryParse(value) ?? 0.0);
              },
            ),
            SizedBox(height: 20),
            // Tombol untuk mengirim prediksi
            ElevatedButton(
              onPressed: () async {
                await predictionProvider.predict();
                
              },
              child: Text('Predict'),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil prediksi
            if (predictionProvider.predictionMessage != null)
              Text(
                'Prediction: ${predictionProvider.predictionMessage}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
