import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  List<String> selectedTopics = [];

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ))),
                  )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                          dashPattern: [10, 4],
                          radius: Radius.circular(10),
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          color: AppPallete.borderColor,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Select Your Image",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                    ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map((elements) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(elements)) {
                                  selectedTopics.remove(elements);
                                } else {
                                  selectedTopics.add(elements);
                                }
                                print(selectedTopics);

                                setState(() {});
                              },
                              child: Chip(
                                color: selectedTopics.contains(elements)
                                    ? WidgetStatePropertyAll(
                                        AppPallete.gradient1)
                                    : null,
                                label: Text(elements),
                                side: selectedTopics.contains(elements)
                                    ? null
                                    : BorderSide(color: AppPallete.borderColor),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              BlogEditor(controller: titleController, hintText: 'Blog Title'),
              SizedBox(
                height: 20,
              ),
              BlogEditor(
                  controller: contentController, hintText: 'Blog Content')
            ],
          ),
        ),
      ),
    );
  }
}
