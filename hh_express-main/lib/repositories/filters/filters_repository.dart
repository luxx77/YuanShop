import 'package:hh_express/models/property/property_model.dart';

abstract class FilterRepo {
  Future<List<PropertyModel>?> getProps();
}
