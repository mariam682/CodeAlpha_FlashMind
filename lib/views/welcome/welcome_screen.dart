import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../home/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _card1Ctrl;
  late AnimationController _card2Ctrl;
  late AnimationController _card3Ctrl;
  late AnimationController _bottomCtrl;

  late Animation<double> _card1Anim;
  late Animation<double> _card2Anim;
  late Animation<double> _card3Anim;
  late Animation<double> _bottomAnim;

  @override
  void initState() {
    super.initState();
    _card1Ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _card2Ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _card3Ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _bottomCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _card1Anim = CurvedAnimation(parent: _card1Ctrl, curve: Curves.easeOut);
    _card2Anim = CurvedAnimation(parent: _card2Ctrl, curve: Curves.easeOut);
    _card3Anim = CurvedAnimation(parent: _card3Ctrl, curve: Curves.easeOut);
    _bottomAnim = CurvedAnimation(parent: _bottomCtrl, curve: Curves.easeOut);

    Future.delayed(const Duration(milliseconds: 200), () => _card1Ctrl.forward());
    Future.delayed(const Duration(milliseconds: 400), () => _card2Ctrl.forward());
    Future.delayed(const Duration(milliseconds: 600), () => _card3Ctrl.forward());
    Future.delayed(const Duration(milliseconds: 700), () => _bottomCtrl.forward());
  }

  @override
  void dispose() {
    _card1Ctrl.dispose();
    _card2Ctrl.dispose();
    _card3Ctrl.dispose();
    _bottomCtrl.dispose();
    super.dispose();
  }

  Widget _buildFloatingCard({
    required Animation<double> anim,
    required String question,
    required String answer,
    required double left,
    required double top,
    required double rotation,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(anim),
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    answer,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.welcomeGradient,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Floating cards
              _buildFloatingCard(
                anim: _card1Anim,
                question: 'What is gravity?',
                answer: 'A fundamental force',
                left: 16,
                top: 40,
                rotation: -0.08,
              ),
              _buildFloatingCard(
                anim: _card2Anim,
                question: 'Capital of Japan?',
                answer: 'Tokyo',
                left: size.width * 0.4,
                top: 90,
                rotation: 0.06,
              ),
              _buildFloatingCard(
                anim: _card3Anim,
                question: 'H₂O stands for?',
                answer: 'Water',
                left: 20,
                top: size.height * 0.35,
                rotation: -0.04,
              ),

              // Bottom content
              Align(
                alignment: Alignment.bottomCenter,
                child: FadeTransition(
                  opacity: _bottomAnim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(_bottomAnim),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'FlashMind',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Study smarter, remember longer.\nYour personal learning companion.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get Started',
                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward,
                                      color: AppColors.primaryDark, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
