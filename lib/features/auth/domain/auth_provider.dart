import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ---------------------------------------------------------------------------
// Supabase client
// ---------------------------------------------------------------------------

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// ---------------------------------------------------------------------------
// Auth state stream
// ---------------------------------------------------------------------------

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

// ---------------------------------------------------------------------------
// Current user (synchronous, from current session)
// ---------------------------------------------------------------------------

final currentUserProvider = Provider<User?>((ref) {
  ref.watch(authStateProvider); // rebuild when auth changes
  return Supabase.instance.client.auth.currentUser;
});

// ---------------------------------------------------------------------------
// Is authenticated
// Fallback to synchronous currentSession during stream loading
// ---------------------------------------------------------------------------

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authAsync = ref.watch(authStateProvider);
  return authAsync.maybeWhen(
    data: (state) => state.session != null,
    orElse: () => Supabase.instance.client.auth.currentSession != null,
  );
});

// ---------------------------------------------------------------------------
// Profile (fetched from DB)
// ---------------------------------------------------------------------------

final profileProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  try {
    final response = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    return response;
  } catch (_) {
    return null;
  }
});

// ---------------------------------------------------------------------------
// Is admin (reads role from profile)
// ---------------------------------------------------------------------------

final isAdminProvider = Provider<bool>((ref) {
  final profileAsync = ref.watch(profileProvider);
  return profileAsync.maybeWhen(
    data: (profile) => profile?['role'] == 'admin',
    orElse: () => false,
  );
});

// ---------------------------------------------------------------------------
// Auth Notifier — sign in, sign up, sign out, reset password
// ---------------------------------------------------------------------------

class AuthNotifier extends AsyncNotifier<void> {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<void> build() async {}

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _client.auth.signOut();
    });
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _client.auth.resetPasswordForEmail(email);
    });
  }

  Future<void> resendVerificationEmail(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _client.auth.resend(type: OtpType.signup, email: email);
    });
  }
}

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, void>(AuthNotifier.new);
