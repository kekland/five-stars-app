import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';

class Querying {
  static void queryWithCity({String field, Query query, City value}) {
    if(value != null) query..where(field + '.latitude', isGreaterThan: value.latitude - 0.1, isLessThan: value.latitude + 0.1);
    if(value != null) query..where(field + '.longitude', isGreaterThan: value.longitude - 0.1, isLessThan: value.longitude + 0.1);
  }

  static void queryWithDateTime({String field, Query query, DateTime value}) {
    if(value != null) query..where(field, isGreaterThanOrEqualTo: value);
  }
  
  static void queryWithBounded({String field, Query query, Bounded value}) {
    if(value != null) query..where(field, isGreaterThanOrEqualTo: value.lower, isLessThanOrEqualTo: value.upper);
  }
}