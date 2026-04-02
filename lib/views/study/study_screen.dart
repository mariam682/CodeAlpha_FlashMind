import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../viewmodels/flashcard_viewmodel.dart';
import '../../widgets/flip_card.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  int _currentIndex = 0;
  bool _isFlipped = false;

  void _goNext(int total) {
    if (_currentIndex < total - 1) {
      setState(() {
        _currentIndex++;
        _isFlipped = false;
      });
    }
  }

  void _goPrev() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _isFlipped = false;
      });
    }
  }

  void _flip() {
    setState(() => _isFlipped = !_isFlipped);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FlashcardViewModel>();
    final cards = vm.cards;
    final total = cards.length;

    if (total == 0) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.layers_clear,
                  color: AppColors.primary, size: 64),
              const SizedBox(height: 16),
              const Text(
                'No cards yet!',
                style: TextStyle(
                    color: AppColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text('Add some cards to start studying.',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Go Back',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    final card = cards[_currentIndex];
    final progress = (_currentIndex + 1) / total;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Top bar
              Row(
                children: [
                  _circleBtn(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Study',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 16),

              // Progress
              Text(
                '${_currentIndex + 1} / $total',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: AppColors.border,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const SizedBox(height: 28),

              // Flip card
              FlipCard(
                question: card.question,
                answer: card.answer,
                isFlipped: _isFlipped,
                onTap: _flip,
              ),
              const SizedBox(height: 24),

              // Show Answer button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _flip,
                  icon: Icon(
                    _isFlipped ? Icons.check_circle : Icons.visibility,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: Text(
                    _isFlipped ? 'Answer Revealed' : 'Show Answer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _currentIndex > 0 ? _goPrev : null,
                    icon: const Icon(Icons.chevron_left, size: 20),
                    label: const Text('Previous'),
                    style: TextButton.styleFrom(
                      foregroundColor: _currentIndex > 0
                          ? AppColors.text
                          : AppColors.border,
                    ),
                  ),
                  // Dots
                  Row(
                    children: List.generate(
                      total > 7 ? 7 : total,
                      (i) {
                        final idx = total > 7
                            ? (_currentIndex - 3 + i).clamp(0, total - 1)
                            : i;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: idx == _currentIndex ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: idx == _currentIndex
                                ? AppColors.primary
                                : AppColors.border,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton.icon(
                    onPressed:
                        _currentIndex < total - 1 ? () => _goNext(total) : null,
                    icon: const Icon(Icons.chevron_right, size: 20),
                    label: const Text('Next'),
                    style: TextButton.styleFrom(
                      foregroundColor: _currentIndex < total - 1
                          ? AppColors.text
                          : AppColors.border,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleBtn(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.text, size: 20),
      ),
    );
  }
}
