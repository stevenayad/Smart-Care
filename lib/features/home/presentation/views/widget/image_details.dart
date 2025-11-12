import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';


class ImageDetails extends StatelessWidget {
  final DetailsProductModel detialsProductModel;
  const ImageDetails({super.key, required this.detialsProductModel});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight / 2.5,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
        child: Image.network(
          detialsProductModel.data?.mainImageUrl ??
              'https://tse2.mm.bing.net/th/id/OIP.G37tgeQqSNt7v2oPfj9ltQHaE7?cb=ucfimgc2&rs=1&pid=ImgDetMain&o=7&rm=3',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
