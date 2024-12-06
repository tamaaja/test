import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Profile Info",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: Text("Nama: ${userController.userName}"),
              trailing: Icon(Icons.edit),
              onTap: () => _editName(context, userController),
            ),
            ListTile(
              title: Text("Umur: ${userController.umur}"),
              trailing: Icon(Icons.edit),
              onTap: () => _editAge(context, userController),
            ),
            ListTile(
              title: Text("Berat Badan: ${userController.berat} kg"),
              trailing: Icon(Icons.edit),
              onTap: () => _editWeight(context, userController),
            ),
            ListTile(
              title: Text("Gender: ${userController.gender}"),
              trailing: Icon(Icons.edit),
              onTap: () => _editGender(context, userController),
            ),
            ListTile(
              title: Text("Tinggi Badan: ${userController.tinggiBadan} cm"),
              trailing: Icon(Icons.edit),
              onTap: () => _editHeight(context, userController),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Halaman Profile", style: TextStyle(fontSize: 24)),
      ),
    );
  }

  void _editName(BuildContext context, UserController userController) {
    TextEditingController nameController =
        TextEditingController(text: userController.userName);
    _showEditDialog(
      context: context,
      title: "Edit Nama",
      controller: nameController,
      onSave: () {
        userController.setUserName(nameController.text.trim());
      },
    );
  }

  void _editAge(BuildContext context, UserController userController) {
    TextEditingController ageController =
        TextEditingController(text: userController.umur.toString());
    _showEditDialog(
      context: context,
      title: "Edit Umur",
      controller: ageController,
      inputType: TextInputType.number,
      onSave: () {
        int age = int.tryParse(ageController.text.trim()) ?? 0;
        if (age > 0) {
          userController.setUmur(age);
        }
      },
    );
  }

  void _editWeight(BuildContext context, UserController userController) {
    TextEditingController weightController =
        TextEditingController(text: userController.berat.toString());
    _showEditDialog(
      context: context,
      title: "Edit Berat Badan",
      controller: weightController,
      inputType: TextInputType.number,
      onSave: () {
        double weight = double.tryParse(weightController.text.trim()) ?? 0.0;
        if (weight > 0) {
          userController.setBerat(weight);
        }
      },
    );
  }

  void _editGender(BuildContext context, UserController userController) {
    List<String> genders = ["Laki-laki", "Perempuan"];
    String selectedGender = userController.gender;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pilih Gender"),
          content: DropdownButton<String>(
            value: selectedGender.isEmpty ? null : selectedGender,
            items: genders
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                selectedGender = value;
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("BATAL"),
            ),
            TextButton(
              onPressed: () {
                userController.setGender(selectedGender);
                Navigator.pop(context);
              },
              child: Text("SIMPAN"),
            ),
          ],
        );
      },
    );
  }

  void _editHeight(BuildContext context, UserController userController) {
    TextEditingController heightController =
        TextEditingController(text: userController.tinggiBadan.toString());
    _showEditDialog(
      context: context,
      title: "Edit Tinggi Badan",
      controller: heightController,
      inputType: TextInputType.number,
      onSave: () {
        double height = double.tryParse(heightController.text.trim()) ?? 0.0;
        if (height > 0) {
          userController.setTinggiBadan(height);
        }
      },
    );
  }

  void _showEditDialog({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    required VoidCallback onSave,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: title,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("BATAL"),
            ),
            TextButton(
              onPressed: () {
                onSave();
                Navigator.pop(context);
              },
              child: Text("SIMPAN"),
            ),
          ],
        );
      },
    );
  }
}