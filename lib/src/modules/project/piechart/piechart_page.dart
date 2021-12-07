import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/modules/project/project_controller.dart';
import 'package:pie_chart/pie_chart.dart';

enum LegendShape { Circle, Rectangle }

class PiechartPage extends StatefulWidget {
  int id;

  PiechartPage({Key? key, required this.id}) : super(key: key);
  @override
  _PiechartState createState() => _PiechartState(id: id);
}

class _PiechartState extends State<PiechartPage> {
  int id;
  _PiechartState({required this.id});
  ProjectController projectController = Get.put(ProjectController());

  late Future<CommonResp?> data;
  @override
  void initState() {
    data = projectController.piechart(id);
    super.initState();
  }

  // final dataMap = <String, double>{
  //   "numDoneState": 0,
  //   "numSubmittedState": 2,
  //   "numInProcessState": 0,
  //   "numInCompleteState": 0,
  //   "numToBeDiscussedState": 0,
  //   "numDuplicateState": 0,
  //   "numObsoleteState": 0
  // };
  // final dataMap1 = <String, double>{
  //   "doneTaskInDeadline": 0,
  //   "doneTaskAfterDeadline": 0,
  //   "notDoneTaskInDeadline": 1,
  //   "notTaskAfterDeadline": 1
  // };
  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
    Color(0xffff0000),
    Color(0xff88e8f2)
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 16;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  Widget char(var dataMap) {
    return PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      //chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
          ? 300
          : MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "State" : null,
      // legendOptions: LegendOptions(
      //   showLegendsInRow: _showLegendsInRow,
      //   legendPosition: _legendPosition!,
      //   showLegends: _showLegends,
      //   legendShape: _legendShape == LegendShape.Circle
      //       ? BoxShape.circle
      //       : BoxShape.rectangle,
      //   legendTextStyle: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      chartValuesOptions: ChartValuesOptions(
        // showChartValueBackground: _showChartValueBackground,
        // showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        //showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
    );
  }

  Widget char1(var dataMap1) {
    return PieChart(
      key: ValueKey(key),
      dataMap: dataMap1,
      animationDuration: Duration(milliseconds: 800),
      //chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
          ? 300
          : MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "Deadline" : null,
      // legendOptions: LegendOptions(
      //   showLegendsInRow: _showLegendsInRow,
      //   legendPosition: _legendPosition!,
      //   showLegends: _showLegends,
      //   legendShape: _legendShape == LegendShape.Circle
      //       ? BoxShape.circle
      //       : BoxShape.rectangle,
      //   legendTextStyle: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      chartValuesOptions: ChartValuesOptions(
        // showChartValueBackground: _showChartValueBackground,
        // showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        //showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            SwitchListTile(
              value: _showGradientColors,
              title: Text("Show Gradient Colors"),
              onChanged: (val) {
                setState(() {
                  _showGradientColors = val;
                });
              },
            ),
            ListTile(
              title: Text(
                'Pie Chart Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ListTile(
              title: Text("chartType"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<ChartType>(
                  value: _chartType,
                  items: [
                    DropdownMenuItem(
                      child: Text("disc"),
                      value: ChartType.disc,
                    ),
                    DropdownMenuItem(
                      child: Text("ring"),
                      value: ChartType.ring,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartType = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("ringStrokeWidth"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _ringStrokeWidth,
                  disabledHint: Text("select chartType.ring"),
                  items: [
                    DropdownMenuItem(
                      child: Text("16"),
                      value: 16,
                    ),
                    DropdownMenuItem(
                      child: Text("32"),
                      value: 32,
                    ),
                    DropdownMenuItem(
                      child: Text("48"),
                      value: 48,
                    ),
                  ],
                  onChanged: (_chartType == ChartType.ring)
                      ? (val) {
                          setState(() {
                            _ringStrokeWidth = val;
                          });
                        }
                      : null,
                ),
              ),
            ),
            SwitchListTile(
              value: _showCenterText,
              title: Text("showCenterText"),
              onChanged: (val) {
                setState(() {
                  _showCenterText = val;
                });
              },
            ),
            ListTile(
              title: Text("chartLegendSpacing"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _chartLegendSpacing,
                  disabledHint: Text("select chartType.ring"),
                  items: [
                    DropdownMenuItem(
                      child: Text("16"),
                      value: 16,
                    ),
                    DropdownMenuItem(
                      child: Text("32"),
                      value: 32,
                    ),
                    DropdownMenuItem(
                      child: Text("48"),
                      value: 48,
                    ),
                    DropdownMenuItem(
                      child: Text("64"),
                      value: 64,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartLegendSpacing = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Legend Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchListTile(
              value: _showLegendsInRow,
              title: Text("showLegendsInRow"),
              onChanged: (val) {
                setState(() {
                  _showLegendsInRow = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegends,
              title: Text("showLegends"),
              onChanged: (val) {
                setState(() {
                  _showLegends = val;
                });
              },
            ),
            ListTile(
              title: Text("legendShape"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendShape>(
                  value: _legendShape,
                  items: [
                    DropdownMenuItem(
                      child: Text("BoxShape.circle"),
                      value: LegendShape.Circle,
                    ),
                    DropdownMenuItem(
                      child: Text("BoxShape.rectangle"),
                      value: LegendShape.Rectangle,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendShape = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("legendPosition"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendPosition>(
                  value: _legendPosition,
                  items: [
                    DropdownMenuItem(
                      child: Text("left"),
                      value: LegendPosition.left,
                    ),
                    DropdownMenuItem(
                      child: Text("right"),
                      value: LegendPosition.right,
                    ),
                    DropdownMenuItem(
                      child: Text("top"),
                      value: LegendPosition.top,
                    ),
                    DropdownMenuItem(
                      child: Text("bottom"),
                      value: LegendPosition.bottom,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendPosition = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Chart values Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchListTile(
              value: _showChartValueBackground,
              title: Text("showChartValueBackground"),
              onChanged: (val) {
                setState(() {
                  _showChartValueBackground = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValues,
              title: Text("showChartValues"),
              onChanged: (val) {
                setState(() {
                  _showChartValues = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesInPercentage,
              title: Text("showChartValuesInPercentage"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesInPercentage = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesOutside,
              title: Text("showChartValuesOutside"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesOutside = val;
                });
              },
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Bg,
      appBar: AppBar(
        title: Text("Statistics"),
        backgroundColor: Color(0xff2d5f79),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                key = key + 1;
              });
            },
            child: Text("Reload".toUpperCase()),
          ),
        ],
      ),
      body: FutureBuilder<CommonResp?>(
          future: data,
          builder: (_, snapshot) {
            if (snapshot.data == null) {
              return SizedBox.shrink();
            }
            CommonResp rs = snapshot.data!;
            var t = rs.data as Map;
            print(t["numDoneState"]);
            // var temp  = json.decode(rs.data as String);
            // print(temp);
            final dataMap = <String, double>{
              "numDoneState": t["numDoneState"].toDouble(),
              "numSubmittedState": t["numSubmittedState"].toDouble(),
              "numInProcessState": t["numInProcessState"].toDouble(),
              "numInCompleteState": t["numInCompleteState"].toDouble(),
              "numToBeDiscussedState": t["numToBeDiscussedState"].toDouble(),
              "numDuplicateState": t["numDuplicateState"].toDouble(),
              "numObsoleteState": t["numObsoleteState"].toDouble()
            };
            final dataMap1 = <String, double>{
              "doneTaskInDeadline": t["doneTaskInDeadline"].toDouble(),
              "doneTaskAfterDeadline": t["doneTaskAfterDeadline"].toDouble(),
              "notDoneTaskInDeadline": t["notDoneTaskInDeadline"].toDouble(),
              "notTaskAfterDeadline": t["notTaskAfterDeadline"].toDouble()
            };
            return LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: char(dataMap),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: settings,
                      )
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: char1(dataMap1),
                          margin: EdgeInsets.symmetric(
                            vertical: 32,
                          ),
                        ),
                        Container(
                          child: char(dataMap),
                          margin: EdgeInsets.symmetric(
                            vertical: 32,
                          ),
                        ),
                        settings,
                      ],
                    ),
                  );
                }
              },
            );
          }),
    );
  }
}
