class UberModel {
  final String topic;
  final UberData data;

  UberModel({
    required this.topic,
    required this.data,
  });

  // Default data constructor
  factory UberModel.defaultData() {
    return UberModel(
      topic: "uber",
      data: UberData.defaultData(),
    );
  }

  // CopyWith method
  UberModel copyWith({
    String? topic,
    UberData? data,
  }) {
    return UberModel(
      topic: topic ?? this.topic,
      data: data ?? this.data,
    );
  }

  // Equals operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UberModel && other.topic == topic && other.data == data;
  }

  @override
  int get hashCode => topic.hashCode ^ data.hashCode;

  // Convert UberModel to a map
  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'data': data.toMap(),
    };
  }

  // Create an UberModel from a map
  factory UberModel.fromMap(Map<String, dynamic> map) {
    return UberModel(
      topic: map['topic'] ?? '',
      data: UberData.fromMap(map['data'] ?? {}),
    );
  }
}

class UberData {
  final String uberLogo;
  final String uberArriveTime;
  final String uberCarPlate;
  final String uberDriverName;
  final String uberDriverImage;
  final String assetCar;
  final String uberAddress;
  final double uberProgress;

  UberData({
    required this.uberLogo,
    required this.uberArriveTime,
    required this.uberCarPlate,
    required this.uberDriverName,
    required this.uberDriverImage,
    required this.assetCar,
    required this.uberAddress,
    required this.uberProgress,
  });

  // Default data constructor
  factory UberData.defaultData() {
    return UberData(
      uberLogo: "uber_logo",
      uberArriveTime: "3:09pm",
      uberCarPlate: "77LN",
      uberDriverName: "Steven",
      uberDriverImage: "https://www.stevencc.dev/assets/02-SRQee8UE.jpg",
      assetCar: "uber",
      uberAddress: "130 South Oxford Ave",
      uberProgress: 0.03,
    );
  }

  // CopyWith method
  UberData copyWith({
    String? uberLogo,
    String? uberArriveTime,
    String? uberCarPlate,
    String? uberDriverName,
    String? uberDriverImage,
    String? assetCar,
    String? uberAddress,
    double? uberProgress,
  }) {
    return UberData(
      uberLogo: uberLogo ?? this.uberLogo,
      uberArriveTime: uberArriveTime ?? this.uberArriveTime,
      uberCarPlate: uberCarPlate ?? this.uberCarPlate,
      uberDriverName: uberDriverName ?? this.uberDriverName,
      uberDriverImage: uberDriverImage ?? this.uberDriverImage,
      assetCar: assetCar ?? this.assetCar,
      uberAddress: uberAddress ?? this.uberAddress,
      uberProgress: uberProgress ?? this.uberProgress,
    );
  }

  // Equals operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UberData &&
        other.uberLogo == uberLogo &&
        other.uberArriveTime == uberArriveTime &&
        other.uberCarPlate == uberCarPlate &&
        other.uberDriverName == uberDriverName &&
        other.uberDriverImage == uberDriverImage &&
        other.assetCar == assetCar &&
        other.uberAddress == uberAddress &&
        other.uberProgress == uberProgress;
  }

  @override
  int get hashCode {
    return uberLogo.hashCode ^
        uberArriveTime.hashCode ^
        uberCarPlate.hashCode ^
        uberDriverName.hashCode ^
        uberDriverImage.hashCode ^
        assetCar.hashCode ^
        uberAddress.hashCode ^
        uberProgress.hashCode;
  }

  // Convert UberData to a map
  Map<String, dynamic> toMap() {
    return {
      'uber_logo': uberLogo,
      'uber_arrive_time': uberArriveTime,
      'uber_car_plate': uberCarPlate,
      'uber_driver_name': uberDriverName,
      'uber_driver_image': uberDriverImage,
      'asset_car': assetCar,
      'uber_address': uberAddress,
      'uber_progress': uberProgress,
    };
  }

  // Create UberData from a map
  factory UberData.fromMap(Map<String, dynamic> map) {
    return UberData(
      uberLogo: map['uberLogo'] ?? '',
      uberArriveTime: map['uberArriveTime'] ?? '',
      uberCarPlate: map['uberCarPlate'] ?? '',
      uberDriverName: map['uberDriverName'] ?? '',
      uberDriverImage: map['uberDriverImage'] ?? '',
      assetCar: map['assetCar'] ?? '',
      uberAddress: map['uberAddress'] ?? '',
      uberProgress: map['uberProgress']?.toDouble() ?? 0.0,
    );
  }
}
