import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlace();
}

class _AddPlace extends ConsumerState<AddPlace> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final File selectedImage;
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savedata() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(userPlacesProvider.notifier)
          .addPlace(_titleController.text, selectedImage);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add new Place"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Name")),
                    controller: _titleController,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please Add Title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ImageInput(
                    pickedImage: (image) {
                      selectedImage = image;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                      onPressed: _savedata,
                      icon: const Icon(Icons.add),
                      label: const Text("Add Place"))
                ],
              )),
        ));
  }
}
