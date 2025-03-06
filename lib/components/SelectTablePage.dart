import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/CancleDialogWidget.dart';

import 'package:foodqueuedev/components/QRView.dart';

class SelectTablePage extends StatefulWidget {
  const SelectTablePage({super.key});

  @override
  State<SelectTablePage> createState() => _SelectTablePageState();
}

class _SelectTablePageState extends State<SelectTablePage> {
  String selectedTable = "";

  bool _modalCancel = false;
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

  void _selectedTable(String table) {
    setState(() {
      selectedTable = table;
    });
  }

  // void _showPopup(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //         contentPadding: EdgeInsets.zero,
  //         content: StatefulBuilder(
  //           builder: (context, setState) {
  //             // นับถอยหลังในที่นี้
  //             Timer.periodic(const Duration(seconds: 1), (timer) {
  //               if (_start > 0) {
  //                 setState(() {
  //                   _start--; // อัพเดทค่า _start ในขณะที่แสดง Dialog
  //                 });
  //               } else {
  //                 timer.cancel();
  //                 setState(() {}); // เมื่อถึง 0 ก็หยุด Timer
  //                 _modalCancel = true; // เปลี่ยนค่า _modalCancel
  //               }
  //             });

  //             return Container(
  //               width: MediaQuery.of(context).size.width * 0.8,
  //               padding: EdgeInsets.all(20),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     "คุณได้ทำการยกเลิกการจองโต๊ะ",
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(height: 20),
  //                   Text(
  //                     "โปรดรอ.....",
  //                     style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFF676767)),
  //                   ),
  //                   SizedBox(height: 30),
  //                   Text(
  //                     "$_start", // แสดงค่า _start
  //                     style: TextStyle(
  //                         fontSize: 60,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFFFFB534)),
  //                   ),
  //                   SizedBox(height: 30),
  //                   Text(
  //                     "วินาที",
  //                     style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFF676767)),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   ).then((_) {
  //     if (_modalCancel) {
  //       Navigator.pop(context); // ปิด Dialog เมื่อ _modalCancel เป็น true
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Container(
            color: Colors.blue,
            height: 300.0,
            width: 300.0,
          ),
        ),
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
                child: Column(
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
                                    return Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _selectedTable(
                                                '${ABC[indexRow]}${indexCol + 1}');
                                          },
                                          icon: Icon(
                                            selectedTable == currentIndex
                                                ? Icons.check_circle
                                                : Icons.table_restaurant,
                                            color: selectedTable == currentIndex
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
              ElevatedButton(
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
                              return QRview(selectedTable: '${selectedTable}');
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
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                          ),
                        );
                        if (result == true) {
                          final deleteSelected = await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const CancleDialogWidget());

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
