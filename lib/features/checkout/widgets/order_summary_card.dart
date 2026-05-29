import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;


    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark?
            Colors.black.withOpacity(0.2)
            :Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            context,
            'Subtotal',
            'LKR 20, 575'
          ),
          const SizedBox(height: 8,),
            _buildSummaryRow(
            context,
            'Shipping',
            'LKR 1000.00'
          ),
          const SizedBox(height: 8,),
            _buildSummaryRow(
            context,
            'Tax',
            'LKR 5000.00'
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
           _buildSummaryRow(
            context,
            'Tax',
            'LKR 26575.00'
          ),
        ],
      ),
    );
  }
  Widget _buildSummaryRow(BuildContext context, String label, String Value,{bool isTotal = false}){
    final textStyle = isTotal ? AppTextStyle.h3:AppTextStyle.bodyLarge;
    final color = isTotal ?
    Theme.of(context).primaryColor:
    Theme.of(context).textTheme.bodyLarge!.color!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.withColour(textStyle, color),
        ),
        Text(
          label,
          style: AppTextStyle.withColour(textStyle, color),
        ),
        Text(
          Value,
          style: AppTextStyle.withColour(textStyle, color),
        ),
      ],
    );
  }
}