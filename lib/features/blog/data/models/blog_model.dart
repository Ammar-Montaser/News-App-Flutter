import 'dart:convert';

import 'package:articles_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.posterId,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.updatedAt});

  @override
  String toString() {
    return 'Blog(id: $id, posterId: $posterId, title: $title, content: $content, imageUrl: $imageUrl, topics: $topics, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: map['updatedAt'] == null
          ? DateTime.now()
          : DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}