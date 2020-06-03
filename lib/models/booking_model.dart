import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "booking_no")
  final String bookingNo;

  // @JsonKey(name: "source_latitude", defaultValue: '')
  // final String country;

  // @JsonKey(name: "Last_Update")
  // final DateTime lastUpdatedAt;

  @JsonKey(name: "source_latitude")
  final double sourceLatitude;

  @JsonKey(name: "source_longitude")
  final double sourceLongitude;

  @JsonKey(name: "destination_latitude")
  final double destinationLatitude;

  @JsonKey(name: "destination_longitude")
  final double destinationLongitude;

  @JsonKey(name: "enquiry_amount")
  final int enquiryAmount;

  @JsonKey(name: "enquiry_weight")
  final int enquiryWeight;

  @JsonKey(name: "amount")
  final int amount;

  @JsonKey(name: "scheduled_date")
  final int scheduledDate;

  @JsonKey(name: "is_paid")
  final int isPaid;

  @JsonKey(name: "booking_status")
  final int bookingStatus;

  @JsonKey(name: "trip_status")
  final int tripStatus;

  @JsonKey(name: "remarks")
  final int remarks;

  @JsonKey(name: "contact")
  final int contact;

  @JsonKey(name: "payment_type")
  final int paymentType;

  @JsonKey(name: "location_histories")
  final int locationHistories;

  @JsonKey(name: "rating")
  final int rating;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "customer")
  final int customer;

  @JsonKey(name: "source_city")
  final int sourceCity;

  @JsonKey(name: "destination_city")
  final int destinationCity;

  @JsonKey(name: "truck_type")
  final int truckType;

  @JsonKey(name: "material_type")
  final int materialType;

  @JsonKey(name: "truck_capacity")
  final int truckCapacity;

  @JsonKey(name: "truck_size")
  final int truckSize;

  @JsonKey(name: "truck")
  final int truck;

  @JsonKey(name: "driver")
  final int driver;

  @JsonKey(name: "trip_details")
  final int tripDetails;

  Booking({
    this.id,
    this.bookingNo,
    this.sourceLatitude,
    this.sourceLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.contact,
    this.isPaid,
    this.amount,
    this.tripStatus,
    this.bookingStatus,
    this.scheduledDate,
    this.enquiryWeight,
    this.enquiryAmount,
    this.rating,
    this.remarks,
    this.paymentType,
    this.locationHistories,
    this.createdAt,
    this.customer,
    this.sourceCity,
    this.destinationCity,
    this.truckType,
    this.materialType,
    this.truckCapacity,
    this.truckSize,
    this.truck,
    this.driver,
    this.tripDetails
  });
  

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJSON() => _$BookingToJson(this);

}