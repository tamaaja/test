import 'package:flutter/material.dart';

class ActivityLogPage extends StatefulWidget {
  @override
  _ActivityLogPageState createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  final List<Map<String, String>> gymMovesets = [
{
      "name": "Dumbbell Curl",
      "difficulty": "Novice",
      "measure": "Weight/Reps",
      "sets": "3x10",
      "force": "Pull",
      "grips": "Neutral",
      "mechanic": "Isolation",
      "targetMuscle": "Biceps",
      "description": "Focus on controlled movements to engage the biceps fully."
    },
    {
      "name": "Bench Press",
      "difficulty": "Intermediate",
      "measure": "Weight/Reps",
      "sets": "4x8",
      "force": "Push",
      "grips": "Overhand",
      "mechanic": "Compound",
      "targetMuscle": "Chest, Triceps",
      "description": "A key chest exercise that also activates triceps."
    },
    {
      "name": "Squat",
      "difficulty": "Intermediate",
      "measure": "Weight/Reps",
      "sets": "4x12",
      "force": "Push",
      "grips": "None",
      "mechanic": "Compound",
      "targetMuscle": "Quadriceps, Glutes",
      "description": "Engages lower body muscles with an emphasis on form."
    },
    {
      "name": "Deadlift",
      "difficulty": "Advanced",
      "measure": "Weight/Reps",
      "sets": "3x5",
      "force": "Pull",
      "grips": "Mixed",
      "mechanic": "Compound",
      "targetMuscle": "Back, Hamstrings",
      "description":
          "Strengthens the back and lower body; requires proper form."
    },
    {
      "name": "Overhead Press",
      "difficulty": "Intermediate",
      "measure": "Weight/Reps",
      "sets": "4x10",
      "force": "Push",
      "grips": "Overhand",
      "mechanic": "Compound",
      "targetMuscle": "Shoulders, Triceps",
      "description":
          "Targets the shoulders; maintain core stability throughout."
    },
    {
      "name": "Lat Pulldown",
      "difficulty": "Novice",
      "measure": "Weight/Reps",
      "sets": "4x10",
      "force": "Pull",
      "grips": "Wide",
      "mechanic": "Isolation",
      "targetMuscle": "Lats, Biceps",
      "description": "Pull towards chest to activate lats and biceps."
    },
    {
      "name": "Leg Press",
      "difficulty": "Novice",
      "measure": "Weight/Reps",
      "sets": "4x12",
      "force": "Push",
      "grips": "None",
      "mechanic": "Compound",
      "targetMuscle": "Quadriceps, Glutes",
      "description": "Alternative to squats, focusing on lower body."
    },
    {
      "name": "Seated Row",
      "difficulty": "Novice",
      "measure": "Weight/Reps",
      "sets": "3x12",
      "force": "Pull",
      "grips": "Neutral",
      "mechanic": "Compound",
      "targetMuscle": "Back, Biceps",
      "description": "Use controlled movements to target the back."
    },
    {
      "name": "Tricep Extension",
      "difficulty": "Novice",
      "measure": "Weight/Reps",
      "sets": "3x15",
      "force": "Push",
      "grips": "Overhand",
      "mechanic": "Isolation",
      "targetMuscle": "Triceps",
      "description": "Isolates triceps; avoid moving the shoulders."
    },
    {
      "name": "Leg Curl",
      "difficulty": "Novice",
      "measure": "Weight/Reps",
      "sets": "4x12",
      "force": "Pull",
      "grips": "None",
      "mechanic": "Isolation",
      "targetMuscle": "Hamstrings",
      "description": "Focus on hamstrings by pulling weight towards glutes."
    },
    {
      "name": "Dumbell Goblet Reverse Squat",
      "difficulty": "novice",
      "measure": "Weight/Reps",
      "sets": "4x8",
      "force": "Push",
      "grips": "Neutral",
      "mechanic": "Compound",
      "targetMuscle": "Quadriceps, Glutes",
      "description": "Engages lower body muscles with an emphasis on form."
    },
  ];

  String searchQuery = "";
  List<Map<String, String>> filteredMovesets = [];

  @override
  void initState() {
    super.initState();
    filteredMovesets = gymMovesets; // Tampilkan semua data awalnya
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredMovesets = gymMovesets
          .where((move) =>
              move.values.any((value) =>
                  value.toLowerCase().contains(searchQuery))) // Filter data
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gympedia', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[700]!, Colors.blue[900]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 6,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari Latihan....",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: updateSearchQuery,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovesets.length,
              itemBuilder: (context, index) {
                final move = filteredMovesets[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.fitness_center,
                                  color: Colors.blue[900]),
                              const SizedBox(width: 8),
                              Text(
                                move["name"] ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Divider(color: Colors.grey[300], thickness: 1),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Difficulty: ${move["difficulty"]}",
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text("Measure: ${move["measure"]}",
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text("Series / Sets: ${move["sets"]}",
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Force: ${move["force"]}",
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text("Grips: ${move["grips"]}",
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text("Mechanic: ${move["mechanic"]}",
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Target Muscle: ${move["targetMuscle"]}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            move["description"] ?? "",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Divider(color: Colors.grey[300], thickness: 1),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}