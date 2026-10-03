import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class MaterialsPageRoute {}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleConrtrolller = TextEditingController();
  final contentConrtrolller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleConrtrolller.dispose();
    contentConrtrolller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: AppPallete.borderColor,
                  dashPattern: [10, 4],
                  radius: Radius.circular(10),
                  strokeWidth: 1,
                  strokeCap: StrokeCap.round,
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_open, size: 40),
                      SizedBox(height: 15),
                      Text('Select you image', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['AI', 'Programming', 'Business', 'Entertainment']
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            label: Text(e),
                            side: BorderSide(color: AppPallete.borderColor),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 10),
              BlogEditor(controller: titleConrtrolller, hintText: 'Blog title'),
              SizedBox(height: 10),
              BlogEditor(
                controller: contentConrtrolller,
                hintText: 'Blog Content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
