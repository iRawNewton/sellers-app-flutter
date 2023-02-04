import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app_flutter/screens/test/screen1.dart';
import 'package:seller_app_flutter/screens/test/screen2.dart';
import 'pd_widgets/image_picket.dart';
import 'pd_widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  final _productName = TextEditingController();
  final _productSDesc = TextEditingController();
  final _productLDesc = TextEditingController();
  final _productRPrice = TextEditingController();
  final _productMPrice = TextEditingController();
  final _productSPrice = TextEditingController();
  final String _productImagePath = "";

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

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  // ****
  final Map<String, String> headerS = {
    "Content-Type": "application/json",
    "User-Agent": "PostmanRuntime/7.30.0",
    "Accept": "/",
    "Connection": "keep-alive",
  };

  // dynamic data;
  Future<void> saveProductDetails(
    productName,
    productSDesc,
    productLDesc,
    productRPrice,
    productMPrice,
    productSPrice,
    productImagePath,
    context,
  ) async {
    var statusUpdate = {
      'name': productName.toString(),
      'short_description': productSDesc.toString(),
      'description': productLDesc.toString(),
      'regular_price': productRPrice.toString(),
      'price': productMPrice.toString(),
      'sale_price': productSPrice.toString(),
      'images': [
        {'src': productImagePath.toString()}
      ],
    };
    String jsonStr = jsonEncode(statusUpdate);

    final response = await http.post(
        Uri.parse(
            'https://localmt.in/wp-json/wc/v3/products?consumer_key=ck_8993b48bcb9845cd440866c8ebe33677e852c84e&consumer_secret=cs_dd1ba4342a1516bf95b1e560773abe1dace409d9&per_page=100'),
        headers: headerS,
        body: jsonStr);

    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyTestOne()));
    } else {
      print(response.statusCode);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyTestTwo()));
    }
  }

  @override
  void dispose() {
    _productName.dispose();
    _productSDesc.dispose();
    _productLDesc.dispose();
    _productRPrice.dispose();
    _productMPrice.dispose();
    _productSPrice.dispose();
    super.dispose();
  }
  // ****

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
          child: SingleChildScrollView(
            child: Column(children: [
              // dropdown button
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // dropdown button

              TextField(
                controller: _productName,
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  fillColor: Colors.white38,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _productSDesc,
                keyboardType: TextInputType.text,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Product Short Description',
                  fillColor: Colors.white38,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _productLDesc,
                keyboardType: TextInputType.text,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Product Long Description',
                  fillColor: Colors.white38,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _productRPrice,
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Regular Price',
                  fillColor: Colors.white38,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _productMPrice,
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Market Price',
                  fillColor: Colors.white38,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _productSPrice,
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Selling Price',
                  fillColor: Colors.white38,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // **********************************************
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Column(children: [
                  // ***** image display
                  pickedImage != null
                      ? Text(pickedImage.toString())
                      : const Text('No image selected'),

                  // ***** image display
                  const Divider(color: Colors.black87),
                  ElevatedButton(
                    onPressed: imagePickerOption,
                    child: const Text('Upload Image'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {
                        saveProductDetails(
                            _productName,
                            _productSDesc,
                            _productLDesc,
                            _productRPrice,
                            _productMPrice,
                            _productSPrice,
                            _productImagePath,
                            context);
                      },
                      child: const Text('Upload Information'),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
