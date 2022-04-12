class Cities {
  int? id;
  String? name;

  Cities({this.id, this.name});
  Cities.fromJson(Map json)
      : id = json['id'],
        name = json['name'];
}
