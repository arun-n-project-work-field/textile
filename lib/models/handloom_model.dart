class HandloomModel {
  final String id;

  final String latitude;
  final String longitude;
  final String accuracy;

  final String captureDateTime;

  final String handloomPhoto;

  final String weaverPhoto;

  final String remarks;

  final String syncStatus;

  HandloomModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.captureDateTime,
    required this.handloomPhoto,
    required this.weaverPhoto,
    required this.remarks,
    required this.syncStatus,
  });

  factory HandloomModel.fromJson(Map<String, dynamic> json) {
    return HandloomModel(
      id: json["id"] ?? "",

      latitude: json["latitude"] ?? "",

      longitude: json["longitude"] ?? "",

      accuracy: json["accuracy"] ?? "",

      captureDateTime: json["captureDateTime"] ?? "",

      handloomPhoto: json["handloomPhoto"] ?? "",

      weaverPhoto: json["weaverPhoto"] ?? "",

      remarks: json["remarks"] ?? "",

      syncStatus: json["syncStatus"] ?? "Pending",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "latitude": latitude,

      "longitude": longitude,

      "accuracy": accuracy,

      "captureDateTime": captureDateTime,

      "handloomPhoto": handloomPhoto,

      "weaverPhoto": weaverPhoto,

      "remarks": remarks,

      "syncStatus": syncStatus,
    };
  }

  HandloomModel copyWith({
    String? id,
    String? latitude,
    String? longitude,
    String? accuracy,
    String? captureDateTime,
    String? handloomPhoto,
    String? weaverPhoto,
    String? remarks,
    String? syncStatus,
  }) {
    return HandloomModel(
      id: id ?? this.id,

      latitude: latitude ?? this.latitude,

      longitude: longitude ?? this.longitude,

      accuracy: accuracy ?? this.accuracy,

      captureDateTime: captureDateTime ?? this.captureDateTime,

      handloomPhoto: handloomPhoto ?? this.handloomPhoto,

      weaverPhoto: weaverPhoto ?? this.weaverPhoto,

      remarks: remarks ?? this.remarks,

      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  String toString() {
    return '''
HandloomModel(
id : $id
latitude : $latitude
longitude : $longitude
accuracy : $accuracy
captureDateTime : $captureDateTime
handloomPhoto : $handloomPhoto
weaverPhoto : $weaverPhoto
remarks : $remarks
syncStatus : $syncStatus
)
''';
  }
}
