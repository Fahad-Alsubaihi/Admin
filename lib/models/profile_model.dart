class ProfileModel {
  String? userName;
  String? userImage;
  String? email;
  String? uid;
  bool? isban;

  ProfileModel(this.userName, this.userImage, this.email, this.uid, this.isban);

  ProfileModel.fromJson(Map<String, dynamic> json, String userid) {
    userName = json['name'];
    userImage = json['profilePicture'];
    email = json['email'];
    isban = json['isban'] ?? false;
    uid = userid;
  }
}
