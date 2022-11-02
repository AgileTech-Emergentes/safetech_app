class Shift {
  int id;
  String startTime;
  String endTime;
  int repairDuration;

  Shift({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.repairDuration,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        repairDuration: json["repairDuration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "repairDuration": repairDuration,
      };
}
