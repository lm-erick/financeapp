class Servico {
  Servico(
      {required this.name,
      required this.convenioId,
      required this.value,
      required this.duration});

  Servico.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            convenioId: json['convenioId']! as String,
            value: json['value']! as num,
            duration: json['duration']! as num);

  final String name;
  final String convenioId;
  final num value;
  final num duration;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'convenioId': convenioId,
      'value': value,
      'duration': duration
    };
  }
}
