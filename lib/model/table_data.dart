class TableData {
  final String email;
  final String table_number;
  TableData(this.email, this.table_number);
  TableData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        table_number = json['table_number'];
}
