import 'package:flutter/material.dart';

class PaymentMethod {
  final String name;
  final String subtitle;
  final IconData? icon;
  final String? image;
  final bool isSelected;

  PaymentMethod({
    required this.name,
    required this.subtitle,
    this.icon,
    this.image,
    this.isSelected = false,
  });
}

extension PaymentCopy on PaymentMethod {
  PaymentMethod copyWith({
    String? name,
    String? subtitle,
    IconData? icon,
    String? image,
    bool? isSelected,
  }) {
    return PaymentMethod(
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
