import 'package:cities_districts/districts.dart';

class Cities {
  String name;
  String provinceCode;
  List<Districts> districts;

  Cities(
      {required this.name,
      required this.provinceCode,
      required this.districts});
}
