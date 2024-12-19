import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({super.key});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_8xB9u3Fg0HvPxY23zCzu0P5dL_g-DUtxeA&s',
    'https://assets.tractorjunction.com/tractor-junction/assets/images/upload/standard-460-4wd.webp?format=webp&width=347&height=205',
    'https://5.imimg.com/data5/BK/IG/MY-47194523/standard-335.jpg',
  ];
  int _currentPage = 0;

  // Function to initiate a phone call
  Future<void> _makePhoneCall() async {
    const phoneNumber = 'tel:+1234567890';  // Replace with a real phone number
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not make phone call';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            size: 24,
            color: Colors.black,
          ),
        ),
        leadingWidth: 50,
        title: Text(
          "Detailed Page",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap:(){}, // Call function when tapped
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image carousel section
            AspectRatio(
              aspectRatio: 15 / 10,
              child: PageView.builder(
                itemCount: imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        width: 300, // Set a specific width
                        height: 200, // Set a specific height
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image, size: 50),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current page number
                  Center(
                    child: Text(
                      "Image ${_currentPage + 1}/${imageUrls.length}",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  Text("Sonalika DI 745 III RX ",style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black
                  ),),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Text("Rent Price: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("200/hour or 3000/day",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Availabilty: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("Available",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Owner Name: ",style: GoogleFonts.roboto(
        
                        fontSize: 18,
                        fontWeight: FontWeight.w800
                      ),),
                      Text("Dantina Yugandhar Naresh",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Contact Number: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("7846940140",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ), SizedBox(height: 10),
        
                  Row(
                    children: [
                      Text("Address: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("Mehen,Dist- Bargarh , Odisha, 768115",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
        
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Delivery: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("Delivery Available",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Condition: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("Good",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Hour used: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("300 Hour",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Rating: ",style: GoogleFonts.roboto(
        
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                      ),),
                      Text("⭐ 4.5 (20)",style: GoogleFonts.roboto(
        
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),)
                    ],
                  ),
        
        
        
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFF9F5E8),
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),            ]
          ),
          child: Row(
            children: [
              SizedBox(width: 5,),
              Container(

                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(136, 194, 115,1)
                ),
                child: Center(
                  child: Text("RENT NOW",style: GoogleFonts.roboto(color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              SizedBox(width: 2,),
              Container(

                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(136, 194, 115,1)
                ),
                child: Center(
                  child: Text("ADD TO CART",style: GoogleFonts.roboto(color: Colors.white,
                  fontSize: 15,
                    fontWeight: FontWeight.bold

                  ),),
                ),
              )


            ],
          ),
        ),
      )
    );
  }
}
