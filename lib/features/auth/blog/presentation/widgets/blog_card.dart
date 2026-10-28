
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/auth/blog/domain/entities/blog.dart';
import 'package:blog_app/features/auth/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  static const Color ink = Color(0xFF292821);
  static const Color muted = Color(0xFF77736C);
  static const Color paper = Color(0xFFFFFDF9);

  @override
  Widget build(BuildContext context) {
    final posterName = blog.posterName?.trim() ?? '';

    return Card(
      color: paper,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE4DED2)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, BlogViewerPage.route(blog));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            SizedBox(
              height: 190,
              width: double.infinity,
              child: Image.network(
                blog.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: color.withValues(alpha: 0.18),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: color,
                      size: 40,
                    ),
                  );
                },
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;

                  return Container(
                    color: color.withValues(alpha: 0.12),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: color,
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topic labels
                  if (blog.topics.isNotEmpty)
                    Wrap(
                      spacing: 7,
                      runSpacing: 6,
                      children: blog.topics.take(3).map((topic) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            topic,
                            style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 12),

                  // Article title
                  Text(
                    blog.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 22,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.35,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author and reading time
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: const Color(0xFFE6DED0),
                        child: Text(
                          posterName.isNotEmpty
                              ? posterName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: ink,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          posterName.isNotEmpty
                              ? posterName
                              : 'Guest author',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: muted,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${calculateReadingTime(blog.content)} min read',
                        style: const TextStyle(
                          color: muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
