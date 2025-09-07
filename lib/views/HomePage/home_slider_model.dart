class HomeSliderModel {
  final String? sliderItemId;
  final String? name;
  final String? description;
  final String? image;

  HomeSliderModel({
    this.sliderItemId,
    this.name,
    this.description,
    this.image,
  });

  factory HomeSliderModel.fromJson(Map<String, dynamic> json) {
    return HomeSliderModel(
      sliderItemId: json['sliderItemId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }
}
