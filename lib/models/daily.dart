// Data model to display data in next 7 days screen.
class Daily {
  int? id;
  String? day;
  String? date;
  String? temp;
  String? tempFeels;

  Daily({
    required this.id,
    required this.day,
    required this.date,
    required this.temp,
    required this.tempFeels,
  });
}
