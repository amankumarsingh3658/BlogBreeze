import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:blog_app/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final formkey = GlobalKey<FormState>();

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

  void uploadBlog() {
    if (formkey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(BlogUpload(
          image: image!,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          posterId: posterId,
          topics: selectedTopics));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: Icon(Icons.done_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            } else if (state is BlogUploadSuccess) {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: formkey,
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
                                          : BorderSide(
                                              color: AppPallete.borderColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    BlogEditor(
                        controller: titleController, hintText: 'Blog Title'),
                    SizedBox(
                      height: 20,
                    ),
                    BlogEditor(
                        controller: contentController, hintText: 'Blog Content')
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
