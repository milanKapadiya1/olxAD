import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olxad/bloc/homepage/home_event.dart';
import 'package:olxad/bloc/homepage/home_state.dart';
import 'package:olxad/model/ad_model.dart';





// --- BLOC (THE BRAIN) ---
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Simple cache to prevent re-fetching if we already have data for a city
  final Map<String, List<Ad>> _adCache = {}; 

  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(
      FetchHomeData event, Emitter<HomeState> emit) async {
    
    emit(HomeLoading());

    try {
      // 1. Check Location Service
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(HomeLocationDisabled());
        return; 
      }

      // 2. Check Permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // If denied, fallback to Mumbai (As per your old logic)
          await _fetchAdsForCity("Mumbai", emit);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
         await _fetchAdsForCity("Mumbai", emit);
         return;
      }

      // 3. Get Position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 10),
      );

      // 4. Get City Name
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String city = placemarks.first.locality ?? 'Mumbai';
      
      if (city.isEmpty || city == 'Unknown') {
        city = 'Mumbai';
      }

      // 5. Fetch Ads
      await _fetchAdsForCity(city, emit);

    } catch (e) {
      debugPrint("Location/Fetch Error: $e");
      // Fallback on error
      await _fetchAdsForCity("Mumbai", emit);
    }
  }

  Future<void> _fetchAdsForCity(String cityName, Emitter<HomeState> emit) async {
    // Check Cache first
    if (_adCache.containsKey(cityName)) {
      debugPrint('✅ Loaded $cityName ads from cache');
      emit(HomeLoaded(city: cityName, ads: _adCache[cityName]!));
      return;
    }

    try {
      final snapshot = await _firestore
          .collection('/Ads')
          .doc('ODwaKgMlJGFfyD78DP9l')
          .collection(cityName)
          .get();

      final ads = snapshot.docs.map((doc) => Ad.fromJson(doc.data())).toList();
      
      // Save to Cache
      _adCache[cityName] = ads;
      
      emit(HomeLoaded(city: cityName, ads: ads));
    } catch (e) {
      emit(HomeError("Failed to load ads for $cityName"));
    }
  }
}