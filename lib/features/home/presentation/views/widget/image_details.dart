import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';

class ImageDetails extends StatefulWidget {
  final DetailsProductModel detialsProductModel;

  const ImageDetails({super.key, required this.detialsProductModel});

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  int currentIndex = 0;
  late PageController controller;
  final List<String> fallbackImages = [
    'https://th.bing.com/th/id/R.829843c130c948d4fbb835dae965a5da?rik=LCpFbdcAeWDZ8w&riu=http%3a%2f%2fwallpapercave.com%2fwp%2ffAwVCh3.jpg&ehk=lGN4CaEuFMjMiZTZ2nF9id7MRRJ3e1tiWELDbLGorPE%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.829843c130c948d4fbb835dae965a5da?rik=LCpFbdcAeWDZ8w&riu=http%3a%2f%2fwallpapercave.com%2fwp%2ffAwVCh3.jpg&ehk=lGN4CaEuFMjMiZTZ2nF9id7MRRJ3e1tiWELDbLGorPE%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.829843c130c948d4fbb835dae965a5da?rik=LCpFbdcAeWDZ8w&riu=http%3a%2f%2fwallpapercave.com%2fwp%2ffAwVCh3.jpg&ehk=lGN4CaEuFMjMiZTZ2nF9id7MRRJ3e1tiWELDbLGorPE%3d&risl=&pid=ImgRaw&r=0',
  ];

  @override
  Widget build(BuildContext context) {
    final images = widget.detialsProductModel.data?.images ?? [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: fallbackImages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(fallbackImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 16,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.4),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          Positioned(
            top: 16,
            right: 16,
            child: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                final cubit = BlocProvider.of<FavouriteCubit>(context);
                final isFav = cubit.isFavourite(
                  widget.detialsProductModel.data?.productId ?? '',
                );

                return GestureDetector(
                  onTap: () {
                    cubit.toggleFavItem(
                      widget.detialsProductModel.data?.productId ?? '',
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFav
                              ? 'Removed from favourites'
                              : 'Added to favourites',
                        ),
                        backgroundColor: isFav ? Colors.red : Colors.green,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
                      size: 26,
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(fallbackImages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentIndex == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
