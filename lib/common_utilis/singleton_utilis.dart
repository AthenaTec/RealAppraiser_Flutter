import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';

class DataManager {
  // Private constructor to prevent direct instantiation
  DataManager._privateConstructor();

  // Singleton instance
  static final DataManager _instance = DataManager._privateConstructor();

  // Public getter to access the singleton instance
  static DataManager get instance => _instance;

  GetTicketQueriesEntity? ticketQueries;

  // Method to store ticket queries
  void storeTicketQueries(GetTicketQueriesEntity queries) {
    ticketQueries = queries;
  }

  // Example method to retrieve ticket queries
  GetTicketQueriesEntity? getTicketQueries() {
    return ticketQueries;
  }
}
