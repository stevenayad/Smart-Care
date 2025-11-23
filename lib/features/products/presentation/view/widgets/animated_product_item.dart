import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';
import 'package:smartcare/features/products/presentation/view/widgets/product_item.dart';
import 'package:smartcare/features/home/presentation/views/details_screen.dart';

class AnimatedProductItem extends StatefulWidget {
  final ProductModel product;

  const AnimatedProductItem({super.key, required this.product});

  @override
  State<AnimatedProductItem> createState() => _AnimatedProductItemState();
}

class _AnimatedProductItemState extends State<AnimatedProductItem> {
  bool _animationPlayed = false;
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('product_item_${widget.product.productId}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.1 && !_animationPlayed) {
          setState(() {
            _animationPlayed = true;
            _controller.forward();
          });
        }
      },
      child:
          Animate(
                autoPlay: false,
                onInit: (controller) => _controller = controller,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailsScreen(Productid: widget.product.productId),
                      ),
                    );
                  },
                  child: ProductItem(
                    imageUrl: widget.product.primaryImageUrl,
                    title: widget.product.nameEn,
                    brand: widget.product.activeIngredients,
                    rating: widget.product.averageRating,
                    price: widget.product.price,
                    onAdd: () {},
                    onFavorite: () {},
                  ),
                ),
              )
              .fadeIn(duration: const Duration(milliseconds: 700))
              .slide(
                begin: const Offset(0, 0.2),
                duration: const Duration(milliseconds: 700),
              ),
    );
  }
}
