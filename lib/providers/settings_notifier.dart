import 'package:agropal/repository/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider =
    Provider<SettingsRepository>((ref) => SettingsRepository());
