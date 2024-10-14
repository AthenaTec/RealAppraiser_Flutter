import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/insert_ticket_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/raise_a_ticket_repository.dart';

class RaiseATicketUseCases {
  final RaiseATicketRepository raiseATicketRepository;

  RaiseATicketUseCases({required this.raiseATicketRepository});

  Future<Either<Failure, GetTicketQueriesEntity>> getTicketQuery() {
    return raiseATicketRepository.getTicketQuery();
  }

  Future<Either<Failure, InsertTicketEntity>> createTicket(
      InsertTicketInputData inputData) {
    return raiseATicketRepository.createTicket(inputData);
  }
}

class TicketImage {
  int id;
  String image;
  String title;
  String fileName;

  TicketImage({
    required this.id,
    required this.image,
    required this.title,
    required this.fileName,
  });

  factory TicketImage.fromJson(Map<String, dynamic> json) {
    return TicketImage(
      id: json['Id'],
      image: json['Image'],
      title: json['Title'] ?? '',
      fileName: json['FileName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Image': image,
      'Title': title,
      'FileName': fileName,
    };
  }
}

class InsertTicketInputData {
  int queryType;
  String description;
  String emailId;
  String sapId;
  String contactNumber;
  String ticketStatus;
  String otherQueries;
  List<TicketImage> ticketImages;

  InsertTicketInputData({
    required this.queryType,
    required this.description,
    required this.emailId,
    required this.sapId,
    required this.contactNumber,
    required this.ticketStatus,
    required this.otherQueries,
    required this.ticketImages,
  });

  factory InsertTicketInputData.fromJson(Map<String, dynamic> json) {
    return InsertTicketInputData(
      queryType: json['QueryType'],
      otherQueries: json['OtherQueries'],
      description: json['Description'],
      emailId: json['EmailId'],
      sapId: json['SAPID'],
      contactNumber: json['ContactNumber'],
      ticketStatus: json['TicketStatus'],
      ticketImages: (json['TicketImages'] as List)
          .map((image) => TicketImage.fromJson(image))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'QueryType': queryType,
      'OtherQueries':otherQueries,
      'Description': description,
      'EmailId': emailId,
      'SAPID': sapId,
      'ContactNumber': contactNumber,
      'TicketStatus': ticketStatus,
      'TicketImages': ticketImages.map((image) => image.toJson()).toList(),
    };
  }
}
