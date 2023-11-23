import 'dart:io';

import 'package:chatty/routes/app_const.dart';
import 'package:chatty/screens/widgets/uihelper.dart';
import 'package:chatty/user_profile/user_profile_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController statusController=TextEditingController();
  File? pickedImage;
  auth(String name,String status)async{
    if(name=="" && status==""){
      return UiHelper.CustomSnackBar("Enter Required Field's", context);
    }
    else{
      uploadImage();
    }
  }

  openAlert() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.grey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show Us Your Smile 😊",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(.4)),
                          child: Image.network(
                              "https://cdn.iconscout.com/icon/free/png-256/free-camera-1831-475002.png")),
                    ),
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(.4)),
                          child: Image.network(
                              "https://cdn.icon-icons.com/icons2/2440/PNG/512/gallery_icon_148533.png")),
                    )
                  ],
                )
              ],
            ),
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))));
  }

  uploadImage() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("Users Images")
        .child(FirebaseAuth.instance.currentUser!.email.toString())
        .putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String img = await taskSnapshot.ref.getDownloadURL();
    String name=nameController.text.toString();
    String status=statusController.text.toString();

    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.email).set({
      "Email":FirebaseAuth.instance.currentUser!.email,
      "Images":img,
      "Name":name,
      "Status":status,
      "uid":FirebaseAuth.instance.currentUser!.uid
    }).then((value){
      Navigator.pushNamedAndRemoveUntil(context, PageConst.homescreen, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Card(
                elevation: 14.w,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70.w)),
                child: GestureDetector(
                  onTap: () {
                    openAlert();
                  },
                  child: pickedImage != null
                      ? Container(
                          clipBehavior: Clip.antiAlias,
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.file(pickedImage!, fit: BoxFit.cover),
                        )
                      : Container(
                    height: 150.h,
                          width: 150.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.9),
                              borderRadius: BorderRadius.circular(12)),
                          child: Image.network(
                              "https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352156-stock-illustration-default-placeholder-profile-icon.jpg",fit: BoxFit.cover,),
                        ),
                ),
              ),
              Positioned(
                right: 0.w,
                bottom: 0.h,
                child: CircleAvatar(
                  radius: 20.w,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
            SizedBox(height: 30.h),
            UserField.CustomTextField("Username", false, nameController),
            SizedBox(
              height: 20.h,
            ),
           UserField.CustomTextField("Status", false, statusController),
            SizedBox(
              height: 20.h,
            ),
            UiHelper.CustomButton(() {
              auth(nameController.text.toString(), statusController.text.toString());
            }, "Let's Go")
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      return UiHelper.CustomSnackBar(ex.toString(), context);
    }
  }
}
