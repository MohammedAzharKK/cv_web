import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mohammed Azhar K.K | Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData(brightness: Brightness.dark).textTheme),
        scaffoldBackgroundColor: const Color(0xFF101624),
        cardColor: const Color(0xFF1A2236),
      ),
      themeMode: _themeMode,
      home:
          PortfolioHomePage(onToggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }
}

class PortfolioHomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  const PortfolioHomePage(
      {super.key, required this.onToggleTheme, required this.themeMode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              onToggleTheme: onToggleTheme,
              themeMode: themeMode,
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 48),
            const Section(
              title: 'About',
              delay: 200,
              child: AboutSection(),
            ),
            const Section(
              title: 'Projects',
              delay: 400,
              child: ProjectsSection(),
            ),
            const Section(
              title: 'Skills',
              delay: 600,
              child: SkillsSection(),
            ),
            const Section(
              title: 'Experience',
              delay: 800,
              child: ExperienceSection(),
            ),
            const Section(
              title: 'Contact',
              delay: 1000,
              child: ContactSection(),
            ),
            const SizedBox(height: 32),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  const HeroSection(
      {super.key, required this.onToggleTheme, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        // Animated, layered gradient background with blur
        SizedBox(
          width: double.infinity,
          height: 480,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedGradientBackground(isDark: isDark),
              ),
              // Extra blurred overlay for glass effect
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                  child: Container(
                    color: isDark
                        ? Colors.black.withOpacity(0.25)
                        : Colors.white.withOpacity(0.18),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Theme toggle button (top right)
        Positioned(
          top: 32,
          right: 32,
          child: ThemeToggleButton(
            isDark: isDark,
            onToggle: onToggleTheme,
          ),
        ),
        // Glassmorphism card with glowing border
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 80),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.blue.shade900.withOpacity(0.18)
                      : Colors.blueGrey.withOpacity(0.10),
                  blurRadius: 48,
                  offset: const Offset(0, 16),
                ),
              ],
              border: Border.all(
                width: 2.5,
                color: Colors.transparent,
              ),
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        Colors.blueGrey.shade900.withOpacity(0.55),
                        Colors.blueGrey.shade800.withOpacity(0.45),
                        Colors.purple.shade900.withOpacity(0.25),
                      ]
                    : [
                        Colors.white.withOpacity(0.55),
                        Colors.blue.shade50.withOpacity(0.45),
                        Colors.purple.shade50.withOpacity(0.25),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile image with colored ring/glow
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: isDark
                          ? [
                              Colors.blue.shade700,
                              Colors.purple.shade700,
                              Colors.cyan.shade400,
                              Colors.blue.shade700
                            ]
                          : [
                              Colors.blue.shade300,
                              Colors.purple.shade200,
                              Colors.cyan.shade200,
                              Colors.blue.shade300
                            ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.blue.shade900.withOpacity(0.18)
                            : Colors.blue.shade100.withOpacity(0.18),
                        blurRadius: 32,
                        spreadRadius: 4,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/me.jpeg'),
                  ),
                ).animate().scale(duration: 700.ms, curve: Curves.easeOutBack),
                const SizedBox(height: 32),
                // Animated name/title
                ShimmerText(
                  text: 'Mohammed Azhar K.K',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blueGrey.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                TypewriterText(
                  text: 'Flutter Full-Stack Developer',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: isDark ? Colors.cyan.shade200 : Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                const AnimatedTagline(),
                const SizedBox(height: 24),
                const Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  children: [
                    SocialIcon(
                      icon: FontAwesomeIcons.linkedin,
                      url: 'https://linkedin.com/in/your-link',
                      tooltip: 'LinkedIn',
                    ),
                    SocialIcon(
                      icon: FontAwesomeIcons.github,
                      url: 'https://github.com/your-github',
                      tooltip: 'GitHub',
                    ),
                    SocialIcon(
                      icon: Icons.email,
                      url: 'mailto:azramn007@gmail.com',
                      tooltip: 'Email',
                    ),
                    SocialIcon(
                      icon: Icons.phone,
                      url: 'tel:+918301816993',
                      tooltip: 'Call',
                    ),
                  ],
                ).animate().fadeIn(duration: 700.ms, delay: 600.ms),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedGradientBackground extends StatelessWidget {
  final bool isDark;
  const AnimatedGradientBackground({required this.isDark, super.key});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(seconds: 10),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      Colors.blueGrey.shade900,
                      Colors.purple.shade900,
                      Colors.blueGrey.shade800,
                    ]
                  : [
                      Colors.blue.shade100,
                      Colors.purple.shade50,
                      Colors.cyan.shade50,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, value * 0.5 + 0.2, 1.0],
            ),
          ),
        );
      },
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;
  const ThemeToggleButton(
      {required this.isDark, required this.onToggle, super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onToggle,
        child: AnimatedContainer(
          duration: 250.ms,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.blueGrey.shade900.withOpacity(0.7)
                : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.blue.shade900.withOpacity(0.12)
                    : Colors.blue.shade100.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isDark ? Colors.cyan.shade200 : Colors.blue.shade200,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                  color: isDark ? Colors.cyan.shade200 : Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(isDark ? 'Dark' : 'Light',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? Colors.cyan.shade200
                          : Colors.blue.shade700)),
            ],
          ),
        ),
      ),
    );
  }
}

// Animated moving blob widget
class AnimatedBlob extends StatefulWidget {
  final Color color;
  final double size;
  final int duration;
  const AnimatedBlob(
      {required this.color,
      required this.size,
      required this.duration,
      super.key});
  @override
  State<AnimatedBlob> createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<AnimatedBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.95, end: 1.08)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              // Soft blur
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.2),
                  blurRadius: 32,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Shimmer text animation
class ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ShimmerText({required this.text, required this.style, super.key});
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.blue.shade300,
          Colors.purple.shade200,
          Colors.blue.shade300
        ],
        stops: const [0.1, 0.5, 0.9],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        tileMode: TileMode.mirror,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    ).animate().shimmer(duration: 1800.ms);
  }
}

// Typewriter text animation
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const TypewriterText({required this.text, required this.style, super.key});
  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1200.ms)
      ..forward();
    _charCount = StepTween(begin: 0, end: widget.text.length)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (context, child) {
        return Text(widget.text.substring(0, _charCount.value),
            style: widget.style);
      },
    );
  }
}

class AnimatedTagline extends StatefulWidget {
  const AnimatedTagline({super.key});

  @override
  State<AnimatedTagline> createState() => _AnimatedTaglineState();
}

class _AnimatedTaglineState extends State<AnimatedTagline>
    with SingleTickerProviderStateMixin {
  final List<String> taglines = [
    'Building beautiful cross-platform apps',
    'API integration specialist',
    'Minimal, scalable, robust code',
    'Delivering seamless user experiences',
  ];
  late AnimationController _controller;
  late Animation<double> _fade;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1.seconds);
    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);
    _cycle();
  }

  void _cycle() async {
    while (mounted) {
      await _controller.forward();
      await Future.delayed(1.5.seconds);
      await _controller.reverse();
      setState(() => _index = (_index + 1) % taglines.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Text(
        taglines[_index],
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.blueGrey.shade600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  const SocialIcon(
      {required this.icon,
      required this.url,
      required this.tooltip,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => _launchUrl(url),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.blue.shade700, size: 22),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final int delay;
  const Section(
      {required this.title, required this.child, this.delay = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 900),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: delay.ms),
          const SizedBox(height: 16),
          child.animate().fadeIn(duration: 600.ms, delay: (delay + 100).ms),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      'Aspiring Flutter Full-Stack Developer with a passion for building beautiful, scalable, and robust cross-platform apps. I focus on seamless user experiences, direct API integration, and minimal, maintainable code. Let\'s build something amazing together!',
      style: GoogleFonts.poppins(
          fontSize: 18, color: Colors.blueGrey.shade700, height: 1.6),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        title: 'Kool Minder',
        description:
            'Custom navigation, async data, performance-optimized UI, clean architecture.',
        link: 'https://play.google.com/store/apps/details?id=your.app',
        tags: ['Flutter', 'Async', 'UI', 'Architecture'],
        icon: FontAwesomeIcons.mobileScreenButton,
      ),
      Project(
        title: 'Al-muqtadir Shopping App',
        description:
            'Dynamic routing, robust API, error handling, scalable architecture.',
        link: 'https://apps.apple.com/app/idXXXXXXXX',
        tags: ['Flutter', 'GoRouter', 'API', 'E-commerce'],
        icon: FontAwesomeIcons.cartShopping,
      ),
      Project(
        title: 'SwapX (ongoing)',
        description:
            'Modern barter system, community-driven, inventory management.',
        link: '',
        tags: ['Flutter', 'Community', 'Inventory'],
        icon: FontAwesomeIcons.arrowsRotate,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AnimatedSectionHeader(title: 'Projects'),
        const SizedBox(height: 24),
        Wrap(
          spacing: 32,
          runSpacing: 32,
          children: projects
              .asMap()
              .entries
              .map((entry) => ProjectCard(
                    project: entry.value,
                    delay: entry.key * 150,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class AnimatedSectionHeader extends StatelessWidget {
  final String title;
  const AnimatedSectionHeader({required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade200,
                  Colors.purple.shade100,
                  Colors.blue.shade50
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 200.ms)
              .slideX(begin: 0.2, end: 0),
        ),
      ],
    );
  }
}

class Project {
  final String title;
  final String description;
  final String link;
  final List<String> tags;
  final IconData icon;
  Project(
      {required this.title,
      required this.description,
      required this.link,
      required this.tags,
      required this.icon});
}

class ProjectCard extends StatefulWidget {
  final Project project;
  final int delay;
  const ProjectCard({required this.project, this.delay = 0, super.key});
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.project.link.isNotEmpty
            ? () => _launchUrl(widget.project.link)
            : null,
        child: AnimatedContainer(
          duration: 300.ms,
          width: 300,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? Colors.blue.withOpacity(0.13)
                    : Colors.blueGrey.withOpacity(0.07),
                blurRadius: _hovered ? 32 : 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
                color: _hovered ? Colors.blue.shade200 : Colors.blue.shade50,
                width: 2.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.project.icon,
                    color: Colors.blue.shade400, size: 32),
              ),
              const SizedBox(height: 18),
              Text(
                widget.project.title,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900),
              ),
              const SizedBox(height: 8),
              Text(
                widget.project.description,
                style: GoogleFonts.poppins(
                    fontSize: 15, color: Colors.blueGrey.shade600),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                children: widget.project.tags
                    .map((tag) => Chip(
                          label: Text(tag,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.blue.shade700)),
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ))
                    .toList(),
              ),
              if (widget.project.link.isNotEmpty) ...[
                const SizedBox(height: 18),
                AnimatedButton(
                  hovered: _hovered,
                  onTap: () => _launchUrl(widget.project.link),
                ),
              ],
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: widget.delay.ms)
            .slideY(begin: 0.1, end: 0),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final bool hovered;
  final VoidCallback onTap;
  const AnimatedButton({required this.hovered, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 250.ms,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: hovered ? Colors.blue.shade700 : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (hovered)
              BoxShadow(
                color: Colors.blue.shade200.withOpacity(0.18),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.open_in_new,
                size: 16, color: hovered ? Colors.white : Colors.blue.shade700),
            const SizedBox(width: 8),
            Text('View Project',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: hovered ? Colors.white : Colors.blue.shade700,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final topSkills = [
      SkillBarData('Flutter', 0.95, Colors.blue),
      SkillBarData('Dart', 0.92, Colors.blueAccent),
      SkillBarData('REST API', 0.88, Colors.purple),
      SkillBarData('Riverpod', 0.85, Colors.cyan),
      SkillBarData('Git', 0.83, Colors.deepPurple),
    ];
    final otherSkills = [
      'C',
      'GitHub',
      'Bloc',
      'MVC',
      'MVVM',
      'Clean Architecture',
      'Serverpod',
      'Postman',
      'ObjectBox',
      'OneSignal',
      'Firebase Auth',
      'Cloud Messaging',
      'Functions',
      'Firestore',
      'Push Notifications',
      'Local Notification',
      'Getx',
      'Provider',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AnimatedSectionHeader(title: 'Skills'),
        const SizedBox(height: 32),
        // Top skills as animated progress bars
        ...topSkills.asMap().entries.map((entry) => AnimatedSkillBar(
              data: entry.value,
              delay: entry.key * 200,
            )),
        const SizedBox(height: 32),
        // Other skills as animated chips
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              otherSkills.map((s) => AnimatedSkillChip(skill: s)).toList(),
        ),
      ],
    );
  }
}

class SkillBarData {
  final String label;
  final double value;
  final Color color;
  SkillBarData(this.label, this.value, this.color);
}

class AnimatedSkillBar extends StatelessWidget {
  final SkillBarData data;
  final int delay;
  const AnimatedSkillBar({required this.data, this.delay = 0, super.key});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: data.value),
      duration: 900.ms,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data.label,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey.shade900),
                ),
                const SizedBox(width: 12),
                Text('${(value * 100).toInt()}%',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.blueGrey.shade400)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.13),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value,
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: data.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedSkillChip extends StatelessWidget {
  final String skill;
  const AnimatedSkillChip({required this.skill, super.key});
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill,
          style: GoogleFonts.poppins(
              color: Colors.blue.shade700, fontWeight: FontWeight.w500)),
      backgroundColor: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack);
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});
  @override
  Widget build(BuildContext context) {
    final jobs = [
      ExperienceData(
        title: 'Full-stack Developer',
        company: 'LevelX',
        period: '11/2023 – 9/2024',
        location: 'Kozhikode, Kerala, India',
        details: [
          'Proficient in developing high-performance, scalable, and user-friendly mobile applications using Flutter and Dart.',
          'Worked closely with multidisciplinary teams to integrate UI/UX designs, enriching the overall user journey and interaction.',
          'Skilled in Dart programming language, utilizing industry best practices in mobile development to optimize code efficiency.',
          'Performed comprehensive code inspections, pinpointing and remedying bugs to elevate application stability and reliability through meticulous review processes.',
        ],
      ),
      ExperienceData(
        title: 'Flutter Developer',
        company: 'Green Creon LLP',
        period: '9/2024 – present',
        location: 'Trivandrum, Kerala, India',
        details: [
          'Gained hands-on experience in building and deploying cross-platform mobile applications for both iOS and Android using Flutter and Dart.',
          'Worked on 7 live projects/applications, ensuring seamless performance and consistent UI across platforms.',
          'Integrated third-party libraries and SDKs for features like maps, payment gateways, social logins, and analytics.',
          'Published apps on Google Play Store and Apple App Store, following platform-specific guidelines.',
        ],
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AnimatedSectionHeader(title: 'Experience'),
        const SizedBox(height: 32),
        Timeline(jobs: jobs),
      ],
    );
  }
}

class ExperienceData {
  final String title, company, period, location;
  final List<String> details;
  ExperienceData(
      {required this.title,
      required this.company,
      required this.period,
      required this.location,
      required this.details});
}

class Timeline extends StatelessWidget {
  final List<ExperienceData> jobs;
  const Timeline({required this.jobs, super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: jobs.asMap().entries.map((entry) {
        final isLast = entry.key == jobs.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 4,
                    height: 60,
                    color: Colors.blue.shade100,
                  ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ExperienceCard(
                data: entry.value,
                delay: entry.key * 200,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final ExperienceData data;
  final int delay;
  const ExperienceCard({required this.data, this.delay = 0, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.blue.shade50, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade900)),
          const SizedBox(height: 4),
          Text(data.company,
              style: GoogleFonts.poppins(
                  fontSize: 16, color: Colors.blue.shade700)),
          const SizedBox(height: 4),
          Text('${data.period} • ${data.location}',
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.blueGrey.shade400)),
          const SizedBox(height: 12),
          ...data.details
              .map((d) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(fontSize: 18, color: Colors.blue)),
                      Expanded(
                          child: Text(d,
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.blueGrey.shade700))),
                    ],
                  ))
              .toList(),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: delay.ms)
        .slideY(begin: 0.1, end: 0);
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AnimatedSectionHeader(title: 'Contact'),
        const SizedBox(height: 32),
        Center(
          child: GlassCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Let\'s connect!',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade900),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'I\'m open to new opportunities, collaborations, and interesting projects. Feel free to reach out!',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.blueGrey.shade700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 24,
                    children: [
                      AnimatedContactIcon(
                        icon: FontAwesomeIcons.linkedin,
                        url: 'https://linkedin.com/in/your-link',
                        tooltip: 'LinkedIn',
                        color: Colors.blue.shade700,
                      ),
                      AnimatedContactIcon(
                        icon: FontAwesomeIcons.github,
                        url: 'https://github.com/your-github',
                        tooltip: 'GitHub',
                        color: Colors.blueGrey.shade900,
                      ),
                      AnimatedContactIcon(
                        icon: Icons.email,
                        url: 'mailto:azramn007@gmail.com',
                        tooltip: 'Email',
                        color: Colors.red.shade400,
                      ),
                      AnimatedContactIcon(
                        icon: Icons.phone,
                        url: 'tel:+918301816993',
                        tooltip: 'Call',
                        color: Colors.green.shade400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'azramn007@gmail.com',
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: Colors.blueGrey.shade500),
                  ),
                  Text(
                    '+91 8301816993',
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: Colors.blueGrey.shade500),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),
        ),
      ],
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
        backgroundBlendMode: BlendMode.overlay,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: child,
        ),
      ),
    );
  }
}

class AnimatedContactIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  final Color color;
  const AnimatedContactIcon(
      {required this.icon,
      required this.url,
      required this.tooltip,
      required this.color,
      super.key});
  @override
  State<AnimatedContactIcon> createState() => _AnimatedContactIconState();
}

class _AnimatedContactIconState extends State<AnimatedContactIcon> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _launchUrl(widget.url),
        child: AnimatedContainer(
          duration: 250.ms,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _hovered ? widget.color.withOpacity(0.13) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: widget.color.withOpacity(0.18),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
            ],
            border: Border.all(
                color: _hovered
                    ? widget.color.withOpacity(0.4)
                    : Colors.blue.shade50,
                width: 2),
          ),
          child: Icon(widget.icon,
              color: _hovered ? widget.color : Colors.blueGrey.shade400,
              size: 28),
        ).animate().scale(duration: 350.ms, curve: Curves.easeOutBack),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated gradient bar
        const SizedBox(
          width: double.infinity,
          height: 12,
          child: AnimatedGradientBar(),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          color: Colors.blue.shade50.withOpacity(0.85),
          child: Center(
            child: Text(
              '© 2024 Mohammed Azhar K.K • Built with Flutter',
              style: GoogleFonts.poppins(
                  fontSize: 15, color: Colors.blueGrey.shade400),
            ),
          ),
        ).animate().fadeIn(duration: 900.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }
}

class AnimatedGradientBar extends StatefulWidget {
  const AnimatedGradientBar({super.key});

  @override
  State<AnimatedGradientBar> createState() => _AnimatedGradientBarState();
}

class _AnimatedGradientBarState extends State<AnimatedGradientBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade300,
                Colors.purple.shade200,
                Colors.cyan.shade200,
                Colors.blue.shade100,
              ],
              stops: [
                0.0 + 0.2 * _controller.value,
                0.3 + 0.2 * _controller.value,
                0.7 - 0.2 * _controller.value,
                1.0 - 0.2 * _controller.value,
              ],
              begin: Alignment(-1 + 2 * _controller.value, 0),
              end: Alignment(1 - 2 * _controller.value, 0),
            ),
          ),
        );
      },
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
