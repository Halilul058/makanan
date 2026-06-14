import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/food_service.dart';

class AddFoodScreen extends StatefulWidget {

  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState()
  => _AddFoodScreenState();
}

class _AddFoodScreenState
    extends State<AddFoodScreen> {

  final nameController =
  TextEditingController();

  final priceController =
  TextEditingController();

  final stockController =
  TextEditingController();

  final descController =
  TextEditingController();

  File? imageFile;

  final FoodService foodService =
  FoodService();

  Future pickImage() async {

    final picker = ImagePicker();

    final image =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {
        imageFile =
            File(image.path);
      });
    }
  }

  Future saveFood() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        stockController.text.isEmpty ||
        descController.text.isEmpty ||
        imageFile == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Semua data wajib diisi",
          ),
        ),
      );

      return;
    }

    await foodService.addFood(
      {
        'name':
        nameController.text,

        'price':
        int.parse(
            priceController.text),

        'description':
        descController.text,

        'image':
        imageFile?.path ?? '',

        'stock':
        int.parse(
            stockController.text),
      },
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Tambah Menu",
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
                  border: Border.all(),
                ),

                child: imageFile == null
                    ? const Icon(
                  Icons.add_a_photo,
                  size: 60,
                )
                    : ClipRRect(
                  borderRadius:
                  BorderRadius.circular(
                      20),
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
              nameController,
              decoration:
              const InputDecoration(
                hintText:
                "Nama Menu",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              priceController,
              keyboardType:
              TextInputType.number,
              decoration:
              const InputDecoration(
                hintText:
                "Harga",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              stockController,
              keyboardType:
              TextInputType.number,
              decoration:
              const InputDecoration(
                hintText:
                "Stok",
              ),
            ),

            const SizedBox(height: 15),

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

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed:
              saveFood,
              child:
              const Text(
                "Simpan",
              ),
            ),
          ],
        ),
      ),
    );
  }
}