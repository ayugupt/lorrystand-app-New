import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  City({
    this.id,
    this.name,
  });
  

  factory City.fromJson(Map<String, dynamic> json){
      return new City(
        id: json['id'],
        name: json['name'],
      );
    }

}