import 'dart:io';

import 'package:articles_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:articles_app/core/common/widgets/loader.dart';
import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:articles_app/core/utils/pick_image.dart';
import 'package:articles_app/core/utils/snackbar.dart';
import 'package:articles_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:articles_app/features/blog/presentation/pages/blog_page.dart';
import 'package:articles_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddBlog());
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedChips = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void upload_blog() {
    if (formKey.currentState!.validate() &&
        selectedChips.length >= 1 &&
        image != null) {
      final userId =
          (BlocProvider.of<AppUserCubit>(context).state as AppUserLoggedIn)
              .user
              .id;
      BlocProvider.of<BlogBloc>(context).add(BlogUpload(
          userid: userId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: image!,
          topics: selectedChips));
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Blog"),
        actions: [
          IconButton(
            onPressed: upload_blog,
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
            if (state is BlogSuccess) {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is Blogloading) {
              return Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image == null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              radius: Radius.circular(10),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              dashPattern: [10, 4],
                              strokeWidth: 2,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select an Image",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Technology",
                          "Business",
                          "Programming",
                          "Entertainment"
                        ]
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    if (selectedChips.contains(e)) {
                                      selectedChips.remove(e);
                                    } else {
                                      selectedChips.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Chip(
                                      color: selectedChips.contains(e)
                                          ? MaterialStatePropertyAll(
                                              LightTheme.brandingColor)
                                          : null,
                                      label: Text(e),
                                      side: selectedChips.contains(e)
                                          ? null
                                          : BorderSide(
                                              color: LightTheme.primaryColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                      fieldController: titleController,
                      hintText: "Blog Title",
                      isExpand: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                      fieldController: contentController,
                      hintText: "Blog Content",
                      isExpand: true,
                    ),
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
