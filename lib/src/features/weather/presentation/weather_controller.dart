import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/core/model/settings.dart';
import '../../settings/presentation/settings_controller.dart';
import '../core/model/air_quality.dart';
import '../core/model/hourly_forecast.dart';
import '../core/model/location_point.dart';
import '../core/model/sun_cycle.dart';
import '../data/weather_repository_impl.dart';
import '../domain/weather_repository.dart';

class WeatherState {
  final bool isLoading;
  final String? error;
  final LocationPoint? location;
  final HourlyForecast? hourly;
  final SunCycle? sunCycle;
  final AirQuality? airQuality;

  const WeatherState({
    this.isLoading = false,
    this.error,
    this.location,
    this.hourly,
    this.sunCycle,
    this.airQuality,
  });

  WeatherState copyWith({
    bool? isLoading,
    String? error,
    LocationPoint? location,
    HourlyForecast? hourly,
    SunCycle? sunCycle,
    AirQuality? airQuality,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      location: location ?? this.location,
      hourly: hourly ?? this.hourly,
      sunCycle: sunCycle ?? this.sunCycle,
      airQuality: airQuality ?? this.airQuality,
    );
  }
}

final weatherControllerProvider = StateNotifierProvider<WeatherController, WeatherState>((ref) {
  final repo = ref.watch(weatherRepositoryProvider);
  final controller = WeatherController(ref, repo);
  controller.bootstrap(ref.read(settingsControllerProvider));
  ref.listen<Settings>(settingsControllerProvider, (prev, next) {
    controller.onSettingsChanged(next);
  });
  return controller;
});

class WeatherController extends StateNotifier<WeatherState> {
  WeatherController(this._ref, this._repository) : super(const WeatherState());

  final Ref _ref;
  final WeatherRepository _repository;
  Settings? _lastSettings;

  void bootstrap(Settings settings) {
    _lastSettings = settings;
    if (settings.city.isNotEmpty) {
      _loadForSettings(settings);
    }
  }

  void onSettingsChanged(Settings settings) {
    final prev = _lastSettings;
    _lastSettings = settings;
    if (prev == null) {
      bootstrap(settings);
      return;
    }
    final cityChanged = prev.city != settings.city;
    final coordsChanged = prev.latitude != settings.latitude || prev.longitude != settings.longitude;
    if (cityChanged || coordsChanged) {
      if (settings.city.isEmpty) {
        state = const WeatherState();
        return;
      }
      _loadForSettings(settings);
    }
  }

  Future<void> setCity(String city) async {
    final trimmed = city.trim();
    if (trimmed.isEmpty) return;
    state = state.copyWith(isLoading: true, error: null);
    final location = await _repository.searchCity(trimmed);
    if (location == null) {
      state = state.copyWith(isLoading: false, error: 'Город не найден');
      return;
    }
    final settings = _ref.read(settingsControllerProvider);
    final updated = settings.copyWith(
      city: location.city,
      latitude: location.latitude,
      longitude: location.longitude,
    );
    _ref.read(settingsControllerProvider.notifier).update(updated);
    _lastSettings = updated;
    await _loadWeather(location);
  }

  Future<void> refresh() async {
    final settings = _ref.read(settingsControllerProvider);
    if (settings.city.isEmpty) return;
    await _loadForSettings(settings);
  }

  Future<void> _loadForSettings(Settings settings) async {
    state = state.copyWith(isLoading: true, error: null);
    LocationPoint? location;
    if (settings.city.isEmpty) {
      state = state.copyWith(isLoading: false, error: 'Укажите город в настройках');
      return;
    }
    if (settings.latitude != null && settings.longitude != null) {
      location = LocationPoint(city: settings.city, latitude: settings.latitude!, longitude: settings.longitude!);
    } else {
      location = await _repository.searchCity(settings.city);
    }
    if (location == null) {
      state = state.copyWith(isLoading: false, error: 'Не удалось найти координаты');
      return;
    }
    if (settings.latitude == null || settings.longitude == null) {
      final updated = settings.copyWith(latitude: location.latitude, longitude: location.longitude);
      _ref.read(settingsControllerProvider.notifier).update(updated);
      _lastSettings = updated;
    }
    await _loadWeather(location);
  }

  Future<void> _loadWeather(LocationPoint location) async {
    try {
      final hourly = await _repository.loadHourly(location);
      final sun = await _repository.loadSunCycle(location);
      final air = await _repository.loadAirQuality(location);
      state = state.copyWith(
        isLoading: false,
        error: null,
        location: location,
        hourly: hourly,
        sunCycle: sun,
        airQuality: air,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Сетевая ошибка');
    }
  }
}
