import 'package:jejuya/app/common/ui/svg/svg_local.dart';

enum InfoEnum {
  address('98 Nohyeong-ro, Jeju-si', LocalSvgRes.address),
  time('09:00 - 19:00 (Last admission 18:00)', LocalSvgRes.time),
  schedule('Open all year round', LocalSvgRes.schedule),
  phone('064-713-1888', LocalSvgRes.phone);

  // Properties
  final String name;
  final String icon;

  // Constructor
  const InfoEnum(this.name, this.icon);
}

enum Category {
  exhibition("Exhibition"),
  museum("Museum");

  // Properties
  final String name;
  // Constructor
  const Category(this.name);
}

enum CategoryDetail {
  family("Family"),
  friends("Friends"),
  couple("Couple"),
  alone("Alone"),
  indoor("Indoor");

  // Properties
  final String name;
  // Constructor
  const CategoryDetail(this.name);
}

enum DestinationDetailState {
  none,

  loading,

  done,
}
