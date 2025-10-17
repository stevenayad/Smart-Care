abstract class ApiConsumer {
  Future<dynamic> get(String endpoint , Map<String,dynamic>? query);
  Future<dynamic> post(String endpoint , dynamic body , bool isFormData ) ; 
  Future<dynamic> put(String endpoint , Map<String,dynamic>? body);
  Future<dynamic> delete(String endpoint , Map<String,dynamic>?body);
}