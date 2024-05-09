import 'dart:io';

import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:articles_app/core/utils/pick_image.dart';
import 'package:articles_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddBlog());
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
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
            onPressed: () {},
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
                                    .copyWith(fontWeight: FontWeight.bold),
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
                  children:
                      ["Technology", "Business", "Programming", "Entertainment"]
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
      ),
    );
  }
}
