import 'package:flutter/material.dart';

class LoaderManager {
  static final LoaderManager _instance = LoaderManager._internal();
  factory LoaderManager() => _instance;
  LoaderManager._internal();

  OverlayEntry? _overlayEntry;

  // Define a global key for the navigator
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showLoader() {
    if (_overlayEntry != null) return; // Prevent multiple overlays

    _overlayEntry = OverlayEntry(
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  void hideLoader() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
