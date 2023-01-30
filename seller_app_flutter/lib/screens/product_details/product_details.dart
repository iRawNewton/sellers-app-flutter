import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'pd_widgets/image_picket.dart';
import 'pd_widgets/widgets.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  File? pickedImage;
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Product Details',
            style: GoogleFonts.poppins(fontSize: 22),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            pdtextField(text: 'Product Name', lines: 1),
            const SizedBox(height: 20),
            pdtextField(text: 'Product Short Description', lines: 2),
            const SizedBox(height: 20),
            pdtextField(text: 'Product Long Description', lines: 5),
            const SizedBox(height: 20),
            pdtextField(
                text: 'Selling Price',
                lines: 1,
                keyboard: TextInputType.number),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: imagePickerOption,
                      child: const Text('Upload image 1'),
                    )
                  ],
                ),
                Column(
                  children: [
                    pickedImage != null
                        ? Image.file(pickedImage!)
                        : Image.network('https://www.pexels.com'),
                  ],
                ),
              ]),
            ),
            Text(pickedImage.toString()),
            ElevatedButton(
              onPressed: imagePickerOption,
              child: const Text('click'),
            )
          ]),
        ),
      ),
    );
  }
}
