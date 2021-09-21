class RandomUserModel {
  final String gender;
  final String title;
  final String first;
  final String last;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String picture;
  final String phone;

  RandomUserModel.fromJson(Map<String, dynamic> json)
      : gender = json['gender'],
        title = json['name']['title'],
        first = json['name']['first'],
        last = json['name']['last'],
        city = json['location']['city'],
        state = json['location']['state'],
        country = json['location']['country'],
        postcode = 'SD6 1453',

        /// API has some data int and some string
        picture = json['picture']['large'],
        phone = json['phone'];
}
