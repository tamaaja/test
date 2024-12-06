import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key, required bool isDarkMode, required Function(bool p1) toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Meet the Developers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),

            // Profile for Person 1
            const ProfileCard(
              name: "Gerry Hasrom",
              position: "Lead Developer",
              position2: "2209106094",
              imagePath: "assets/images/gerry.jpg",
              description:
                  "Gerry adalah seorang mahasiswa Teknik Informatika di Universitas Mulawarman dengan spesialisasi dalam pengembangan aplikasi berbasis Flutter.",
              cardColor: Colors.tealAccent,
            ),
            const SizedBox(height: 20),

            // Profile for Person 2
            const ProfileCard(
              name: "Muhammad Rizky Putra Pratama",
              position: "UI/UX Designer",
              position2: "2209106102",
              imagePath: "assets/images/rizky.jpg",
              description:
                  "Rizky adalah seorang desainer dengan keahlian dalam menciptakan antarmuka pengguna yang modern dan menarik.",
              cardColor: Colors.cyanAccent,
            ),
            const SizedBox(height: 20),

            // Profile for Person 3
            const ProfileCard(
              name: "Alif Naufal Fachrian",
              position: "Backend Developer",
              position2: "2209106108",
              imagePath: "assets/images/alif.jpg",
              description:
                  "Alif memiliki keahlian dalam membangun sistem backend yang efisien dan mendukung performa aplikasi.",
              cardColor: Colors.greenAccent,
            ),
            const SizedBox(height: 20),

            // Profile for Person 4
            const ProfileCard(
              name: "Zaky Syuhada",
              position: "Frontend Developer",
              position2: "2209106073",
              imagePath: "assets/images/zaky.jpg",
              description:
                  "Zaky ahli dalam mengimplementasikan desain UI menjadi aplikasi Flutter yang interaktif dan responsif.",
              cardColor: Colors.lightBlueAccent,
            ),
            const SizedBox(height: 20),

            // Additional Section
            AdditionalInfoCard(
              title: "Our Mission",
              content:
                  "Kami berkomitmen untuk memberikan solusi terbaik dalam dunia kebugaran dengan aplikasi yang modern, user-friendly, dan inovatif.",
              backgroundColor: Colors.teal[50],
            ),
            const SizedBox(height: 10),
            AdditionalInfoCard(
              title: "Our Vision",
              content:
                  "Menciptakan platform digital terbaik untuk meningkatkan kualitas hidup pengguna melalui olahraga dan kesehatan.",
              backgroundColor: Colors.teal[100],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String position;
  final String position2;
  final String imagePath;
  final String description;
  final Color cardColor;

  const ProfileCard({
    super.key,
    required this.name,
    required this.position,
    required this.position2,
    required this.imagePath,
    required this.description,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              position,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            Text(
              position2,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdditionalInfoCard extends StatelessWidget {
  final String title;
  final String content;
  final Color? backgroundColor;

  const AdditionalInfoCard({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
