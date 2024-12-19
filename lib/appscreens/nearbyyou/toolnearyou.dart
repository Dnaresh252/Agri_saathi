import 'package:agri_saathi/appscreens/Detailedpage/detailpage.dart';
import 'package:agri_saathi/appscreens/marketplaceprice/marketprice.dart';
import 'package:agri_saathi/appscreens/marketplaceprice/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Toolnearyou extends StatefulWidget {
  const Toolnearyou({super.key});

  @override
  State<Toolnearyou> createState() => _ToolnearyouState();
}

class _ToolnearyouState extends State<Toolnearyou> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      // Header Row with "Today's Market Prices" and "See All" button
      Row(
      children: [
      Text(
      "Tools Near You",
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      Spacer(),
      Container(
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "See all",
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ),
      ],
    ),
         toolwidget(),
          toolwidget(),
          toolwidget(),
      ],

    )
    );
  }
  Widget toolwidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: GestureDetector(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailpage()));
        },
        child: Container(
          width: 400,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image container
              Container(
                width: 170, // Adjust the width of the image container
                height: 150, // Adjust the height of the image container as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // To round the image corners
                  child: Image.network(
                    "https://www.deere.asia/assets/images/region-4/products/tractors/row-crop-tractors/row-crop-group/6family-rowcrop-r4b009242-1366.jpg",
                    fit: BoxFit.cover, // To ensure the image covers the entire container
                  ),
                ),
              ),
              SizedBox(width: 10),
        // Text information container (beside the image)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tractor Name with overflow handling
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 170, // You can adjust this value based on the available space
                      ),
                      child: const Text(
                        "Jhon Dear Tractor",  // Replace with the actual name
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,  // Ensures text doesn't overflow and adds "..."
                        maxLines: 2,  // Ensures the text stays in one line
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Price per hour: ",style: GoogleFonts.roboto(
                         fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),),
                        Text("2200",style: GoogleFonts.roboto(
                         fontWeight: FontWeight.w500,
                          color: Colors.green,
                            fontSize: 12
                        ),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Distance: ",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),),
                        Text("19km",style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                            fontSize: 12
                        ),)
                      ],
                    ),Row(
                      children: [
                        Text("Area: ",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),),
                        Text("Mehena",style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                            fontSize: 12
                        ),)
                      ],
                    ),

                    Row(
                      children: [
                        Text("Phone No: ",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),),
                        Text("7846940140",style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                            fontSize: 12
                        ),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rating: ",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),),
                        Text("⭐⭐⭐",style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.green
                            ,
                          fontSize: 12
                        ),)
                      ],
                    )

        ]
            )
            )

            ],
          ),
        ),
      ),
    );
  }

}

