import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/view/main_screen.dart';
import 'package:fashion_store_app/view/onboarding_screen.dart';
import 'package:fashion_store_app/view/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget{
  SplashScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    //navigate based on auth status after 3 seconds
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (authController.isFirstTime.value) {
        Get.off(()=> const OnboardingScreen());
      } else if (authController.isLoggedIn.value) {
        Get.off(()=> const MainScreen());
      }else{
        Get.off(()=> SigninScreen());  
      }
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF000000),
              const Color.fromARGB(255, 0, 0, 0),
              const Color.fromARGB(255, 0, 0, 0),
            ]
          ),
        ),
        child:Stack(
          children: [
            //background patterns
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
              child: GridPattern(
                color: Colors.white,
              ),  
            ) ),

           //main content
           Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //animated logo container
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0), 
                  duration: const Duration(milliseconds: 1200 ), 
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20 ,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        ),
                      child:Image.asset(
                        "assets/images/veritas_logo.png",
                        width: 250,
                        height: 250,
                      ),
                      ),
                    );
                  },
                  ),
                  const SizedBox(height: 32 ),

                  //animated text
                  TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0), 
                  duration: const Duration(milliseconds: 1200 ), 
                  builder: (context, value, child) {
                    return Opacity(opacity: value,
                    child: Transform.translate(
                      offset:Offset(0, 20 * (1-value)),
                      child: child,
                    ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        "VERITAS",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFFD4AF37),
                          letterSpacing: 8,
                        ),
                      ),
                    ],
                  ),
                  ),
                 
                ],
              ),
           ) ,
            //bottom tagline
                  Positioned(
                    bottom: 48,
                    left: 0,
                    right: 0,
                    child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0), 
                    duration: const Duration(milliseconds: 1200 ), 
                    builder: (context, value, child) {
                    return Opacity(opacity: value,
                    child: child,
                    );
                  },
                  child: Text(
                    "Your Trusted Shopping Companion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFFD4AF37),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  ),
                  ),  
          ],
        )
      ),
    );
  }
} 

class GridPattern extends StatelessWidget{
  final Color color;
  const GridPattern({ 
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(color: color),
    );//CustomPaint
  }
}

class GridPainter extends CustomPainter{
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = color
    ..strokeWidth = 0.5;

    final spacing = 20.0;

    for(var i = 0.0; i < size.width; i += spacing){
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for(var i = 0.0; i < size.height; i += spacing){
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
