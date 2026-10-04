import 'package:flutter/material.dart';
import 'package:dudes_barber/core/utils/placeholder_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryId;
  const ProductListScreen({super.key, required this.categoryId});
  @override
  Widget build(BuildContext context) =>
      const PlaceholderScreen(screenId: 'E-02', screenName: 'Product List');
}
