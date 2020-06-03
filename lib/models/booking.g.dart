part of  'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    id: json['id'] as int,
    bookingNo: json['booking_no'] as String ?? '',
    sourceLatitude: (json['source_latitude'] as num)?.toDouble(),
    sourceLongitude: (json['source_longitude'] as num)?.toDouble(),    
    destinationLatitude: (json['destination_latitude'] as num)?.toDouble(),
    destinationLongitude: (json['destination_longitude'] as num)?.toDouble(),
    contact: json['contact'] as int,
    isPaid: json['is_paid'] as int,
    amount: json['amount'] as int,
    enquiryAmount: json['enquiry_amount'] as int,
    rating: json['rating'] as int,
    remarks: json['remarks'] as int,
    tripStatus: json['trip_status'] as int,
    bookingStatus: json['booking_status'] as int,
    scheduledDate: json['scheduled_date'] as int,
    enquiryWeight: json['enquiry_weight'] as int,
    paymentType: json['payment_type'] as int,
    locationHistories: json['location_histories'] as int,
    createdAt: json['created_at'] as DateTime,
    customer: json['customer'] as int,
    sourceCity: json['source_city'] as int,
    destinationCity: json['destination_city'] as int,
    truckType: json['truck_type'] as int,
    materialType: json['material_type'] as int,
    truckCapacity: json['truck_capacity'] as int,
    truckSize: json['truck_size'] as int,
    truck: json['truck'] as int,
    driver: json['driver'] as int,
    tripDetails: json['trip_details'] as int,
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_no': instance.bookingNo,
      'contact': instance.contact,
      'source_latitude': instance.sourceLatitude,
      'source_longitude': instance.sourceLongitude,
      'destination_latitude': instance.destinationLatitude,
      'destination_longitude': instance.destinationLongitude,
      'amount': instance.amount,
    };