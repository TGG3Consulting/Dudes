import 'package:flutter/material.dart';

abstract class AppColors {
  // --- Backgrounds ---
  static const Color bgBaseLight     = Color(0xFFFFFFFF);
  static const Color bgBaseDark      = Color(0xFF0A0A0A);
  static const Color bgRaisedLight   = Color(0xFFF5F5F5);
  static const Color bgRaisedDark    = Color(0xFF151515);
  static const Color bgOverlayLight  = Color(0xFFFFFFFF);
  static const Color bgOverlayDark   = Color(0xFF1F1F1F);
  static const Color bgInverseLight  = Color(0xFF0A0A0A);
  static const Color bgInverseDark   = Color(0xFFFFFFFF);

  // --- Lines ---
  static const Color lineLight       = Color(0xFFE5E5E5);
  static const Color lineDark        = Color(0xFF2A2A2A);
  static const Color lineStrongLight = Color(0xFFC8C8C8);
  static const Color lineStrongDark  = Color(0xFF3F3F3F);

  // --- Ink (text) ---
  static const Color inkLight        = Color(0xFF0A0A0A);
  static const Color inkDark         = Color(0xFFFFFFFF);
  static const Color inkMutedLight   = Color(0xFF5E5E5E);
  static const Color inkMutedDark    = Color(0xFFADADAD);
  static const Color inkFaintLight   = Color(0xFF8C8C8C);
  static const Color inkFaintDark    = Color(0xFF7A7A7A);
  static const Color inkInverseLight = Color(0xFFFFFFFF);
  static const Color inkInverseDark  = Color(0xFF0A0A0A);

  // --- Accent (orange — identical in both themes) ---
  static const Color accent          = Color(0xFFFF9100);
  static const Color accentPressed   = Color(0xFFD97A00);
  static const Color accentWashLight = Color(0x1FFF9100);
  static const Color accentWashDark  = Color(0x24FF9100);
  static const Color accentInkLight  = Color(0xFF9C5200);
  static const Color accentInkDark   = Color(0xFFFFA338);
  static const Color onAccent        = Color(0xFF0A0A0A);
  static const Color focusLight      = Color(0xFF9C5200);
  static const Color focusDark       = Color(0xFFFFA338);

  // --- Skeleton / Scrim ---
  static const Color skeletonLight   = Color(0xFFECECEC);
  static const Color skeletonDark    = Color(0xFF1C1C1C);
  static const Color scrimLight      = Color(0x990A0A0A);
  static const Color scrimDark       = Color(0xCC0A0A0A);

  // --- Error ---
  static const Color errorLight      = Color(0xFFB91C1C);
  static const Color errorDark       = Color(0xFFF87171);
  static const Color errorFill       = Color(0xFFEF4444);
  static const Color errorWashLight  = Color(0x19EF4444);
  static const Color errorWashDark   = Color(0x24EF4444);

  // --- Success ---
  static const Color successLight    = Color(0xFF15803D);
  static const Color successDark     = Color(0xFF4ADE80);
  static const Color successFill     = Color(0xFF22C55E);
  static const Color successWashLight = Color(0x1922C55E);
  static const Color successWashDark  = Color(0x2422C55E);
  static const Color onSignal        = Color(0xFF0A0A0A);

  // --- Status: pending ---
  static const Color statusPendingLight     = Color(0xFF5E5E5E);
  static const Color statusPendingDark      = Color(0xFFADADAD);
  static const Color statusPendingWashLight = Color(0x195E5E5E);
  static const Color statusPendingWashDark  = Color(0x1FADADAD);

  // --- Status: done ---
  static const Color statusDoneLight     = Color(0xFF0A0A0A);
  static const Color statusDoneDark      = Color(0xFFFFFFFF);
  static const Color statusDoneWashLight = Color(0x0F0A0A0A);
  static const Color statusDoneWashDark  = Color(0x1AFFFFFF);
}
