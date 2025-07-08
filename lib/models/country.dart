class Country {
  final String name;
  final String capital;
  final int population;
  final double area;
  final String region;
  final String flagUrl;
  final List<String> languages;
  final List<String> currencies;
  final List<String> timezones;
  final List<String> borders;

  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.area,
    required this.region,
    required this.flagUrl,
    required this.languages,
    required this.currencies,
    required this.timezones,
    required this.borders,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? '—',
      capital: (json['capital'] != null && json['capital'].isNotEmpty)
          ? json['capital'][0]
          : '—',
      population: json['population'] ?? 0,
      area: (json['area'] ?? 0).toDouble(),
      region: json['region'] ?? '—',
      flagUrl: json['flags']['png'] ?? '',
      languages: json['languages'] != null
          ? (json['languages'] as Map<String, dynamic>).values
                .map((lang) => lang.toString())
                .toList()
          : [],
      currencies: json['currencies'] != null
          ? (json['currencies'] as Map<String, dynamic>).values
                .map((currency) => currency['name'].toString())
                .toList()
          : [],
      timezones:
          (json['timezones'] as List<dynamic>?)
              ?.map((tz) => tz.toString())
              .toList() ??
          [],
      borders:
          (json['borders'] as List<dynamic>?)
              ?.map((b) => b.toString())
              .toList() ??
          [],
    );
  }
}
