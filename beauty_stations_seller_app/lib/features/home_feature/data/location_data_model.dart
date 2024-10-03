class LocationDataModel {
  final String? address;
  final double? latitude;
  final double? longitude;

  LocationDataModel(this.address, this.latitude, this.longitude);
}

class CitesModel {
  final int id;
  final String name;

  CitesModel({required this.id, required this.name});
}
