import 'dart:convert';

import 'package:articles_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.user_id,
      required super.title,
      required super.content,
      required super.image_url,
      required super.topics,
      required super.updatedAt});

  @override
  String toString() {
    return 'Blog(id: $id, user_id: $user_id, title: $title, content: $content, image_url: $image_url, topics: $topics, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'title': title,
      'content': content,
      'image_url': image_url,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      image_url: map['image_url'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  BlogModel copyWith({
    String? id,
    String? user_id,
    String? title,
    String? content,
    String? image_url,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      title: title ?? this.title,
      content: content ?? this.content,
      image_url: image_url ?? this.image_url,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
