import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'workout_planner_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _tasks = [
    {"title": "Push-ups", "completed": false},
    {"title": "Running", "completed": false},
    {"title": "Squats", "completed": false},
  ];

  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Menghilangkan back arrow dan ikon lain
        automaticallyImplyLeading:
            false, // Tambahkan ini untuk menghapus back arrow
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Workout Progress Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Workout Progress',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_tasks.where((task) => !task["completed"]).length} Kegiatan Tersisa',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 8.0,
                      percent: _tasks.isEmpty
                          ? 0
                          : _tasks.where((task) => task["completed"]).length /
                              _tasks.length,
                      center: Text(
                        "${(_tasks.where((task) => task["completed"]).length / _tasks.length * 100).toInt()}%",
                      ),
                      progressColor: Colors.blue[900],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Statistics Graph Section
              Text(
                "Workout Statistics",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Weekly Workout Progress'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    ColumnSeries<Map<String, dynamic>, String>(
                      dataSource: [
                        {"day": "Mon", "progress": 0.8},
                        {"day": "Tue", "progress": 0.6},
                        {"day": "Wed", "progress": 0.9},
                        {"day": "Thu", "progress": 0.7},
                        {"day": "Fri", "progress": 0.85},
                      ],
                      xValueMapper: (data, _) => data['day'],
                      yValueMapper: (data, _) => data['progress'],
                      name: 'Progress',
                      color: Colors.blue[900],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Workout Calendar Section
              Text(
                "Workout Calendar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _selectedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue[700],
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue[900],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // More Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final selectedWorkout =
                        await Navigator.push<Map<String, dynamic>?>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutPlannerPage(),
                      ),
                    );

                    if (selectedWorkout != null) {
                      setState(() {
                        _tasks.add({
                          "title": selectedWorkout['name'],
                          "completed": false
                        });
                      });
                    }
                  },
                  child: Text("More"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
