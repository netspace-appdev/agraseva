

class DrawerModel {
  String? title;
  String? position;
  String? icon;
  bool? selected;

  DrawerModel({this.title, this.position,this.icon,this.selected });

  DrawerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    position = json['position'];
    icon = json['icon'];
    selected = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] =  title;
    data['position'] = position;
    data['icon'] = icon;
    data['selected'] = selected;
    return data;
  }
}
