// class news untuk menyimpan segala sesuatu yang berkaitan dengan parameter API
class News{
  final String title;
  final String resourceType;
  final String shortURL;
  final String thumbnailImage;

  News({
    required this.title,
    required this.resourceType,
    required this.shortURL,
    required this.thumbnailImage,
  });

  factory News.fromJson(Map<String, dynamic> json){
    return News(
      title: json['title'],
      resourceType: json['resourceType'],
      shortURL: json['shortURL'],
      thumbnailImage: json['thumbnailImage'],
    );
  }

  static List<News> newsFromSnapshot(List snapshot){
    return snapshot.map((data){
      return News.fromJson(data);
    }).toList();
  }

  @override 
  String toString(){
    return 'News{title: $title, resourceType: $resourceType, shortURL: $shortURL, thumbnailImage: $thumbnailImage}';
  }
}