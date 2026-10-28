
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/formate_date.dart';
import 'package:blog_app/features/auth/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(blog: blog),
      );

  final Blog blog;

  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  static const Color _paper = Color(0xFFF7F3EB);
  static const Color _ink = Color(0xFF292821);
  static const Color _muted = Color(0xFF77736C);
  static const Color _accent = Color(0xFFB65E45);

  @override
  Widget build(BuildContext context) {
    final readingTime = calculateReadingTime(blog.content);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _paper,
        foregroundColor: _ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'The Reading Room',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Copy article link',
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: blog.imageUrl),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image URL copied.'),
                ),
              );
            },
            icon: const Icon(Icons.ios_share_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SelectionArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A STORY TO EXPLORE',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: _accent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
          
                    Text(
                      blog.title,
                      style: const TextStyle(
                        fontSize: 32,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                        letterSpacing: -0.7,
                      ),
                    ),
                    const SizedBox(height: 24),
          
                    Row(
                      children: [
                            CircleAvatar(
                                radius: 23,
                                backgroundColor: const Color(0xFFE6DED0),
                                child: Text(
                                  (blog.posterName?.trim().isNotEmpty ?? false)
                                      ? blog.posterName!.trim()[0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    color: _ink,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
          
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  Text(
                                    (blog.posterName?.trim().isNotEmpty ?? false)
                                        ? blog.posterName!.trim()
                                        : 'Guest author',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: _ink,
                                    ),
                                  ),
          
                              const SizedBox(height: 5),
                              Text(
                                '${formatDateBydMMMYYYY(blog.updatedAt)}'
                                '  ·  $readingTime min read',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: _muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
          
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Image.network(
                          blog.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          semanticLabel: 'Cover image for ${blog.title}',
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFE6DED0),
                              alignment: Alignment.center,
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 38,
                                    color: _muted,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Cover image unavailable',
                                    style: TextStyle(color: _muted),
                                  ),
                                ],
                              ),
                            );
                          },
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
          
                            return Container(
                              color: const Color(0xFFE6DED0),
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                color: _accent,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
          
                    Container(
                      width: 48,
                      height: 3,
                      decoration: BoxDecoration(
                        color: _accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 24),
          
                    Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.85,
                        fontWeight: FontWeight.w400,
                        color: _ink,
                      ),
                    ),
                    const SizedBox(height: 36),
          
                    const Divider(color: Color(0xFFE4DED2)),
                    const SizedBox(height: 16),
          
                    const Center(
                      child: Text(
                        'Thank you for taking the time to read.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: _muted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
