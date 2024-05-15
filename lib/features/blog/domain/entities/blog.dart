// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final String id;
  final String user_id;
  final String title;
  final String content;
  final String image_url;
  final List<String> topics;
  final DateTime updatedAt;

  Blog(
      {required this.id,
      required this.user_id,
      required this.title,
      required this.content,
      required this.image_url,
      required this.topics,
      required this.updatedAt});
}
