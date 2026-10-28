
import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/auth/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/auth/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleConrtrolller = TextEditingController();
  final contentConrtrolller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> selectedTopics = [];
  File? image;
  bool isUploading = false;

  static const Color paper = Color(0xFFF7F3EB);
  static const Color ink = Color(0xFF292821);
  static const Color muted = Color(0xFF77736C);
  static const Color accent = Color(0xFFB65E45);

  Future<void> selectImage() async {
    final pickedImage = await pickImage();

    if (!mounted || pickedImage == null) return;

    setState(() {
      image = pickedImage;
    });
  }

  void uploadBlog() {
    if (isUploading) return;

    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) return;

    if (image == null) {
      showSnackBar(context, 'Please select a cover image.');
      return;
    }

    if (selectedTopics.isEmpty) {
      showSnackBar(context, 'Please select at least one topic.');
      return;
    }

    final userState = context.read<AppUserCubit>().state;

    if (userState is! AppUserLoggedIn) {
      showSnackBar(context, 'Please sign in before publishing.');
      return;
    }

    setState(() {
      isUploading = true;
    });

    context.read<BlogBloc>().add(
          BlogUpload(
            posterId: userState.user.id,
            title: titleConrtrolller.text.trim(),
            content: contentConrtrolller.text.trim(),
            topics: List<String>.from(selectedTopics),
            image: image!,
          ),
        );
  }

  @override
  void dispose() {
    titleConrtrolller.dispose();
    contentConrtrolller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paper,
      appBar: AppBar(
        backgroundColor: paper,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'New story',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 19,
          ),
        ),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            setState(() {
              isUploading = false;
            });
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(child: Loader());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create a story',
                        style: TextStyle(
                          color: ink,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Share an idea, an experience, or something you learned.',
                        style: TextStyle(
                          color: muted,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      const Text(
                        'COVER IMAGE',
                        style: TextStyle(
                          color: ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: isUploading ? null : selectImage,
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            color: AppPallete.borderColor,
                            dashPattern: const [7, 4],
                            radius: const Radius.circular(18),
                            strokeWidth: 1.2,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              color: const Color(0xFFECE5D9),
                              child: image != null
                                  ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 12,
                                          bottom: 12,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.65),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.edit_rounded,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    'Change image',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 42,
                                          color: accent,
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          'Choose a cover image',
                                          style: TextStyle(
                                            color: ink,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          'Tap here to select a photo',
                                          style: TextStyle(
                                            color: muted,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),
                      const Text(
                        'TOPICS',
                        style: TextStyle(
                          color: ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Choose at least one topic for your story.',
                        style: TextStyle(
                          color: muted,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: Constants.topics.map((topic) {
                          final isSelected =
                              selectedTopics.contains(topic);

                          return FilterChip(
                            label: Text(topic),
                            selected: isSelected,
                            showCheckmark: true,
                            onSelected: isUploading
                                ? null
                                : (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedTopics.add(topic);
                                      } else {
                                        selectedTopics.remove(topic);
                                      }
                                    });
                                  },
                            selectedColor: const Color(0xFFE8D2C8),
                            backgroundColor: const Color(0xFFFFFDF9),
                            checkmarkColor: accent,
                            side: BorderSide(
                              color: isSelected
                                  ? accent
                                  : AppPallete.borderColor,
                            ),
                            labelStyle: TextStyle(
                              color: ink,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 28),
                      const Text(
                        'YOUR STORY',
                        style: TextStyle(
                          color: ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),

                      BlogEditor(
                        controller: titleConrtrolller,
                        hintText: 'Give your story a title',
                      ),
                      const SizedBox(height: 14),
                      BlogEditor(
                        controller: contentConrtrolller,
                        hintText: 'Start writing your thoughts...',
                      ),

                      const SizedBox(height: 26),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton.icon(
                          onPressed: isUploading ? null : uploadBlog,
                          icon: const Icon(Icons.publish_rounded),
                          label: const Text('Publish story'),
                          style: FilledButton.styleFrom(
                            backgroundColor: accent,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                accent.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
