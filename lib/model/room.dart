class Room {
  static String roomCollectionName = 'rooms';
  String roomId;
  String roomTitle;
  String roomDescription;
  String categoryId;
  Room(
      {required this.roomTitle,
      required this.categoryId,
      required this.roomDescription,
      required this.roomId});
  Room.fromJson(Map<String, dynamic> json)
      : this(
          categoryId: json['categoryId'],
          roomDescription: json['roomDescription'],
          roomTitle: json['roomTitle'],
          roomId: json['roomId'],
        );
  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'roomDescription': roomDescription,
        'roomTitle': roomTitle,
        'roomId': roomId,
      };
}
