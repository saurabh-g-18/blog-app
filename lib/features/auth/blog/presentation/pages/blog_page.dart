import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/auth/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/auth/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const BlogPage(),
    );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

   @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if(state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading) {
            return const Loader();
          }
          if(state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 4 == 0 ? Color.fromRGBO(162, 64, 49, 1) 
                  : index % 4 == 1 ? const Color.fromARGB(255, 96, 153, 31) 
                  : index % 4 == 2 ? const Color.fromARGB(255, 130, 133, 52) 
                  :  const Color.fromARGB(255, 56, 141, 206) 
                  );
              },
            );
          }
          return const SizedBox();
          
        },
      ),
    );
  }
}
