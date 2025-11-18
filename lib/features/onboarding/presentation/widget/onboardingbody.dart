import 'package:flutter/material.dart';
import 'package:smartcare/features/onboarding/data/models/onboarding_model.dart';
import 'package:smartcare/features/onboarding/presentation/widget/anmationbot.dart';
import 'package:smartcare/features/onboarding/presentation/widget/rowbutton.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 🩺 Updated onboarding data for a medical/healthcare app
    List<Onboardingitem> items = [
      Onboardingitem(
        image: 'https://cdn-icons-png.flaticon.com/512/4320/4320342.png',
        title: 'Consult with Experts',
        descrption:
            'Chat with certified doctors and get instant advice anytime, anywhere.',
      ),
      Onboardingitem(
        image: 'https://cdn-icons-png.flaticon.com/512/2966/2966485.png',
        title: 'Stay Healthy Every Day',
        descrption:
            'Receive personalized health tips and reminders to maintain a balanced lifestyle.',
      ),
    ];

    return Stack(
      children: [
        PageView.builder(
          itemCount: items.length,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(height: 60),

                Image.network(
                  items[index].image,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  items[index].title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    items[index].descrption,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white70 : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 80,
          child: AnimationDots(
            currentIndex: currentIndex,
            itemsLength: items.length,
            isDark: isDark,
          ),
        ),

        Rowbutton(
          isDark: isDark,
          currentIndex: currentIndex,
          itemsLength: items.length,
          pageController: pageController,
        ),
      ],
    );
  }
}
