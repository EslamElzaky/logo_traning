class HomeServiceModel {
  final String? id;
  final String? name;
  final String? description;
  final String? iconUrl;
  final String? serviceBackImageUrl;
  final String? serviceNote;
  HomeServiceModel({
    this.id,
    this.name,
    this.description,
    this.iconUrl,
    this.serviceBackImageUrl,
    this.serviceNote,
  });

  factory HomeServiceModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['iconUrl'],
      serviceBackImageUrl: json['serviceBackImageUrl'],
      serviceNote: json['serviceNote'],
    );
  }
}
