import 'package:me_car_customer/app/base/base_controller.dart';

class TabServiceController extends BaseController {
  //TODO: Implement TabServiceController

  final data = [
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Rửa xe + hút bụi + xịt gầm",
      "content":
          "Quy trình rửa xe gồm 11 bước nhầm bảo vệ tuyệt đối lớp sơn xe của khách hàng, đồng thời mang lại vẻ ngoài sáng bóng sau mỗi lần rửa xe tại MeCar."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Tẩy nhựa đường",
      "content":
          "Tẩy nhựa đường là một sản phẩm được sử dụng để loại bỏ vết nhựa đường, dầu mỡ, và bụi bẩn trên bề mặt."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Tẩy ố kính",
      "content":
          "Tẩy ố kính là một quy trình giúp loại bỏ các vết ố, bụi bẩn, và mảng cứng trên bề mặt của kính."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ Sinh + Bảo dưỡng khoang động cơ",
      "content":
          "Vệ sinh và bảo dưỡng khoang động cơ là quá trình quan trọng để đảm bảo hoạt động hiệu quả và độ bền của động cơ xe."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ Sinh + Bảo dưỡng nội thất",
      "content":
          "Vệ sinh và bảo dưỡng nội thất là quá trình dọn dẹp và bảo quản các bộ phận nội thất trong một không gian."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh nội soi hệ thống lạnh",
      "content":
          "Vệ sinh nội soi hệ thống lạnh là quá trình loại bỏ bụi bẩn, vi khuẩn và chất lỏng tích tụ trong hệ thống làm lạnh."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh kim phun xăng",
      "content":
          "Vệ sinh kim phun xăng là quá trình làm sạch và bảo dưỡng các bộ phận liên quan đến hệ thống phun nhiên liệu của động cơ."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh kim phun dầu",
      "content":
          "Việc vệ sinh kim phun dầu là quá trình loại bỏ bụi bẩn, cặn dầu và các tạp chất khác khỏi bề mặt kim phun dầu để đảm bảo hoạt động hiệu quả của hệ thống nạp nhiên liệu."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Diệt khuẩn Demi",
      "content":
          "Diệt khuẩn Demi là một loại sản phẩm hoặc chất liệu được sử dụng để tiêu diệt hoặc làm giảm tác động của vi khuẩn hoặc vi rút."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Diệt khuẩn khử mùi nội thất",
      "content":
          "Diệt khuẩn khử mùi nội thất là quá trình loại bỏ vi khuẩn và mùi hôi từ các bề mặt và không khí trong không gian nội thất."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh két nước ô tô.",
      "content":
          "Vệ sinh két nước ô tô là quá trình làm sạch và bảo dưỡng hệ thống két nước trong ô tô."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh buồng đốt",
      "content":
          "Vệ sinh buồng đốt là quá trình làm sạch và bảo dưỡng buồng đốt trong các thiết bị đốt cháy, như lò sưởi, máy nhiệt, hay lò hơi."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh họng ga+ bướm ga+ van EGR",
      "content":
          "Vệ sinh họng ga, bướm ga, và van EGR là quá trình làm sạch các phần của hệ thống ga và khí thải của xe ô tô."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh, bảo dưỡng thắng",
      "content":
          "Vệ sinh, bảo dưỡng thắng là quá trình duy trì và bảo quản hệ thống thắng trên một phương tiện, như xe hơi hoặc xe máy, để đảm bảo rằng hệ thống thắng hoạt động an toàn và hiệu quả."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Vệ sinh nội soi dàn lạnh",
      "content":
          "Vệ sinh nội soi dàn lạnh là quá trình làm sạch và bảo dưỡng hệ thống nội soi dàn lạnh. Nội soi dàn lạnh là một phần quan trọng trong hệ thống làm lạnh của máy lạnh hoặc thiết bị điều hòa không khí"
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Phủ Nano",
      "content":
          "phủ bóng Nano là việc phủ lên bề mặt lớp sơn xe một lớp dung dịch có thành phần chính là các tinh thể có gốc hữu cơ với kích thước siêu nhỏ dạng Nano."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Phủ Ceramic 9H",
      "content":
          "Ceramic Pro 9H là lớp sơn phủ Nano- ceramic có độ bóng cao, hiệu ứng siêu kỵ nước, chống trầy xước, kháng hóa chất, chống tia cực tím, kháng nhiệt và chống Grafitti."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Phủ gầm gói tiêu chuẩn",
      "content":
          "Lớp phủ chống ăn mòn được áp dụng dưới phần dưới của xe, bao gồm cả khung gầm và các bộ phận khác như động cơ, hệ thống treo và ống xả."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Phủ gầm gói cao cấp",
      "content":
          "Lớp phủ chống ăn mòn được áp dụng dưới phần dưới của xe, bao gồm cả khung gầm và các bộ phận khác như động cơ, hệ thống treo và ống xả."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Dán phim Nano gói tiêu chuẩn",
      "content":
          "Dán phim Nano chuyển sáng và chống chói lóa, đặc biệt, cơ chế dẫn điện chuyển đổi kim loại bằng oxy nitride tăng khả năng loại bỏ nhiệt nhiều hơn và bền hơn so với các loại phim cách nhiệt thông thường khác."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Dán phim Nano gói cao cấp",
      "content":
          "Dán phim Nano chuyển sáng và chống chói lóa, đặc biệt, cơ chế dẫn điện chuyển đổi kim loại bằng oxy nitride tăng khả năng loại bỏ nhiệt nhiều hơn và bền hơn so với các loại phim cách nhiệt thông thường khác."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Phim 3M- Llumar gói tiêu chuẩn",
      "content":
          "Phim 3M- Llumar phim cách nhiệt mang đến thẩm mỹ và khả năng duy trì các kết nối trên xe ổn định, không gây cản trở như sóng điện thoại, radio, GPS,… ."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Phim 3M- Llumar gói cao cấp",
      "content":
          "Phim 3M- Llumar phim cách nhiệt mang đến thẩm mỹ và khả năng duy trì các kết nối trên xe ổn định, không gây cản trở như sóng điện thoại, radio, GPS,… ."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Thay dầu, bộ lọc",
      "content":
          "Thay dầu, bộ lọc có vai trò lọc sạch các cặn bẩn và giữ lại mạt sắt đảm bảo dầu được lọc sạch giúp bảo vệ hệ thống bôi trơn, hạn chế hao mòn của các chi tiết trong động cơ."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Kiểm tra hệ thống điện, phanh, treo",
      "content":
          "Kiểm tra hệ thống điện, phanh, treo là quá trình kiểm tra các bộ phận quan trọng trên ôtô để đảm bảo sự an toàn và hoạt động hiệu quả của xe."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Kiểm tra và thay bình ắc quy, bạc đạn, dây đai",
      "content":
          "Kiểm tra và thay bình ắc quy là quá trình kiểm tra tình trạng hoạt động của bình ắc quy và thay thế nếu cần."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Áo ghế simili",
      "content":
          "Áo ghế Simili là một dạng vải tổng hợp bằng cách kết hợp chất liệu nhựa và sợi polyester. Được sản xuất để có độ bền cao, áo ghế simili thường có khả năng chống chịu mài mòn, chống thấm nước và dễ vệ sinh."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Thảm lót sàn",
      "content":
          "Thảm lót sàn được sử dụng để bảo vệ sàn ô tô khỏi bụi bẩn, nước, và các tác động bên ngoài khác."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Mặt cốp + lưng ghế",
      "content":
          "Thay thế Mặt cốp và lưng ghế ô tô là quá trình thay thế các bộ phận của cốp sau và lưng ghế trong xe ô tô."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "La phông trần - bọc ni long",
      "content":
          "La phông trần - bọc ni long là quá trình thêm một lớp ni da nhân tạo hoặc ni vinyl lên bề mặt của chiếc xe để bảo vệ nó khỏi các tác động từ môi trường như mưa, nắng, bụi bẩn, trầy xước."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Bọc da bò",
      "content":
          "Bọc da bò là quá trình thêm một lớp da bò nhân tạo lên bề mặt của chiếc xe để bảo vệ nó khỏi các tác động từ môi trường như mưa, nắng, bụi bẩn, trầy xước và tăng thẩm mỹ cho xe."
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/auto-repair-garage-logo-template-automotive-industry_160069-75.jpg?w=2000",
      "title": "Camera hành trình",
      "content":
          "Camera hành trình ô tô là một thiết bị ghi hình được gắn trên xe ô tô để ghi lại các sự kiện xảy ra trong quá trình lái xe."
    }
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
