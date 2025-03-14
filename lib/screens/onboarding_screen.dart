import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_/screens/splash_screen.dart';

import '../blocs/onboarding_bloc.dart';
import 'location_service_screen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      "title": "Welcome To Sahlah",
      "subtitle": "Enjoy A Fast And Smooth Food Delivery At Your Doorstep",
      "image": "assets/order_food.png"
    },
    {
      "title": "Get Delivery On Time",
      "subtitle":
          "Order Your Favorite Food Within The Palm Of Your Hand And The Zone Of Your Comfort",
      "image": "assets/Take_away.png"
    },
    {
      "title": "Choose Your Food",
      "subtitle":
          "Order Your Favorite Food Within The Palm Of Your Hand And The Zone Of Your Comfort",
      "image": "assets/Take_away2.png"
    },
    {
      "title": "Turn On Your Location",
      "subtitle":
          "To Continue, Let Your Device Turn On Location, Which Uses Google’s Location Service",
      "image": "assets/Take_away3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      context
                          .read<OnboardingBloc>()
                          .add(UpdatePageIndexEvent(index));
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(pages[index]["image"]!, height: 300),
                            const SizedBox(height: 20),

                            Text(
                              pages[index]["title"]!,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 10),
                            Text(
                              pages[index]["subtitle"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 30), //spacing
                            // continue botton
                            if (index < pages.length - 1)
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<OnboardingBloc>()
                                      .add(NextPageEvent());
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size(307, 48), //  Figma
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),

                            //yes or no thanks
                            if (index == pages.length - 1) ...[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  minimumSize: const Size(307, 48), // Figma
                                ),
                                child: const Text(
                                  "Yes, Turn It On",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Location access denied.")),
                                  );
                                },
                                child: const Text("No, Thanks",
                                    style: TextStyle(fontSize: 16.0)),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Bar
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<OnboardingBloc>().add(SkipEvent());
                          _pageController.jumpToPage(pages.length - 1);
                        },
                        child: const Text("Skip"),
                      ),
                      Row(
                        children: List.generate(
                          pages.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context
                                            .watch<OnboardingBloc>()
                                            .state
                                            .pageIndex ==
                                        index
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          int currentIndex =
                              context.read<OnboardingBloc>().state.pageIndex;
                          if (currentIndex < pages.length - 1) {
                            context.read<OnboardingBloc>().add(NextPageEvent());
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
