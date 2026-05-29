import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class QuestionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const QuestionCard({
    super.key, 
    required this.title, 
    required this.icon,});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ?
            Colors.black.withOpacity(0.2)
            :Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
        color:Theme.of(context).primaryColor
        ),
        title: Text(
          title,
          style: AppTextStyle.withColour(
            AppTextStyle.bodyMedium, 
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        size: 16,
        ),
        onTap: () => _showAnswerBottomSheet(context, title, isDark  ),
      ),
    );
  }
  void _showAnswerBottomSheet(BuildContext context, String question, bool isDark){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(
                  question,
                  style: AppTextStyle.withColour(
                    AppTextStyle.h3, 
                    Theme.of(context).textTheme.bodyLarge!.color!
                  ),
                ),
                ),
                IconButton(
                  onPressed: ()=>  Get.back(),
                  icon: Icon(Icons.close,
                  color: isDark? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _getAnswer(question),
              style: AppTextStyle.withColour(
                AppTextStyle.bodySmall, 
               isDark ? Colors.grey[400]!:Colors.grey[600]!,
              ),
            ),
            SizedBox(height: 24,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ), 
                child: Text(
                  'Got It',
                  style:AppTextStyle.withColour(
                    AppTextStyle.buttonMedium, 
                    Colors.white)),),
            )
          ],
        ) ,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  String _getAnswer(String question){
    final answers =  {
        'How to track my order?' : 'To track your order:\n\n'
        '1. Go to "My orders" in your account\n'
        '2. Select the order you want to track\n'
        '3. click on "Track  Order" \n'
        '4. You\'ll see real time updatesw\n'
    };

    return answers[question] ?? 'information not available.please contact support for assistance';
  }
}