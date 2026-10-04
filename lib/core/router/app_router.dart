import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/ui/splash_screen.dart';
import '../../features/auth/ui/onboarding_screen.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/register_screen.dart';
import '../../features/auth/ui/email_verification_screen.dart';
import '../../features/auth/ui/forgot_password_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/locations/ui/location_picker_screen.dart';
import '../../features/booking/ui/service_selection_screen.dart';
import '../../features/booking/ui/barber_selection_screen.dart';
import '../../features/booking/ui/date_time_picker_screen.dart';
import '../../features/booking/ui/booking_confirmation_screen.dart';
import '../../features/booking/ui/booking_success_screen.dart';
import '../../features/booking/ui/my_bookings_screen.dart';
import '../../features/booking/ui/booking_detail_screen.dart';
import '../../features/shop/catalog/ui/shop_home_screen.dart';
import '../../features/shop/catalog/ui/product_list_screen.dart';
import '../../features/shop/catalog/ui/product_detail_screen.dart';
import '../../features/shop/cart/ui/cart_screen.dart';
import '../../features/shop/checkout/ui/checkout_screen.dart';
import '../../features/shop/checkout/ui/order_success_screen.dart';
import '../../features/shop/checkout/ui/order_history_screen.dart';
import '../../features/shop/checkout/ui/order_detail_screen.dart';
import '../../features/bonuses/ui/bonuses_screen.dart';
import '../../features/bonuses/ui/loyalty_tiers_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/profile/ui/edit_profile_screen.dart';
import '../../features/profile/ui/change_password_screen.dart';
import '../../features/profile/ui/settings_screen.dart';
import '../../features/profile/ui/notification_center_screen.dart';
import '../../features/admin/ui/admin_dashboard_screen.dart';
import '../../features/admin/users/ui/clients_list_screen.dart';
import '../../features/admin/users/ui/client_detail_screen.dart';
import '../../features/admin/users/ui/bonus_adjustment_screen.dart';
import '../../features/admin/visits/ui/visit_confirmation_screen.dart';
import '../../features/admin/visits/ui/visits_history_screen.dart';
import '../../features/admin/orders/ui/admin_orders_screen.dart';
import '../../features/admin/orders/ui/admin_order_detail_screen.dart';
import '../../features/admin/shop_mgmt/ui/admin_products_screen.dart';
import '../../features/admin/shop_mgmt/ui/product_form_screen.dart';
import '../../features/admin/shop_mgmt/ui/product_categories_screen.dart';
import '../../features/admin/campaigns/ui/campaigns_list_screen.dart';
import '../../features/admin/campaigns/ui/create_campaign_screen.dart';
import '../../features/admin/campaigns/ui/campaign_stats_screen.dart';
import '../../features/admin/reminders/ui/reminder_settings_screen.dart';
import '../../features/admin/reminders/ui/reminder_form_screen.dart';
import '../../features/admin/locations/ui/admin_locations_screen.dart';
import '../../features/admin/locations/ui/location_form_screen.dart';
import '../../features/admin/loyalty/ui/loyalty_tiers_admin_screen.dart';
import '../../features/admin/loyalty/ui/loyalty_tier_form_screen.dart';
import '../../features/admin/settings/ui/app_settings_screen.dart';

// Stub providers — replaced in Phase 1
// TODO Phase 1: заменить на реальный auth state
final isAuthenticatedProvider = Provider<bool>((ref) => true);
final isAdminProvider = Provider<bool>((ref) => true);

final appRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final isAdmin = ref.watch(isAdminProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final path = state.matchedLocation;
      const authRoutes = ['/splash', '/onboarding', '/login', '/register', '/verify-email', '/forgot-password'];
      final isAuthRoute = authRoutes.any((r) => path == r || path.startsWith('$r/'));

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && (path == '/login' || path == '/register')) return '/home';
      if (path.startsWith('/admin') && !isAdmin) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash',          builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/onboarding',      builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/login',           builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register',        builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/verify-email',    builder: (_, __) => const EmailVerificationScreen()),
      GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),

      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/home',    builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/booking', builder: (_, __) => const ServiceSelectionScreen()),
          GoRoute(path: '/shop',    builder: (_, __) => const ShopHomeScreen()),
          GoRoute(path: '/bonuses', builder: (_, __) => const BonusesScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        ],
      ),

      GoRoute(path: '/location-picker', builder: (_, __) => const LocationPickerScreen()),

      // Booking flow
      GoRoute(path: '/booking/barber',   builder: (_, __) => const BarberSelectionScreen()),
      GoRoute(path: '/booking/datetime', builder: (_, __) => const DateTimePickerScreen()),
      GoRoute(path: '/booking/confirm',  builder: (_, __) => const BookingConfirmationScreen()),
      GoRoute(path: '/booking/success',  builder: (_, __) => const BookingSuccessScreen()),
      GoRoute(path: '/my-bookings',      builder: (_, __) => const MyBookingsScreen()),
      GoRoute(
        path: '/my-bookings/:id',
        builder: (_, state) => BookingDetailScreen(id: state.pathParameters['id']!),
      ),

      // Shop flow
      GoRoute(
        path: '/shop/category/:id',
        builder: (_, state) => ProductListScreen(categoryId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/shop/product/:id',
        builder: (_, state) => ProductDetailScreen(productId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/cart',          builder: (_, __) => const CartScreen()),
      GoRoute(path: '/checkout',      builder: (_, __) => const CheckoutScreen()),
      GoRoute(path: '/order/success', builder: (_, __) => const OrderSuccessScreen()),
      GoRoute(path: '/orders',        builder: (_, __) => const OrderHistoryScreen()),
      GoRoute(
        path: '/orders/:id',
        builder: (_, state) => OrderDetailScreen(orderId: state.pathParameters['id']!),
      ),

      // Loyalty / Profile
      GoRoute(path: '/bonuses/tiers',     builder: (_, __) => const LoyaltyTiersScreen()),
      GoRoute(path: '/profile/edit',      builder: (_, __) => const EditProfileScreen()),
      GoRoute(path: '/profile/password',  builder: (_, __) => const ChangePasswordScreen()),
      GoRoute(path: '/profile/settings',  builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/notifications',     builder: (_, __) => const NotificationCenterScreen()),

      // Admin routes
      GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardScreen()),
      GoRoute(path: '/admin/clients', builder: (_, __) => const ClientsListScreen()),
      GoRoute(
        path: '/admin/clients/:id',
        builder: (_, state) => ClientDetailScreen(clientId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/admin/clients/:id/bonus',
        builder: (_, state) => BonusAdjustmentScreen(clientId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/admin/visits',         builder: (_, __) => const VisitConfirmationScreen()),
      GoRoute(path: '/admin/visits/history', builder: (_, __) => const VisitsHistoryScreen()),
      GoRoute(path: '/admin/orders',         builder: (_, __) => const AdminOrdersScreen()),
      GoRoute(
        path: '/admin/orders/:id',
        builder: (_, state) => AdminOrderDetailScreen(orderId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/admin/products',     builder: (_, __) => const AdminProductsScreen()),
      GoRoute(path: '/admin/products/new', builder: (_, __) => const ProductFormScreen()),
      GoRoute(
        path: '/admin/products/:id',
        builder: (_, state) => ProductFormScreen(productId: state.pathParameters['id']),
      ),
      GoRoute(path: '/admin/categories',      builder: (_, __) => const ProductCategoriesScreen()),
      GoRoute(path: '/admin/campaigns',       builder: (_, __) => const CampaignsListScreen()),
      GoRoute(path: '/admin/campaigns/new',   builder: (_, __) => const CreateCampaignScreen()),
      GoRoute(
        path: '/admin/campaigns/:id',
        builder: (_, state) => CampaignStatsScreen(campaignId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/admin/reminders',     builder: (_, __) => const ReminderSettingsScreen()),
      GoRoute(path: '/admin/reminders/new', builder: (_, __) => const ReminderFormScreen()),
      GoRoute(
        path: '/admin/reminders/:id',
        builder: (_, state) => ReminderFormScreen(reminderId: state.pathParameters['id']),
      ),
      GoRoute(path: '/admin/locations',     builder: (_, __) => const AdminLocationsScreen()),
      GoRoute(path: '/admin/locations/new', builder: (_, __) => const LocationFormScreen()),
      GoRoute(
        path: '/admin/locations/:id',
        builder: (_, state) => LocationFormScreen(locationId: state.pathParameters['id']),
      ),
      GoRoute(path: '/admin/loyalty',     builder: (_, __) => const LoyaltyTiersAdminScreen()),
      GoRoute(path: '/admin/loyalty/new', builder: (_, __) => const LoyaltyTierFormScreen()),
      GoRoute(
        path: '/admin/loyalty/:id',
        builder: (_, state) => LoyaltyTierFormScreen(tierId: state.pathParameters['id']),
      ),
      GoRoute(path: '/admin/settings', builder: (_, __) => const AppSettingsScreen()),
    ],
  );
});

// Minimal shell with bottom navigation
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _indexFor(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (i) => _navigate(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),      activeIcon: Icon(Icons.home),      label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.content_cut),        activeIcon: Icon(Icons.content_cut), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), activeIcon: Icon(Icons.storefront), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.stars_outlined),     activeIcon: Icon(Icons.stars),     label: 'Bonuses'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),     activeIcon: Icon(Icons.person),    label: 'Profile'),
        ],
      ),
    );
  }

  int _indexFor(String location) {
    if (location.startsWith('/booking')) return 1;
    if (location.startsWith('/shop'))    return 2;
    if (location.startsWith('/bonuses')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _navigate(BuildContext context, int index) {
    const routes = ['/home', '/booking', '/shop', '/bonuses', '/profile'];
    context.go(routes[index]);
  }
}
