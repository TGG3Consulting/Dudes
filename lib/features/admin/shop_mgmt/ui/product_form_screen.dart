import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class ProductFormScreen extends StatelessWidget {
  final String? productId;
  const ProductFormScreen({super.key, this.productId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'H-10', screenName: 'Product Form');
}
