

class Client{
  String name;
  String profilePicPath;

  Client({required this.name, required this.profilePicPath});

  Client.fromJson(Map<String,dynamic> json):
    this.name = json['name'],
    this.profilePicPath = json['profilePic']
  ;

}