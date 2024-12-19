import 'dart:async';
import 'package:agri_saathi/appscreens/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  final List<String> texts = [
    'Rent Equipment Easily\nSave Time & Effort',
    'Affordable Rentals\nBoost Your Productivity',
    'Wide Range of Tools\nFor Every Need',
    'Sustainable Farming\nGrow More, Waste Less',
    'Connect with Farmers\nShare & Prosper Together',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < texts.length - 1) {
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

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in.
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomBottomNavigation()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(
        children: [
          const SizedBox(height: 120),  // Reduced the height here
          _buildHeader(),
          const SizedBox(height: 150),  // Reduced space
          _buildCarousel(),
          const SizedBox(height: 0),  // Reduced space
          _buildPageIndicator(),
          const SizedBox(height: 150), // Reduced space
          _buildHeadlineSection(),
          const SizedBox(height: 10),  // Reduced space
          _buildGoogleSignInButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to",
            style: GoogleFonts.roboto(
              fontSize: 16,  // Reduced font size for compact look
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "Agrisaathi",
            style: GoogleFonts.roboto(
              fontSize: 16,  // Reduced font size for compact look
              fontWeight: FontWeight.bold,
              color: const Color(0XFF3E2723),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,  // Reduced height
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return _buildScrollingContent(index);
        },
      ),
    );
  }

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
          child: Transform.scale(
            scale: value,
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );
      },
      child: _buildAnimatedText(index),
    );
  }

  Widget _buildAnimatedText(int index) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Text(
        texts[index],
        key: ValueKey<int>(index),
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 22 + (_currentPage == index ? 4 : 0),  // Smaller text and slight focus effect
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Center(
      child: SmoothPageIndicator(
        controller: _pageController,
        count: texts.length,
        effect: ExpandingDotsEffect(
          dotWidth: 6,  // Smaller dot size
          dotHeight: 6,
          expansionFactor: 2,  // Adjusted for smaller effect
          spacing: 6,
          activeDotColor: Colors.yellow,
          dotColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeadlineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Start Your Farming Journey Today!",
          style: GoogleFonts.roboto(
            fontSize: 18,  // Reduced font size
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 5),  // Reduced space
        Text(
          "Sign in to access tools, resources, and more.",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 14,  // Reduced font size for better compactness
            fontWeight: FontWeight.w800,
            color: const Color(0XFF3E2723),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _signInWithGoogle,
      child: Container(
        height: screenHeight * 0.045,
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/google-icon-logo-svgrepo-com.svg',
              height: 18,  // Smaller icon size
              width: 18,
            ),
            const SizedBox(width: 10),
            Text(
              "Sign in with Google",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
