import 'dart:convert';
import 'package:foodqueuedev/model/table_data.dart';
import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/CancleDialogWidget.dart';
import 'package:foodqueuedev/model/table_data.dart';
import 'package:http/http.dart' as http;
import 'package:foodqueuedev/components/QRView.dart';
import 'package:localstorage/localstorage.dart';

class SelectTablePage extends StatefulWidget {
  final String email;
  final Function deleteTable;
  const SelectTablePage(
      {super.key, required this.email, required this.deleteTable});

  @override
  State<SelectTablePage> createState() => _SelectTablePageState();
}

class _SelectTablePageState extends State<SelectTablePage> {
  String selectedTable = "";
  List<TableData> table = [];
  int selectedTableIndex = 0;
  bool isLoading = true;
  bool _modalCancel = false;
  bool isTableUserSelected = false;
  List ABC = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
  ];
  Future<void> fetchTable() async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.get(
        Uri.parse("http://localhost:3000/table/selected/getAll"),
        headers: {"authorization": "Bearer $authToken"},
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        var tableSelectedData = jsonDecode(response.body);

        if (tableSelectedData.isNotEmpty && tableSelectedData is List) {
          setState(() {
            table = tableSelectedData
                .map((tableJson) => TableData.fromJson(tableJson))
                .toList();
            isLoading = false;
            isTableUserSelected = table.any((t) => t.email == widget.email);
          });
          print(isTableUserSelected);
        } else {
          throw Exception("can't fetch table");
        }
      } else {
        throw Exception("${response.statusCode}");
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  void _selectedTable(String table) {
    setState(() {
      selectedTable = table;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Icon(
                        Icons.location_on,
                        color: Color(0xFFFFA027),
                        size: 50,
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "โรงอาหารเพชรรัตน์",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFC6E2A),
                            ),
                          ),
                          Text(
                            "มหาวิทยาลัยศิลปากร จ.นครปฐม",
                            style: TextStyle(color: Color(0xFF676767)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF181C2E),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 30)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "เลือกโต๊ะของคุณ",
                    style: TextStyle(color: Color(0xFF32343E), fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "1 โต๊ะนั่งได้สูงสุด 4 คน",
                    style: TextStyle(color: Color(0xFF676767)),
                  )
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 510,
                decoration: BoxDecoration(
                  color: Color(0xFFFBF6EE),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                              ),
                              Text('1', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 29),
                              Text('2', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 45),
                              Text('3', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 29),
                              Text('4', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 45),
                              Text('5', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 29),
                              Text('6', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  // SizedBox(height: 30),
                                  Text(
                                    "ร้านค้า",
                                    style: TextStyle(
                                        color: Color(0xFF676767), fontSize: 12),
                                  ),
                                  ...List.generate(14, (index) {
                                    return Icon(
                                      Icons.store,
                                      size: 30,
                                    );
                                  }),
                                ],
                              ),
                              SizedBox(width: 17),
                              Column(
                                children: [
                                  SizedBox(height: 5),
                                  ...List.generate(ABC.length, (indexRow) {
                                    return Row(
                                      children: [
                                        ...List.generate(6, (indexCol) {
                                          String currentIndex =
                                              '${ABC[indexRow]}${indexCol + 1}';
                                          bool isTableTaken = table.any((t) =>
                                              t.table_number == currentIndex);

                                          bool isTableUser = table.any((t) =>
                                              t.email == widget.email &&
                                              t.table_number == currentIndex);
                                          return Row(
                                            children: [
                                              isTableTaken
                                                  ? Icon(
                                                      isTableUser
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .account_circle_rounded,
                                                      color: isTableUser
                                                          ? Colors.green
                                                          : Colors.grey,
                                                      size: 35,
                                                    )
                                                  : IconButton(
                                                      onPressed:
                                                          !isTableUserSelected
                                                              ? () {
                                                                  _selectedTable(
                                                                      '${ABC[indexRow]}${indexCol + 1}');
                                                                }
                                                              : () {},
                                                      icon: Icon(
                                                        selectedTable ==
                                                                currentIndex
                                                            ? Icons.check_circle
                                                            : Icons
                                                                .table_restaurant,
                                                        color: selectedTable ==
                                                                currentIndex
                                                            ? Colors.green
                                                            : Color(0xFF49454E),
                                                      ),
                                                      iconSize: 25,
                                                    ),
                                              indexCol == 0 ||
                                                      indexCol == 2 ||
                                                      indexCol == 4 ||
                                                      indexCol == 5
                                                  ? SizedBox(width: 0)
                                                  : SizedBox(width: 12),
                                            ],
                                          );
                                        }),
                                        SizedBox(width: 12),
                                        Text(
                                          ABC[indexRow],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 30),
              isTableUserSelected
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFF14237),
                        minimumSize: Size(200, 62),
                      ),
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'คุณต้องการคืนโต๊ะใช่หรือไม่?',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  widget.deleteTable();
                                },
                                child: const Text('ตกลง'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'ยกเลิก'),
                                child: const Text('ยกเลิก'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          "คืนโต๊ะ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFFFB534),
                        minimumSize: Size(200, 62),
                      ),
                      onPressed: selectedTable != ''
                          ? () async {
                              final result = await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return QRview(
                                        selectedTable: '${selectedTable}');
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  },
                                ),
                              );
                              if (result == true) {
                                final deleteSelected = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        const CancleDialogWidget());

                                if (deleteSelected == true) {
                                  setState(() {
                                    selectedTable = "";
                                  });
                                }
                              }
                            }
                          : null,
                      child: Center(
                        child: Text(
                          "จองโต๊ะ $selectedTable",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
