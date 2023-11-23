import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiHelper{
  static CustomTextField(String text,bool ToHide,void Function(String value)? func){
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
          onChanged: (value)=>func!(value),
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

  static CustomButton(VoidCallback callback,String text){
    return GestureDetector(
      onTap: (){
        callback();
      },
      child: Container(
        height: 50.h,
        width: 325.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.w),
          color: Colors.black
        ),
        child: Center(child: Text(text,style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    );
  }

  static CustomSnackBar(String text, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 12.sp, color: Colors.white),
      ),
      backgroundColor: Colors.black,
    ));
  }
}