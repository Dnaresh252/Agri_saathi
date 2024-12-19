import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5E8),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_rounded),
        title: Text(
          "Manage Your Equipment",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 8, // Number of equipment items
          itemBuilder: (context, index) {
            return EquipmentContainer(
              equipmentName: "Tractor Model $index",
              equipmentType: "Type: Harvester",
              imagePath:
              "https://5.imimg.com/data5/WC/IE/YH/ANDROID-86040604/prod-20200810-2031297210080910753376724-jpg-500x500.jpg",
            );
          },
        ),
      ),
    );
  }
}

class EquipmentContainer extends StatefulWidget {
  final String equipmentName;
  final String equipmentType;
  final String imagePath;

  const EquipmentContainer({
    super.key,
    required this.equipmentName,
    required this.equipmentType,
    required this.imagePath,
  });

  @override
  State<EquipmentContainer> createState() => _EquipmentContainerState();
}

class _EquipmentContainerState extends State<EquipmentContainer> {
  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Equipment Image
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Equipment Details and Buttons
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.equipmentName,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.equipmentType,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),

                // Availability Buttons
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isAvailable = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isAvailable ? Colors.green : Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              "Available",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: isAvailable ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isAvailable = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: !isAvailable ? Colors.red : Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              "Not Available",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: !isAvailable ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
