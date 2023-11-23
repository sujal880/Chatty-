import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserField{
  static CustomTextField(String text,bool ToHide,TextEditingController controller){
    return Container(
      height: 45.h,
      width: 325.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.w),
          color: Colors.white.withOpacity(.9)
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 20.w,top: 3.h),
        child: TextField(
          controller: controller,
          obscureText: ToHide,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
              border: InputBorder.none
          ),
        ),
      ),
    );
  }
}