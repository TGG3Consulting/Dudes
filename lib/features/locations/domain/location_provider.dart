import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocationModel {
  final String id;
  final String name;
  final String address;
  final String city;
  final String? phone;
  final Map<String, dynamic>? workingHours;
  final String? photoUrl;
  final int? altegioBranchId;

  const LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    this.phone,
    this.workingHours,
    this.photoUrl,
    this.altegioBranchId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        city: json['city'] as String? ?? 'Ереван',
        phone: json['phone'] as String?,
        workingHours: json['working_hours'] as Map<String, dynamic>?,
        photoUrl: json['photo_url'] as String?,
        altegioBranchId: json['altegio_branch_id'] as int?,
      );
}

final locationsProvider = FutureProvider<List<LocationModel>>((ref) async {
  final response = await Supabase.instance.client
      .from('locations')
      .select()
      .eq('is_active', true)
      .order('sort_order');
  return (response as List)
      .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
      .toList();
});

final selectedLocationProvider = StateProvider<LocationModel?>((ref) => null);
