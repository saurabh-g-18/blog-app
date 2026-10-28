import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/auth/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/auth/blog/presentation/widgets/blog_card.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
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
  static const Color paper = Color(0xFFF7F3EB);
  static const Color ink = Color(0xFF292821);
  static const Color muted = Color(0xFF77736C);
  static const Color accent = Color(0xFFB65E45);

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  Future<void> _openCreateBlogPage() async {
    await Navigator.push(
      context,
      AddNewBlogPage.route(),
    );

    if (!mounted) return;

    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: paper,
        title: const Text(
          'Log out?',
          style: TextStyle(color: ink),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: muted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: muted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Log out',
              style: TextStyle(color: accent),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true && mounted) {
      context.read<AuthBloc>().add(AuthLogout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, authState) {
        final isLoggingOut = authState is AuthLoading;

        return Stack(
          children: [
            Scaffold(
              backgroundColor: paper,
              appBar: AppBar(
                backgroundColor: paper,
                foregroundColor: ink,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: const Text(
                  'The Reading Room',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                actions: [
                  IconButton(
                    tooltip: 'Logout',
                    onPressed: isLoggingOut ? null : _confirmLogout,
                    icon: const Icon(Icons.logout_rounded),
                  ),
                  IconButton(
                    tooltip: 'Write a new story',
                    onPressed: isLoggingOut ? null : _openCreateBlogPage,
                    icon: const Icon(Icons.edit_note_rounded),
                    color: accent,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              body: BlocConsumer<BlogBloc, BlogState>(
                listener: (context, state) {
                  if (state is BlogFailure) {
                    showSnackBar(context, state.error);
                  }
                },
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return const Center(child: Loader());
                  }

                  if (state is BlogDisplaySuccess) {
                    if (state.blogs.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.menu_book_rounded,
                                size: 52,
                                color: accent,
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Your next favorite story starts here.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ink,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Be the first to share an idea with the community.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 22),
                              FilledButton.icon(
                                onPressed: _openCreateBlogPage,
                                icon: const Icon(Icons.edit_rounded),
                                label: const Text('Write a story'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: accent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
                      children: [
                        const Text(
                          'Ideas, stories & perspectives',
                          style: TextStyle(
                            color: ink,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            letterSpacing: -0.7,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'A little inspiration for wherever your day takes you.',
                          style: TextStyle(
                            color: muted,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...state.blogs.asMap().entries.map((entry) {
                          final index = entry.key;
                          final blog = entry.value;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: BlogCard(
                              blog: blog,
                              color: [
                                const Color(0xFFB65E45),
                                const Color(0xFF53664F),
                                const Color(0xFF8A7654),
                                const Color(0xFF627F91),
                              ][index % 4],
                            ),
                          );
                        }),
                      ],
                    );
                  }

                  if (state is BlogFailure) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cloud_off_rounded,
                              size: 44,
                              color: muted,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'We couldn’t load the stories.',
                              style: TextStyle(
                                color: ink,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Check your connection and try again.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: muted),
                            ),
                            const SizedBox(height: 18),
                            OutlinedButton.icon(
                              onPressed: () {
                                context
                                    .read<BlogBloc>()
                                    .add(BlogFetchAllBlogs());
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Try again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            // Loading overlay while logout is in progress.
            if (isLoggingOut)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: paper,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: accent),
                          SizedBox(height: 16),
                          Text(
                            'Logging out...',
                            style: TextStyle(
                              color: ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}