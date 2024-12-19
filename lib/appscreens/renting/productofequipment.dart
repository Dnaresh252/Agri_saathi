import 'package:flutter/material.dart';
import 'data.dart'; // Import the data file

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String? selectedEquipment; // To store the selected equipment type
  String? selectedModel; // To store the selected model
  List<String> models = []; // To store the models of the selected equipment type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Equipment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for Equipment Type
            const Text(
              "Select Equipment Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedEquipment,
              items: equipmentData.keys.map((String equipmentType) {
                return DropdownMenuItem<String>(
                  value: equipmentType,
                  child: Text(equipmentType),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedEquipment = value;
                  selectedModel = null; // Reset model selection
                  models = equipmentData[value!] ?? []; // Update model list
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              hint: const Text("Select Equipment"),
            ),
            const SizedBox(height: 20),

            // Dropdown for Equipment Models
            if (selectedEquipment != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Model",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedModel,
                    items: models.map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    hint: const Text("Select Model"),
                  ),
                ],
              ),

            const SizedBox(height: 30),

            // Show Selected Equipment and Model
            if (selectedEquipment != null && selectedModel != null)
              Center(
                child: Text(
                  "Selected: $selectedEquipment - $selectedModel",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
