import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State<Home> {

  var dateTextStyle =
  TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,);

  int touchedIndex;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Color(0xffE5E5E5),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myLineChart(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myPiChart(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: myTextItems("Mktg. Spend", "48.6M"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: myTextItems("Latest", "25.5M"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myLineChart(),
            ),

          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 350.0),
            StaggeredTile.extent(4, 400.0),
            StaggeredTile.extent(2, 120.0),
            StaggeredTile.extent(2, 120.0),
            StaggeredTile.extent(4, 250.0),
          ],
        ),
      ),
    );
  }

  Material myPiChart() {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Color(0x802196F3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("data",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator('test', Color(0xfff8b250)),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator('Second', const Color(0xff0293ee)),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator('Third', Color(0xff845bef)),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator('Forth', Colors.orange),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }


  Material myLineChart() {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Color(0x802196F3),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(enabled: true,),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 4),
                    FlSpot(1, 3.5),
                    FlSpot(2, 4.5),
                    FlSpot(3, 1),
                    FlSpot(4, 4),
                    FlSpot(5, 6),
                  ],
                  isCurved: true,
                  barWidth: 8,
                  colors: [
                    Colors.orange,
                  ],
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [Colors.deepOrange, Colors.orange, Colors.white],

                  ),
                  /*   aboveBarData: BarAreaData(
                          show: true,
                          colors: [Colors.orange.withOpacity(0.6)],
                          cutOffY: cutOffYValue,
                          applyCutOffY: true,
                        ), */
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],
              minY: 0,
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 10,
                    textStyle: dateTextStyle,
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Jan';
                        case 1:
                          return 'Feb';
                        case 2:
                          return 'Mar';
                        case 3:
                          return 'Apr';
                        case 4:
                          return 'May';
                        case 5:
                          return 'Jun';
                        default:
                          return '';
                      }
                    }),
                leftTitles: SideTitles(
                  showTitles: true,
                  textStyle: dateTextStyle,
                  getTitles: (value) {
                    return '${value + 1}';
                  },
                ),
              ),
              axisTitleData: FlAxisTitleData(
                  leftTitle: AxisTitle(
                      showTitle: true, titleText: 'Value', margin: 4),
                  bottomTitle: AxisTitle(
                      showTitle: true,
                      margin: 4,
                      titleText: '2019',
                      textStyle: dateTextStyle,
                      textAlign: TextAlign.center)),
              gridData: FlGridData(
                show: false,
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ),
    );
  }


  Material myTextItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(subtitle,),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

// ignore: must_be_immutable
class Indicator extends StatelessWidget {

  Color color;
  String text;

  Indicator(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Row(children: [
        Container(
          height: 15,
          width: 15,
          color: color,
        ),
        SizedBox(width: 8,),
        Text(text)
      ],),
    );
  }
}

