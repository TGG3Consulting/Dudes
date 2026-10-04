import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_spacing.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  static const _slides = [
    (
      icon: Icons.content_cut,
      title: 'Стрижки от лучших мастеров',
      body: 'Опытные барберы, актуальные стили. Всё в одном месте.',
    ),
    (
      icon: Icons.calendar_today_outlined,
      title: 'Онлайн-запись 24/7',
      body: 'Бронируй время в любой момент — без звонков и ожиданий.',
    ),
    (
      icon: Icons.stars_outlined,
      title: 'Бонусы за каждый визит',
      body: 'Накапливай баллы и получай скидки на стрижки.',
    ),
  ];

  Future<void> _onGetStarted(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (context.mounted) context.go('/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          slide.icon,
                          size: 80,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.s6),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s3),
                        Text(
                          slide.body,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (index) {
                final isActive = index == _currentPage;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s1,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? colorScheme.primary
                          : colorScheme.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.s4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _slides.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _onGetStarted(context);
                    }
                  },
                  child: Text(
                    _currentPage < _slides.length - 1 ? 'Далее' : 'Начать',
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
          ],
        ),
      ),
    );
  }
}
