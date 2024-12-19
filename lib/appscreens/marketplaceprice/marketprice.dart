import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product.dart'; // Import the product.dart file to access the products list

class Marketprice extends StatefulWidget {
  const Marketprice({super.key});

  @override
  State<Marketprice> createState() => _MarketpriceState();
}

class _MarketpriceState extends State<Marketprice> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        // If we're at the end, loop back to the start
        if (currentScroll >= maxScroll) {
          // Keep scrolling from the first item to create a loop effect
          _scrollController.jumpTo(0); // This will bring us back to the start immediately
          _scrollController.animateTo(
            250.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            currentScroll + 250.0, // Move the scroll position by 250 pixels
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with "Today's Market Prices" and "See All" button
          Row(
            children: [
              Text(
                "Today's Market Prices",
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

          // ListView.builder for displaying products horizontally
          SizedBox(
            height: 120, // Adjust the height for the ListView
            child: ListView.builder(
              //controller: _scrollController, // Add the scroll controller
              scrollDirection: Axis.horizontal, // Horizontal scroll
              itemCount: products.length, // Use the length of the products list
              itemBuilder: (context, index) {
                final product = products[index]; // Access each product in the list
                return MarketPriceWidget(
                  productName: product.name,
                  forecast: product.forecast,
                  price: product.price,
                  change: product.change,
                  isTrendingUp: product.isTrendingUp,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MarketPriceWidget extends StatelessWidget {
  final String productName;
  final String forecast;
  final double price;
  final double change;
  final bool isTrendingUp;

  const MarketPriceWidget({
    Key? key,
    required this.productName,
    required this.forecast,
    required this.price,
    required this.change,
    required this.isTrendingUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
          width: 250, // Control the width of each item
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/agriculture-paddy-svgrepo-com.svg',
                height: 100,
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "2024/25 Forecast",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        price.toString(),
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      SizedBox(width: 2,),
                      Icon(
                        isTrendingUp
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down,
                        size: 40,
                        color: isTrendingUp ? Colors.green : Colors.red,
                      ),
                      Text(
                        change.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: isTrendingUp ? Colors.green : Colors.red,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
