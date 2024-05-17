import 'package:articles_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDB {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDBImpl implements BlogLocalDB {
  final Box box;

  BlogLocalDBImpl({required this.box});
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> list = [];
    box.read(() => {
          for (int i = 0; i < box.length; i++)
            {list.add(BlogModel.fromMap(box.get(i.toString())))}
        });
    return list;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(() => {
          for (int i = 0; i < blogs.length; i++)
            {box.put(i.toString(), blogs[i].toMap())}
        });
  }
}
