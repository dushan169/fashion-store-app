import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class ContactSupportSection extends StatelessWidget {
  const ContactSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return Container(
      margin: const EdgeInsets.all(16),

padding: const EdgeInsets.all(24),

width: double.infinity,

decoration: BoxDecoration(

color: Theme.of(context).primaryColor.withOpacity(0.1),

borderRadius: BorderRadius.circular(16),

), // BoxDecoration

child: Column(

children: [

Icon(

Icons.headset_mic_outlined,

color: Theme.of(context).primaryColor,

size: 48,

),
      const SizedBox(height: 16,),
      Text(
        'Still need help',
       style: AppTextStyle.withColour(
                  AppTextStyle.h3,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
      ),
      const SizedBox(height: 8,),
      Text(
        'Contct our Support team',
       style: AppTextStyle.withColour(
                  AppTextStyle.bodyMedium,
                  Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
      ),
       const SizedBox(height: 16),
       ElevatedButton(
        onPressed: (){}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )
        ),
        child: Text(
          'Contact Support',
          style: AppTextStyle.withColour(
                  AppTextStyle.buttonMedium,
                  Colors.white,
                ),

        ))
],
 ), //
    );
  }
}