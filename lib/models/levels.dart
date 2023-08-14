class Levels {
  String? name;
  int? mustCoins;
  String? image;
  bool? isAvailable;
  String? bwImage;
  String? engName;
  String? desc;
  String? descEng;


  Levels({
    required this.name,
    required this.engName,
    required this.mustCoins,
    required this.image,
    required this.isAvailable,
    required this.bwImage,
    required this.desc,
    required this.descEng,
  });

  factory Levels.fromJson(Map<String, dynamic> json) {
    return Levels(
      name: json['name'],
      mustCoins: json['must_coins'],
      image: json['image'],
      isAvailable: json['is_available'],
      bwImage: json['bw_image'],
      engName: json['eng_name'],
      desc: json['rus_desc'],
      descEng: json['eng_desc'],

    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "must_coins": mustCoins,
        'image': image,
        'is_available': isAvailable,
        'bw_image': bwImage,
      };
}
