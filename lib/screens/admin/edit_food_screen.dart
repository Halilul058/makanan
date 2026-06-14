import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/food_service.dart';

class EditFoodScreen extends StatefulWidget {
  final Map<String, dynamic> food;

  const EditFoodScreen({
    super.key,
    required this.food,
  });

  @override
  State<EditFoodScreen> createState() =>
      _EditFoodScreenState();
}

class _EditFoodScreenState
    extends State<EditFoodScreen> {

  final FoodService service =
  FoodService();

  late TextEditingController
  nameController;

  late TextEditingController
  priceController;

  late TextEditingController
  stockController;

  late TextEditingController
  descController;

  File? imageFile;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
          text: widget.food['name'],
        );

    priceController =
        TextEditingController(
          text:
          widget.food['price'].toString(),
        );

    stockController =
        TextEditingController(
          text:
          widget.food['stock'].toString(),
        );

    descController =
        TextEditingController(
          text:
          widget.food['description'],
        );

    if (widget.food['image'] != null &&
        widget.food['image'] != '') {
      imageFile =
          File(widget.food['image']);
    }
  }

  Future<void> pickImage() async {
    final image =
    await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        imageFile =
            File(image.path);
      });
    }
  }

  Future<void> updateFood() async {

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        stockController.text.isEmpty ||
        descController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Semua data wajib diisi',
          ),
        ),
      );

      return;
    }

    await service.updateFood({
      'id': widget.food['id'],
      'name': nameController.text,
      'price': int.parse(
          priceController.text),
      'description':
      descController.text,
      'image':
      imageFile?.path ?? '',
      'stock': int.parse(
          stockController.text),
    });

    if (!mounted) return;

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Menu",
        ),
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [

            GestureDetector(
              onTap: pickImage,

              child: Container(
                height: 180,
                width: double.infinity,

                decoration:
                BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      20),
                  border:
                  Border.all(),
                ),

                child: imageFile == null
                    ? const Icon(
                  Icons
                      .add_a_photo,
                  size: 60,
                )
                    : ClipRRect(
                  borderRadius:
                  BorderRadius
                      .circular(
                      20),
                  child:
                  Image.file(
                    imageFile!,
                    fit: BoxFit
                        .cover,
                  ),
                ),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(
              controller:
              nameController,
              decoration:
              const InputDecoration(
                hintText:
                "Nama Menu",
              ),
            ),

            const SizedBox(
                height: 15),

            TextField(
              controller:
              priceController,
              keyboardType:
              TextInputType
                  .number,
              decoration:
              const InputDecoration(
                hintText:
                "Harga",
              ),
            ),

            const SizedBox(
                height: 15),

            TextField(
              controller:
              stockController,
              keyboardType:
              TextInputType
                  .number,
              decoration:
              const InputDecoration(
                hintText:
                "Stok",
              ),
            ),

            const SizedBox(
                height: 15),

            TextField(
              controller:
              descController,
              maxLines: 3,
              decoration:
              const InputDecoration(
                hintText:
                "Deskripsi",
              ),
            ),

            const SizedBox(
                height: 20),

            ElevatedButton(
              onPressed:
              updateFood,
              child: const Text(
                "Update",
              ),
            ),
          ],
        ),
      ),
    );
  }
}