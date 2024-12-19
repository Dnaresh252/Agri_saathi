import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  State<Rent> createState() => _RentState();
}

class _RentState extends State<Rent> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleNameController = TextEditingController();
  final _ageController = TextEditingController(); // Age of equipment
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _selectedImages = [];
  String? _condition; // Condition of equipment
  String? _fuelType; // Fuel/Energy type dropdown
  final _pricePerHourController = TextEditingController();
  final _pricePerDayController = TextEditingController();

  // Dropdown Data
  String? selectedEquipment;
  String? selectedModel;
  List<String> models = [];
  bool requiresVehicleName = false; // To determine if vehicle name is required

  Map<String, List<String>> equipmentData = {
    "Tractors": ["John Deere 5050D", "Mahindra 475 DI", "New Holland 3630"],
    "Harvesters": ["Kubota DC-68G-HK", "John Deere W70", "Mahindra Arjun 605"],
    "Ploughs": ["Disc Plough", "Mouldboard Plough", "Chisel Plough"],
    "Seeders": ["Pneumatic Seeder", "Mechanical Seeder", "Precision Seeder"],
  };

  // Method to pick images from the gallery
  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage();
    if (images != null) {
      if (images.length > 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You can only upload a maximum of 3 images.")),
        );
      } else {
        setState(() {
          _selectedImages = images;
        });
      }
    }
  }

  // Method to handle form submission
  void _submitListing() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImages == null || _selectedImages!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select at least one image.")),
        );
        return;
      }

      if (selectedEquipment == null || selectedModel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select equipment and model.")),
        );
        return;
      }

      // Proceed with backend submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Listing submitted successfully!")),
      );
      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _selectedImages = [];
        selectedEquipment = null;
        selectedModel = null;
        models = [];
        requiresVehicleName = false;
        _condition = null;
        _fuelType = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5E8),
      appBar: AppBar(
        title: Text("List Your Equipment",style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload Images
                Text(
                  "Upload Images",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedImages == null || _selectedImages!.isEmpty
                        ? Center(child: Text("Tap to upload images"))
                        : GridView.builder(
                      itemCount: _selectedImages!.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (context, index) {
                        return Image.file(
                          File(_selectedImages![index].path),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Equipment Type Dropdown
                Text(
                  "Select Equipment Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
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
                      selectedModel = null; // Reset the model selection
                      models = equipmentData[value!] ?? [];
                      requiresVehicleName =
                          value == "Tractors" || value == "Harvesters";
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  hint: Text("Select Equipment"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select equipment type.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Model Dropdown
                if (selectedEquipment != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Model",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
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
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        hint: Text("Select Model"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a model.";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 16),

                // Condition Dropdown
                Text(
                  "Condition of Equipment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _condition,
                  items: ["New", "Good", "Fair", "Needs Maintenance"]
                      .map((String condition) {
                    return DropdownMenuItem<String>(
                      value: condition,
                      child: Text(condition),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _condition = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  hint: Text("Select Condition"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a condition.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Fuel/Energy Type Dropdown
                Text(
                  "Fuel/Energy Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _fuelType,
                  items: ["Diesel", "Electric"].map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fuelType = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  hint: Text("Select Fuel/Energy Type"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a fuel/energy type.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Age of Equipment
                Text(
                  "Age of Equipment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Age of Equipment",
                    hintText: "Enter age in years",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the age of the equipment.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Price Per Hour and Price Per Day Side by Side
                Text(
                  "Pricing Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _pricePerHourController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Price Per Hour",
                          hintText: "Enter price",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _pricePerDayController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Price Per Day",
                          hintText: "Enter price",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap:_submitListing,
        child: Container(
          height: 60,
          color: Colors.green,
          child: Center(
            child: Text(
              'Proceed to Add Your Listing',
              style:GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
