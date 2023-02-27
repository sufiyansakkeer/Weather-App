class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;

  Weather(this.temp, this.feelsLike, this.low, this.high, this.description);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      json['main']['temp'].toDouble() ?? '',
      json['main']['feels_like'].toDouble() ?? '',
      json['main']['temp_min'].toDouble() ?? '',
      json['main']['temp_max'].toDouble() ?? '',
      json['weather'][0]['description'] ?? '',
    );
  }
}
