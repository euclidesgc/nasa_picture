class Conversions {
  /// [date] must have the folow format: [dd/mm/yyyy]
  ///
  static DateTime stringToDate(String date) {
    String dia = date.split('/')[0];
    String mes = date.split('/')[1];
    String ano = date.split('/')[2];

    return DateTime.parse("$ano-$mes-$dia");
  }
}
