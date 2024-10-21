import 'package:jejuya/app/common/ui/svg/svg_local.dart';

enum DialogTypeEnum {
  delete(
    "Xóa lịch trình",
    LocalSvgRes.delete,
    "Bạn có chắc muốn xóa lịch trình này?",
  ),

  warning(
    "Cảnh cáo",
    LocalSvgRes.warning,
    "Bạn có chắc muốn tạo lại lịch trình mới không?",
  ),

  completed(
    "Hoàn tất",
    LocalSvgRes.scheduleAdd,
    "Điểm đến mới đã được thêm vào lịch trình của bạn thành công.",
  ),

  error(
    "Lỗi",
    LocalSvgRes.delete,
    "Đã có một điểm đến khác được lên lịch cho thời gian này.",
  );

  // Properties
  final String name;
  final String iconUrl;
  final String title;

  // Constructor
  const DialogTypeEnum(this.name, this.iconUrl, this.title);
}
