import 'package:fashion_store_app/features/edit%20Profile/views/widgets/profile_form.dart';
import 'package:fashion_store_app/features/edit%20Profile/views/widgets/profile_image.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: ()=> Get.back(), 
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          ),
        title:Text('Edit Profile',
        style: AppTextStyle.withColour(
          AppTextStyle.h3, 
          Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24,),
            ProfileImage(),
            SizedBox(height: 32,),
            ProfileForm(),
          ],
        ),
      ),
    );

  }
}