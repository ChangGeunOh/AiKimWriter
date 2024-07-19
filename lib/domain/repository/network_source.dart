abstract class NetworkSource {
  Future<String> getAddress({
    required double latitude,
    required double longitude,
    required String apiKey,
  });
}
