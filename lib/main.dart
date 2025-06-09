import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional CV',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CVPage(),
    );
  }
}

class CVPage extends StatelessWidget {
  const CVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('John Doe - Software Engineer'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSection('About Me', _buildAboutMe()),
              const SizedBox(height: 24),
              _buildSection('Experience', _buildExperience()),
              const SizedBox(height: 24),
              _buildSection('Education', _buildEducation()),
              const SizedBox(height: 24),
              _buildSection('Skills', _buildSkills()),
              const SizedBox(height: 24),
              _buildSection('Projects', _buildProjects()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/100'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Senior Software Engineer',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email, size: 16),
                    const SizedBox(width: 4),
                    const Text('john.doe@email.com'),
                    const SizedBox(width: 16),
                    const Icon(Icons.phone, size: 16),
                    const SizedBox(width: 4),
                    const Text('+1 234 567 890'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        content,
      ],
    );
  }

  Widget _buildAboutMe() {
    return const Text(
      'Experienced software engineer with a passion for creating efficient and scalable solutions. '
      'Specialized in web development and mobile applications. Strong problem-solving skills and '
      'excellent communication abilities.',
    );
  }

  Widget _buildExperience() {
    return Column(
      children: [
        _buildExperienceItem(
          'Senior Software Engineer',
          'Tech Company Inc.',
          '2020 - Present',
          'Led development of multiple web applications using Flutter and React. '
              'Implemented CI/CD pipelines and improved team productivity by 40%.',
        ),
        const SizedBox(height: 16),
        _buildExperienceItem(
          'Software Engineer',
          'Startup XYZ',
          '2018 - 2020',
          'Developed and maintained mobile applications. '
              'Collaborated with cross-functional teams to deliver high-quality products.',
        ),
      ],
    );
  }

  Widget _buildExperienceItem(
    String title,
    String company,
    String period,
    String description,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(company, style: const TextStyle(color: Colors.blue)),
        Text(period, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        Text(description),
      ],
    );
  }

  Widget _buildEducation() {
    return Column(
      children: [
        _buildEducationItem(
          'Master of Computer Science',
          'University of Technology',
          '2016 - 2018',
        ),
        const SizedBox(height: 16),
        _buildEducationItem(
          'Bachelor of Computer Science',
          'State University',
          '2012 - 2016',
        ),
      ],
    );
  }

  Widget _buildEducationItem(String degree, String university, String period) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          degree,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(university),
        Text(period, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildSkills() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildSkillChip('Flutter'),
        _buildSkillChip('Dart'),
        _buildSkillChip('React'),
        _buildSkillChip('JavaScript'),
        _buildSkillChip('TypeScript'),
        _buildSkillChip('Node.js'),
        _buildSkillChip('Python'),
        _buildSkillChip('Git'),
        _buildSkillChip('Docker'),
        _buildSkillChip('AWS'),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(label: Text(skill), backgroundColor: Colors.blue.shade50);
  }

  Widget _buildProjects() {
    return Column(
      children: [
        _buildProjectItem(
          'E-commerce Mobile App',
          'Developed a full-featured e-commerce mobile application using Flutter. '
              'Implemented real-time inventory management and payment processing.',
        ),
        const SizedBox(height: 16),
        _buildProjectItem(
          'Task Management System',
          'Created a web-based task management system with React and Node.js. '
              'Features include real-time updates and team collaboration tools.',
        ),
      ],
    );
  }

  Widget _buildProjectItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(description),
      ],
    );
  }
}
