import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerPromotion extends StatelessWidget {
  const BannerPromotion({super.key});

  final List<Map<String, String>> banners = const [
    {
      "title": "Experience our\nnew delicious offer",
      "discount": "30% OFF",
      "image":
          "https://www.hwics.org.uk/application/files/2216/6420/5880/Pharmacy_Thumbnail.jpg",
    },
    {
      "title": "Fresh deals for you",
      "discount": "25% OFF",
      "image":
          "https://img.freepik.com/premium-photo/medicines-arranged-shelves-pharmacy-blurred_1234738-510715.jpg",
    },
    {
      "title": "Healthy products just arrived",
      "discount": "50% OFF",
      "image":
          "https://img.freepik.com/premium-photo/pharmacy-interior-shelves-with-medicine-boxes-products_1222783-33769.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 140,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFF97316)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              banner['title']!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              banner['discount']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        child: Image.network(
                          banner['image']!,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
