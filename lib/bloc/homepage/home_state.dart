import 'package:olxad/model/ad_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState{}
class HomeLoading extends HomeState{}
class HomeLoaded extends HomeState{
  final String city;
  final List<Ad> ads;
  HomeLoaded({
    required this.ads, required this.city
  });
}
// if location is disable 
class HomeLocationDisabled extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}