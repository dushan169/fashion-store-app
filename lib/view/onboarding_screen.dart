import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'signin_screen.dart'; 

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0; 

  final List<OnboardingItem> _items = [
    OnboardingItem(
      description: 'Explore the newest fashion trends and find your unique style', 
      title: 'Discover Latest Trends', 
      image: 'assets/images/intro.png',
    ), 

    OnboardingItem(
      description: 'Shop for the latest fashion items at unbeatable prices', 
      title: 'Shop with Confidence', 
      image: 'assets/images/intro1.png',
    ),

    OnboardingItem(
      description: 'Get exclusive access to sales and special offers', 
      title: 'Exclusive Deals', 
      image: 'assets/images/intro2.png',
    ),     
  ];

  //handle get started button pressed
  void _handleGetStarted(){
    final authController = Get.find<AuthController>();
    authController.setFirstTimeDone();
    Get.offAll(() => SigninScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index){
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _items[index].image, 
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _items[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.withColour(AppTextStyle.h2, Theme.of(context).textTheme.bodyLarge!.color!
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _items[index].description,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.withColour(
                        AppTextStyle.bodyLarge,
                        isDark?Colors.grey[400]!:Colors.grey[600]!,
                        ),
                    ),
                  )
                ],
              );

            },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Theme.of(context).primaryColor : (isDark ? Colors.grey[700] : Colors.grey[300]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),),
            Positioned(
              bottom:16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _handleGetStarted(), 
                    child: Text(
                      "Skip",
                      style: AppTextStyle.withColour(AppTextStyle.buttonMedium, 
                      isDark ? Colors.grey[400]! : Colors.grey[600]!),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(_currentPage < _items.length - 1){
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300), 
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _handleGetStarted();// Navigate to home screen or main app
                      }
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryIconTheme.color,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(_currentPage == _items.length - 1 ? "Get Started" : "Next",
                    style: AppTextStyle.withColour(AppTextStyle.buttonMedium,
                     Color(0xFFD4AF37)),),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
      
  }
}

class OnboardingItem{
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.description,
    required this.title,
    required this.image,
  });

}
