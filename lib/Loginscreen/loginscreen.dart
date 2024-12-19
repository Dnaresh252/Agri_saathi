import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Main LoginScreen Widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  // List of image URLs to use in the carousel
  final List<String> networkImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSAr7bzOiiufq6zwZi3sBWB-RwWicUvK6eSQ&s',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/250',
    'https://via.placeholder.com/300',
    'https://via.placeholder.com/350',
  ];

  @override
  void initState() {
    super.initState();
    // _startAutoScroll().cancel();
  }

  // Auto-scroll carousel logic
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < networkImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(
        children: [
          const SizedBox(height: 170),
          _buildHeader(),
          const SizedBox(height: 20),
          _buildCarousel(),
          const SizedBox(height: 20),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  /// Header UI
  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to",
            style: GoogleFonts.roboto(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Agrisaathi",
            style: GoogleFonts.roboto(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: const Color(0XFF3E2723),
            ),
          ),
        ],
      ),
    );
  }

  /// Carousel UI with network images
  Widget _buildCarousel() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: networkImages.length,
        itemBuilder: (context, index) {
          return _buildScrollingContent(index);
        },
      ),
    );
  }

  /// Each carousel page's UI with animated effects
  Widget _buildScrollingContent(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController.position.haveDimensions && _pageController.page != null) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
        }

        return Center(
          child: SizedBox(
            height: 180 * value, // Clamp scaling for smooth animations
            width: 180 * value,
            child: FittedBox(
              fit: BoxFit.contain,
              child: child,
            ),
          ),
        );
      },
      child: ScrollingContent(
        imagePath: networkImages[index],
        text: _getHeadline(index),
      ),
    );
  }

  /// Page indicator with smooth animations
  Widget _buildPageIndicator() {
    return Center(
      child: SmoothPageIndicator(
        controller: _pageController,
        count: networkImages.length,
        effect: ExpandingDotsEffect(
          dotWidth: 8,
          dotHeight: 8,
          expansionFactor: 3,
          spacing: 8,
          activeDotColor: Colors.yellow,
          dotColor: Colors.white,
        ),
      ),
    );
  }
}

// ScrollingContent widget for each carousel item
class ScrollingContent extends StatelessWidget {
  final String imagePath;
  final String text;

  const ScrollingContent({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imagePath,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// Method to fetch headlines for the carousel
String _getHeadline(int index) {
  const headlines = [
    'Rent Equipment Easily\nSave Time & Effort',
    'Affordable Rentals\nBoost Your Productivity',
    'Wide Range of Tools\nFor Every Need',
    'Sustainable Farming\nGrow More, Waste Less',
    'Connect with Farmers\nShare & Prosper Together',
  ];
  return headlines[index];
}