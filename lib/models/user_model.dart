class UserModel {
  String uid;
  String email;
  String name;
  String phone;
  String photoUrl;
  String category;
  String about;
  String address;
  String sublocality;
  String locality;
  String subadminarea;
  String adminarea;
  List<dynamic> job;
  String exp;
  double lat;
  double long;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.photoUrl,
    this.phone,
    this.category,
    this.about,
    this.address,
    this.adminarea,
    this.locality,
    this.subadminarea,
    this.sublocality,
    this.job,
    this.exp,
    this.lat,
    this.long,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      category: data['category'] ?? '',
      about: data['about'] ?? '',
      address: data['address'] ?? '',
      sublocality: data['sublocality'] ?? '',
      locality: data['locality'] ?? '',
      subadminarea: data['subadminarea'] ?? '',
      adminarea: data['adminarea'] ?? '',
      job: data['job'] ?? [''],
      exp: data['exp'] ?? '',
      lat: data['lat'] ?? '',
      long: data['long'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "phone": phone,
        "photoUrl": photoUrl,
        "category": category,
        "about": about,
        "address": address,
        "sublocality": sublocality,
        "locality": locality,
        "subadminarea": subadminarea,
        "adminarea": adminarea,
        "job": job,
        "exp": exp,
        "lat": lat,
        "long": long,
      };
}
