CREATE DATABASE ClothingShop;
DROP DATABASE ClothingShop;
SET SQL_SAFE_UPDATES = 1;
-- SELECT * FROM `Category`;
-- DELETE FROM Category;
-- DELETE FROM SubCategory;
-- SELECT * FROM `Product`;
-- ALTER TABLE `Category` AUTO_INCREMENT = 1;
-- ALTER TABLE `Subcategory` AUTO_INCREMENT = 1;
-- ALTER TABLE `Product` AUTO_INCREMENT = 1; 
USE ClothingShop;
SELECT * FROM ProductImage;
-- Thêm vào bảng `Category` (Danh mục chính)
SELECT * FROM Category
SELECT * FROM SubCategory
SELECT * FROM Product

INSERT INTO `Category` (`title`, `slug`, `description`)
VALUES (
        'Nam',
        'nam',
        'Trang phục dành cho nam giới, bao gồm quần, áo, phụ kiện và các loại trang phục khác.'
    ),
    (
        'Nữ',
        'nu',
        'Trang phục dành cho nữ giới, bao gồm quần, áo, phụ kiện và các loại trang phục khác.'
    ),
    (
        'Trẻ Em',
        'tre-em',
        'Trang phục dành cho trẻ em, bao gồm quần, áo, phụ kiện và các loại trang phục khác.'
    );
-- Thêm vào bảng `Subcategory` (Phân loại sản phẩm theo category)
-- Subcategory cho Nam
INSERT INTO `Subcategory` (`title`, `slug`, `description`, `category_id`)
VALUES (
        'Quần Jean Nam',
        'quan-jean-nam',
        'Quần jean thời trang dành cho nam giới, thoải mái và phù hợp với nhiều hoàn cảnh.',
        1
    ),
    (
        'Quần Kaki Nam',
        'quan-kaki-nam',
        'Quần kaki nam kiểu dáng thanh lịch, phù hợp cho công sở và đi chơi.',
        1
    ),
    (
        'Áo Thun Nam',
        'ao-thun-nam',
        'Áo thun nam chất liệu cotton mềm mại, dễ chịu, phù hợp với mọi hoạt động.',
        1
    ),
    (
        'Áo Sơ Mi Nam',
        'ao-so-mi-nam',
        'Áo sơ mi nam phong cách công sở, lịch lãm, phù hợp cho các buổi họp mặt hay công việc.',
        1
    ),
    (
        'Áo Khoác Nam',
        'ao-khoac-nam',
        'Áo khoác nam thời trang, giữ ấm và phù hợp cho các ngày lạnh.',
        1
    ),
    (
        'Quần Short Nam',
        'quan-short-nam',
        'Quần short nam thoải mái cho các hoạt động thể thao và du lịch.',
        1
    );
-- Subcategory cho Nữ
INSERT INTO `Subcategory` (`title`, `slug`, `description`, `category_id`)
VALUES (
        'Quần Jean Nữ',
        'quan-jean-nu',
        'Quần jean nữ ôm sát, thoải mái và giúp tôn dáng, phù hợp với các buổi dạo phố.',
        2
    ),
    (
        'Quần Legging Nữ',
        'quan-legging-nu',
        'Quần legging nữ co giãn tốt, dễ dàng kết hợp với nhiều trang phục khác.',
        2
    ),
    (
        'Áo Thun Nữ',
        'ao-thun-nu',
        'Áo thun nữ dễ thương, chất liệu vải mát mẻ, thích hợp cho mùa hè.',
        2
    ),
    (
        'Áo Sơ Mi Nữ',
        'ao-so-mi-nu',
        'Áo sơ mi nữ thanh lịch, phù hợp với môi trường công sở.',
        2
    ),
    (
        'Áo Len Nữ',
        'ao-len-nu',
        'Áo len nữ ấm áp, phong cách, thích hợp cho mùa thu đông.',
        2
    ),
    (
        'Chân Váy Nữ',
        'chan-vay-nu',
        'Chân váy nữ trẻ trung, giúp tôn dáng và dễ dàng kết hợp với áo sơ mi hoặc áo thun.',
        2
    );
-- Subcategory cho Trẻ Em
INSERT INTO `Subcategory` (`title`, `slug`, `description`, `category_id`)
VALUES (
        'Quần Jean Trẻ Em',
        'quan-jean-tre-em',
        'Quần jean trẻ em mềm mại, thoải mái cho trẻ vận động.',
        3
    ),
    (
        'Quần Short Trẻ Em',
        'quan-short-tre-em',
        'Quần short trẻ em dễ thương, thích hợp cho mùa hè hoặc khi đi chơi.',
        3
    ),
    (
        'Áo Thun Trẻ Em',
        'ao-thun-tre-em',
        'Áo thun trẻ em với các họa tiết ngộ nghĩnh, vui nhộn.',
        3
    ),
    (
        'Áo Sơ Mi Trẻ Em',
        'ao-so-mi-tre-em',
        'Áo sơ mi trẻ em dễ thương, thích hợp cho các dịp đặc biệt hoặc tiệc tùng.',
        3
    ),
    (
        'Áo Khoác Trẻ Em',
        'ao-khoac-tre-em',
        'Áo khoác trẻ em giữ ấm, kiểu dáng dễ thương và phong cách.',
        3
    ),
    (
        'Váy Nữ Trẻ Em',
        'vay-nu-tre-em',
        'Váy nữ trẻ em, phong cách dễ thương và thoải mái cho các bé gái.',
        3
    );

-- Thêm vào bảng `Product` cho các sản phẩm thuộc Subcategory "Nam"
INSERT INTO `Product` (
          `product_id`  ,
        `product_name`,
        `slug`,
        `description`,
        `price`,
        `stock`,
        `category_id`,
        `subcategory_id`
    )
VALUES (
        101,
        'Qnuần Jea Nam',
        'quan-jean-nam',
        'Quần jean dành cho nam giới, thoải mái và phù hợp với nhiều hoàn cảnh.',
        500000,
        100,
        1,
        1
    ),
    (
        102,
        'Quần Jean Nam Wash RETRO',
        'quan-jean-nam-wash-retro',
        'uần jean  nam với chất vải THOÁNG MÁT,  VẬN ĐỘNG THOẢI MÁI cho mùa hè nắng nóng. '
        'Bề mặt đanh, mịn, mặc thoả mái và vẫn giữ nguyên form quần sau nhiều lần giặt.'
        ' Đặc biệt form dáng rộng mát HOT nhất hè năm 2024',
        899000,
        70 ,
        1,
        1
    ),
    (
        103,
        'Quần Jean Nam',
        'quan-jean-nam-thoi-trang',
        'Quần Jean Nam Dáng Baggy Ống Suông Wash Smoke 2 Màu Chất Vải Dày Dặn The Jeans
        The Jean luôn nỗ lực trở thành đơn vị cung cấp các mẫu Jean tốt nhất trên thị trường, với mẫu mã đa dạng' 
        ' và luôn bắt kịp các xu hướng mới nhất.',
        500000,
        100,
        1,
        1
    ),
    (
     111,
        'Quần Kaki Nam',
        'quan-kaki-nam',
        'Quần kaki nam kiểu dáng thanh lịch, phù hợp cho công sở và đi chơi.',
        450000,
        80,
        1,
        2
    ),
     (
      112,
        'Quần Kaki Nam Cao Cấp',
        'quan-kaki-nam-cao-cap',
        'Quần kaki nam kiểu dáng thanh lịch, phù hợp cho công sở và đi chơi.',
        890000 ,
        75,
        1,
        2
    ),
    (
     113,
        'Quần dài nam dáng suông kaki phong cách Hanlu Nhật Bản Streetwear mùa thu đông',
        'quan-kaki-nam-hanlu',
        'Quần dài nam kaki chất vải kaki gân chéo dày dặn, Dáng: Phom rộng mặc thoải phái, Phù hợp: Mặc đi làm, công sở, các hoạt động dã ngoại ngoài trời, dạo phố.',
        332000,
        100 ,
        1,
        2
    ),
    (
     121,
         'Áo Thun Nam',
        'ao-thun-nam',
        'Áo thun nam chất liệu cotton mềm mại, dễ chịu, phù hợp với mọi hoạt động.',
        250000,
        200,
        1,
        3
    ),
    (
     122,
         'Áo Thun-Polo Nam ',
        'ao-thun-nam-polo',
        'Áo thun nam là trang phục cơ bản và tiện dụng nhất đối với phái mạnh. Hầu như người đàn ông nào cũng' 
                ' đều phải có vài chiếc áo pull nam trong tủ áo của mình. ',
        95000,
        300,
        1,
        3
    ),
    (
     123,
         'Áo Thun Nam tay lỡ',
        'ao-thun-nam-tay-lo',
        'Dù là ai, bạn cũng nên thử nghĩ đến áo thun tay lỡ – một items mới mẻ mang đến style năng động và “chất lừ” cho bất cứ ai sở hữu nó.' 
        ' Không phải áo thun freesize hay tay dài nữa'
        ', áo thun tay lỡ mới thực sự làm điên đảo giới trẻ trong thời điểm này.',
        85000,
        250,
        1,
        3
    ),
    (
     131,
        'Áo Sơ Mi Nam',
        'ao-so-mi-nam',
        'Áo sơ mi nam phong cách công sở, lịch lãm, phù hợp cho các buổi họp mặt hay công việc.',
        350000,
        50,
        1,
        4
    ),
    (
     132,
        'Áo sơ mi nam dài tay Pastel Premium ',
        'ao-so-mi-nam-Pastel-Premium',
        'Áo sơ mi trơn công sở là một kiểu áo sơ mi nam đơn giản, trang trọng và lịch sự' 
        ', được thiết kế để mặc trong môi trường văn phòng hoặc các sự kiện chuyên nghiệp.',
        890000,
        30,
        1,
        4
    ),
    (
     133,
        'Áo Sơ Mi Tay Ngắn TÚI HỘP Thêu',
        'ao-so-mi-nam-tay-ngan',
        'Được chăm chút từ chất liệu, form dáng, đường may, hình in cho đến khâu đóng gói và hậu mãi,' 
         ' chiếc sơ mi Cuban xinh xẻo này sẽ làm hài lòng cả những vị khách khó tính nhất.',
        87000,
        100,
        1,
        4
    ),
    (
     141,
        'Áo Khoác Nam',
        'ao-khoac-nam',
        'Áo khoác nam thời trang, giữ ấm và phù hợp cho các ngày lạnh.',
        700000,
        40,
        1,
        5
    ),
    (
     142,
        'Áo Khoác Bomber Dù Hai Lớp',
        'ao-khoac-nam-Bomber',
        'Áo khoác dù nam hàng VNXK
         Chất liệu vải dù nhám dày dặn 2 lớp.Trong lớp lót giúp áo thoáng nhiệt.
          Thiết kế áo  form cực đẹp, các chi tiết logo sắc nét. ',
        450000,
        49,
        1,
        5
    ),
    (
     143,
        'Áo Hoodie Trơn Basic Nam',
        'ao-khoac-Hoodie-nam',
        'Áo Hoodie form rộng Tay Lỡ với chất nỉ bông mịn, ấm với đường may kỹ, lên dáng đẹp . ',
        250000,
        79,
        1,
        5
    ),
    (151,
        'Quần Short Nam',
        'quan-short-nam',
        'Quần short nam thoải mái cho các hoạt động thể thao và du lịch.',
        300000,
        150,
        1,
        6
    ),
        (152,
        'Quần Short Pocket SAIGONESE, Quần Đùi Túi Hộp',
        'quan-short-tui-hop-nam',
        'Quần Short Pocket SAIGONESE là một trong những item mà các bạn nam  nữ nên có trong tủ đồ của mình trong mùa hè
- Chất liệu Kaki cotton  cao cấp – Dày dặn – Co giãn.
 - Form dáng basic – Dễ phối đồ từ đi chơi – dạo phố - đi làm.
- Thiết kế lưng chun phía sau giúp co dãn tối đa.',
        150000,
        75,
        1,
        6
    ),
     (153,
        'Quần Short Đùi JOGGER thể thao nam phong cách đường phố',
        'quan-short-JOGGER-nam',
        'Quần Short Đùi unisex JOG thể thao nam nữ oversize phong cách đường phố:
         Đảm bảo vải chuẩn Nỉ cotton 100% chất lượng',
        95000,
        210,
        1,
        6
    );
-- Thêm vào bảng `Product` cho các sản phẩm thuộc Subcategory "Nữ"
INSERT INTO `Product` (
        `product_id`  ,
        `product_name`,
        `slug`,
        `description`,
        `price`,
        `stock`,
        `category_id`,
        `subcategory_id`
    )
VALUES (
        201,
        'Quần Jean Nữ',
        'quan-jean-nu',
        'Quần jean nữ ôm sát, thoải mái và giúp tôn dáng, phù hợp với các buổi dạo phố.',
        500000,
        120,
        2,
        1
    ),
    (
        202,
        'SUNAIXUE quần ống rộng quần nữ jean ',
        'quan-jean-SUNAIXUE-nu',
        'quần nữ jean sunaixue với chất liệu denim cực kỳ phù hợp cho các bạn nữ theo phong cách Minimalist, Đơn giản Cổ điển',
        350000,
        120,
        2,
        1
    ),
    (
        203,
        'Quần jean Lovito xếp ly màu trơn',
        'quan-jean-lovito-nu',
        'Lovito là một thương hiệu mới nổi tin vào sức mạnh của con gái, '
        'cam kết cung cấp các lựa chọn quần áo thời trang và giá cả phải chăng cho các phong cách, '
        'nhu cầu và bản sắc khác nhau.',
        197000,
        120,
        2,
        1
    ),
    (
     211,
        'Quần Legging Nữ',
        'quan-legging-nu',
        'Quần legging nữ co giãn tốt, dễ dàng kết hợp với nhiều trang phục khác.',
        250000,
        200,
        2,
        2
    ),
     (
     212,
        'Quần legging đùi ECOCHIC nữ cạp cao gen bụng tập gym yoga',
        'quan-legging-ECOCHIC-nu',
        'Chất liệu vải đạt tiêu chuẩn xuất khẩu cao cấp mềm, mịn, thấm hút mồ hôi
- Chất liệu thun co giãn 4 chiều cao cấp, công nghệ kháng khuẩn, thấm hút tạo cảm giác thoải mái dễ chịu
- Đường may kỹ, tinh tế, sản phẩm luôn được kiểm tra kỹ lưỡng trước khi đóng gói.',
        255000,
        230,
        2,
        2
    ),
     (
     213,
        'Quần legging tập gym yoga legging nữ cạp cao Fitme Zeta',
        'quan-legging-Fitme-Zeta-nu',
        'u điểm của chất liệu này là bề mặt vải bóng mượt, mềm mịn, khả năng co giãn tốt. ' 
        'Vải Nylon spandex rất dễ giặt, độ bền cao, giữ form tốt,' 
        ' không bị mất đi tính năng ban đầu và mang đến sự thoải mái cho người mặc',
        150000,
        452,
        2,
        2
    ),
    (
     221,
        'Áo Thun Nữ',
        'ao-thun-nu',
        'Áo thun nữ dễ thương, chất liệu vải mát mẻ, thích hợp cho mùa hè.',
        180000,
        250,
        2,
        3
    ),
    (
     222,
        'Áo Thun AM BE Nữ In Hình Nhiều Họa Tiết',
        'ao-thun-nu-am-be',
        ' Loại áo này “khó tính” hơn áo thun nam nữ ngắn tay, nếu biết cách mix đồ, bạn sẽ trở nên thật cá tính với phong cách thời trang đậm chất Hàn Quốc,
         nhưng nếu phối đồ không tốt trông bạn như đang “lọt thỏm” trong chiếc áo thun tay lỡ.',
        86000,
        100,
        2,
        3
    ),
    (
     223,
        'Áo phông fashion nữ local brand Salute',
        'ao-thun-nu-salute',
        '1.100% cotton, chất vải mềm mại mịn màng tinh tế,không bị co ngắn sau khi giặt.
2.Toàn bộ hình ảnh của cửa hàng đều là ảnh thật do xưởng tự chụp.
3.Sản phẩm của chúng tôi là dành cho cả nam và nữ,cặp đôi nhân tình và cặp đôi Chị Em đều có thể mặc được.',
        95000,
        350,
        2,
        3
    ),
    (
     231,
        'Áo Sơ Mi Nữ',
        'ao-so-mi-nu',
        'Áo sơ mi nữ thanh lịch, phù hợp với môi trường công sở.',
        350000,
        100,
        2,
        4
    ),
     (
     232,
        'Áo Sơ Mi Dài Tay Nữ CECI Kẻ Sọc Kèm Cà Vạt Cổ Bẻ ',
        'ao-so-mi-nu-ceci',
        'Áo xinh lắm nhé, chất liệu dày dặn, mặc đi học đi chơi ai cũng khen, chỉ có hơn 100k xíu thôi ý, quá hời.',
        159000,
        630,
        2,
        4
    ),
     (
     233,
        'Ethelgirl Mỹ Retro',
        'ao-so-mi-nu-retro',
        '◆Màu sắc thực của mặt hàng có thể hơi khác so với hình ảnh hiển thị trên trang web, do nhiều yếu tố như độ sáng của màn hình và độ sáng ánh sáng, Vui lòng cho phép độ lệch đo lường thủ công nhỏ (± 3cm) đối với dữ liệu ~
◆Vui lòng kiểm tra để xác nhận [Sản phẩm của cửa hàng chúng tôi] Có hư hỏng không "trầy xước" hư hỏng "vết bẩn (Không phải yếu tố do con người gây ra) Nếu bạn có bất kỳ vấn đề gì, hãy giữ bên trong và bên ngoài đóng gói hàng hóa, hình ảnh hàng hóa và Liên hệ với chúng tôi ngay lập tức, sẽ có người xử lý nó cho bạn ~',
        163000,
        725,
        2,
        4
    ),
    (
     241,
        'Áo Len Nữ',
        'ao-len-nu',
        'Áo len nữ ấm áp, phong cách, thích hợp cho mùa thu đông.',
        600000,
        70,
        2,
        5
    ),
      (
     241,
        'Áo Len Nữ',
        'ao-len-nu',
        'Áo len nữ ấm áp, phong cách, thích hợp cho mùa thu đông.',
        600000,
        70,
        2,
        5
    ),
      (
     242,
        'Áo len Đỏ Năm Mới Giáng Sinh Slim Fit Cổ Tròn Micro Flare',
        'ao-len-nu-micro-flare',
        'Mặc đi chụp noel thì phải gọi là bá cháy bọ chét,Mặc lên dịu keo nha còn tôn dáng nữa
Kích thước (CM)
Chiều dài quần áo:	47	Tượng bán thân:	76	Chiều dài tay áo:	63	Chiều rộng vai:	36
        Mê không lối thoát rồi ',
        138000,
        425,
        2,
        5
    ),
      (
     243,
        'RUICHE Áo Len áo khoác cardigan phổ biến Fashion',
        'ao-len-nu-ruiche',
        'Thiết kế độc đáo và nổi bật của chiếc áo len này chắc chắn sẽ thu hút sự chú ý từ mọi người xung quanh.
        Màu sắc tươi sáng và họa tiết độc đáo tạo nên một phong cách cá nhân và sành điệu.',
        149000,
        530,
        2,
        5
    ),
    (
     251,
        'Chân Váy Nữ',
        'chan-vay-nu',
        'Chân váy nữ trẻ trung, giúp tôn dáng và dễ dàng kết hợp với áo sơ mi hoặc áo thun.',
        300000,
        150,
        2,
        6
    ),
      (
     252,
        'Chân váy ngắn bí ngô MunMiu',
        'chan-vay-nu-miu-miu',
        'Chân váy ngắn bí ngô MunMiu 2 lớp có bảo hộ dáng xếp ly bồng đính nơ lưng chun có lớp lót phong cách Hàn Quốc',
        154000,
        535,
        2,
        6
    ),
      (
     253,
        'Chân Váy Jean Nữ Cạp Cao Dáng Dài LIMISU',
        'chan-vay-nu-limisu',
        'Quần áo này có chất liệu vải mềm mại, thoáng mát và thoải mái khi mặc.
         Kiểu dáng hiện đại, phù hợp với nhiều phong cách khác nhau, từ công sở đến dạo phố. Màu sắc tươi sáng, dễ dàng kết hợp với các phụ kiện. ',
        163000,
        109,
        2,
        6
    );
-- Thêm vào bảng `Product` cho các sản phẩm thuộc Subcategory "Trẻ Em"
INSERT INTO `Product` (
         `product_id` ,
        `product_name`,
        `slug`,
        `description`,
        `price`,
        `stock`,
        `category_id`,
        `subcategory_id`
    )
VALUES (
        301,
        'Quần Jean Trẻ Em',
        'quan-jean-tre-em',
        'Quần jean trẻ em mềm mại, thoải mái cho trẻ vận động.',
        400000,
        100,
        3,
        1
    ),
    (
        302,
        'Quần Jean Bé Gái Bé Gái Babimama',
        'quan-jean-tre-em-babimama',
        'Quần Jean Bé Gái Size Đại Quần Jean Ống Rộng, Quần Bò Ống Xuông Phong Cách Thời Trang Cho Các Bé Gái Babimama
- Độ tuổi khuyến khích từ 4 - 18 tuổi
- Kiểu dáng cách điệu vô cùng dễ thương.
- Có các màu cho các mẹ lựa chọn cho các nàng công chúa, màu nào cũng quá đẹp luôn.',
        142000,
        100,
        3,
        1
    ),
    (
        303,
        'Quần bé trai TIINGXUYU Quần bò trẻ em',
        'quan-jean-tre-em-tiingxuyu',
        ' Quần bò trẻ em mẫu mới xuân thu quần dài hoạt hình thời trang trẻ em vừa và lớn rộng rãi phiên bản học sinh',
        173000,
        100,
        3,
        1
    ),
    (
     311,
        'Quần Short Trẻ Em',
        'quan-short-tre-em',
        'Quần short trẻ em dễ thương, thích hợp cho mùa hè hoặc khi đi chơi.',
        250000,
        150,
        3,
        2
    ),
      (
     312,
        'Combo 2 quần short bé trai BOBDOG',
        'quan-short-tre-em-bobdog',
        'Combo quần đùi cotton in hình cho bé là sự kết hợp tuyệt vời giữa phong cách thời trang và sự thoải mái cho bé yêu của bạn.
        Với những họa tiết độc đáo và ngộ nghĩnh in trên chất liệu cotton mềm mịn và co giãn mang lại sự thoải mái tối đa cho bé trong mọi hoạt động.',
        350000,
        629,
        3,
        2
    ),
      (
     313,
        'Quần đùi bé trai BabyloveGO',
        'quan-short-tre-em-babyloveGo',
        'Quần đùi bé trai BabyloveGO quần đùi kaki đứng form túi hộp cho bé thiết kế theo kiểu dáng đơn giản nhưng vẫn cá tính,
         dễ phối đồ phù hợp cho các bé đi học và đi chơi, bé thoải mái tự do chạy nhảy và vui chơi cả ngày.',
        43000,
        275,
        3,
        2
    ),
    (
     321,
        'Áo Thun Trẻ Em',
        'ao-thun-tre-em',
        'Áo thun trẻ em với các họa tiết ngộ nghĩnh, vui nhộn.',
        150000,
        200,
        3,
        3
    ),
    (
     331,
        'Áo Sơ Mi Trẻ Em',
        'ao-so-mi-tre-em',
        'Áo sơ mi trẻ em dễ thương, thích hợp cho các dịp đặc biệt hoặc tiệc tùng.',
        300000,
        80,
        3,
        4
    ),
    (
     341,
        'Áo Khoác Trẻ Em',
        'ao-khoac-tre-em',
        'Áo khoác trẻ em giữ ấm, kiểu dáng dễ thương và phong cách.',
        500000,
        60,
        3,
        5
    ),
    (
     351,
        'Váy Nữ Trẻ Em',
        'vay-nu-tre-em',
        'Váy nữ trẻ em, phong cách dễ thương và thoải mái cho các bé gái.',
        350000,
        120,
        3,
        6
    );
 


-- Cho các sản phẩm thuộc Subcategory "Nam": 
-- Ảnh cho Quần Jean Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (101, 'product_images/quan_jean_nam_G_Jeans_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (101, 'product_images/quan_jean_nam_G_Jeans_b.png');

INSERT INTO ProductImage (product_id, image)
VALUES (102, 'product_images/quan_jean_nam_wash_retro_a.png'),
       (102, 'product_images/quan_jean_nam_wash_retro_b.png'),
       (102, 'product_images/quan_jean_nam_wash_retro_c.png');

INSERT INTO ProductImage (product_id, image)
VALUES (103, 'product_images/quan_jean_thoi_trang_a.png'),
       (103, 'product_images/quan_jean_thoi_trang_b.png'),
       (103, 'product_images/quan_jean_thoi_trang_c.png');

-- Ảnh cho Quần Kaki Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (111, 'product_images/quan_kaki_nam_Gen_Viet_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (111, 'product_images/quan_kaki_nam_Gen_Viet_b.png');

INSERT INTO ProductImage (product_id, image)
VALUES (112, 'product_images/quan_kaki_nam_cao_cap_a.png'),
       (112, 'product_images/quan_kaki_nam_cao_cap_b.png'),
       (112, 'product_images/quan_kaki_nam_cao_cap_c.png');

INSERT INTO ProductImage (product_id, image)
VALUES (113, 'product_images/quan_kaki_nam_hanlu_a.png'),
       (113, 'product_images/quan_kaki_nam_hanlu_b.png'),
       (113, 'product_images/quan_kaki_nam_hanlu_c.png');

-- Ảnh cho Áo Thun Nam (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (121, 'product_images/ao_thun_BAD_HABITS_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (121, 'product_images/ao_thun_BAD_HABITS_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (121, 'product_images/ao_thun_BAD_HABITS_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (121 , 'product_images/ao_thun_BAD_HABITS_d.png');
INSERT INTO ProductImage (product_id, image)
VALUES (122, 'product_images/ao_thun_nam_polo_a.png'),
       (122, 'product_images/ao_thun_nam_polo_b.png'),
       (122, 'product_images/ao_thun_nam_polo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (122, 'product_images/ao_thun_nam_tay_lo_a.png'),
       (122, 'product_images/ao_thun_nam_tay_lo_b.png'),
       (122, 'product_images/ao_thun_nam_tay_lo_c.png');

-- Ảnh cho Áo Sơ Mi Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (131, 'product_images/ao_so_mi_nam_GenViet_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (131, 'product_images/ao_so_mi_nam_GenViet_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (132, 'product_images/ao_so_mi_nam_Pastel_Premium_a.png'),
       (132, 'product_images/ao_so_mi_nam_Pastel_Premium_b.png'),
       (132, 'product_images/ao_so_mi_nam_Pastel_Premium_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (133, 'product_images/ao_so_mi_nam_tay_ngan_a.png'),
       (133, 'product_images/ao_so_mi_nam_tay_ngan_b.png'),
       (133 ,'product_images/ao_so_mi_nam_tay_ngan_c.png');


-- Ảnh cho Áo Khoác Nam (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (141 , 'product_images/ao_khoac_gio_BAD_HABITS_d.png');
INSERT INTO ProductImage (product_id, image)
VALUES (142, 'product_images/ao_khoac_nam_Bomber_a.png'),
       (142, 'product_images/ao_khoac_nam_Bomber_b.png'),
       (142 ,'product_images/ao_khoac_nam_Bomber_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (143, 'product_images/ao_khoac_Hoodie_nam_a.png'),
       (143, 'product_images/ao_khoac_Hoodie_nam_b.png');


-- Ảnh cho Quần Short Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_d.png');
INSERT INTO ProductImage (product_id, image)
VALUES (152, 'product_images/quan_short_tui_hop_nam_a.png'),
       (152, 'product_images/quan_short_tui_hop_nam_b.png'),
       (152, 'product_images/quan_short_tui_hop_nam_c.png'),
       (152, 'product_images/quan_short_tui_hop_nam_d.png'),
       (152 ,'product_images/quan_short_tui_hop_nam_e.png');
INSERT INTO ProductImage (product_id, image)
VALUES (153, 'product_images/quan_short_JOGGER_nam_a.png'),
       (153, 'product_images/quan_short_JOGGER_nam_b.png');


-- Cho các sản phẩm thuộc Subcategory "Nữ":
-- Ảnh cho Quần Jean Nữ (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (202, 'product_images/quan_jean_SUNAIXUE_nu_a.png'),
       (202, 'product_images/quan_jean_SUNAIXUE_nu_b.png'),
       (202 ,'product_images/quan_jean_SUNAIXUE_nu_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (203, 'product_images/quan_jean_lovito_nu_a.png'),
       (203, 'product_images/quan_jean_lovito_nu_b.png'),
       (203 ,'product_images/quan_jean_lovito_nu_c.png');



-- Ảnh cho Quần Legging Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (211, 'product_images/quan_legging_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (211, 'product_images/quan_legging_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (212, 'product_images/quan_legging_ECOCHIC_nu_a.png'),
       (212, 'product_images/quan_legging_ECOCHIC_nu_b.png'),
       (212 ,'product_images/quan_legging_ECOCHIC_nu_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (213, 'product_images/quan_legging_Fitme_Zeta_nu_a.png'),
       (213 ,'product_images/quan_legging_Fitme_Zeta_nu_b.png');

-- Ảnh cho Áo Thun Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_thun_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_thun_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_thun_nu_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (222, 'product_images/ao_thun_nu_am_be_a.png'),
       (222, 'product_images/ao_thun_nu_am_be_b.png'),
       (222 ,'product_images/ao_thun_nu_am_be_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (223, 'product_images/ao_thun_nu_salute_a.png'),
       (223, 'product_images/ao_thun_nu_salute_b.png'),
       (223 ,'product_images/ao_thun_nu_salute_c.png');

-- Ảnh cho Áo Sơ Mi Nữ (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (231, 'product_images/ao_so_mi_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (231, 'product_images/ao_so_mi_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (232, 'product_images/ao_so_mi_nu_ceci_a.png'),
       (232, 'product_images/ao-so-mi-nu-ceci_b.png'),
       (232,'product_images/ao-so-mi-nu-ceci_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (233, 'product_images/ao_so_mi_nu_retro_a.png'),
       (233, 'product_images/ao_so_mi_nu_retro_b.png'),
       (233,'product_images/ao_so_mi_nu_retro_c.png');


-- Ảnh cho Áo Len Nữ (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_d.png');
INSERT INTO ProductImage (product_id, image)
VALUES (242, 'product_images/ao_len_nu_micro_flare_a.png'),
       (242, 'product_images/ao_len_nu_micro_flare_b.png'),
       (242,'product_images/ao_len_nu_micro_flare_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (243, 'product_images/ao_len_nu_ruiche_a.png'),
       (243, 'product_images/ao_len_nu_ruiche_b.png'),
       (243,'product_images/ao_len_nu_ruiche_c.png');

-- Ảnh cho Chân Váy Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (243, 'product_images/chan_vay_nu_miu_miu_a.png'),
       (243, 'product_images/chan_vay_nu_miu_miu_b.png'),
       (243,'product_images/chan_vay_nu_miu_miu_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (243, 'product_images/chan_vay_nu_limisu_a.png'),
       (243, 'product_images/chan_vay_nu_limisu_b.png'),
       (243,'product_images/chan_vay_nu_limisu_c.png');

-- Cho các sản phẩm thuộc Subcategory "Trẻ Em":
-- Ảnh cho Quần Jean Trẻ Em (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (302, 'product_images/quan_jean_tre_em_babimama_a.png'),
       (302, 'product_images/quan_jean_tre_em_babimama_b.png'),
       (302,'product_images/quan_jean_tre_em_babimama_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (303, 'product_images/quan_jean_tre_em_tiingxuyu_a.png'),
       (303, 'product_images/quan_jean_tre_em_tiingxuyu_b.png'),
       (303,'product_images/quan_jean_tre_em_tiingxuyu_c.png');

-- Ảnh cho Quần Short Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_d.png');
INSERT INTO ProductImage (product_id, image)
VALUES (312, 'product_images/quan_short_tre_em_bobdog_a.png'),
       (312, 'product_images/quan_short_tre_em_bobdog_b.png'),
       (312,'product_images/quan_short_tre_em_bobdog_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (313, 'product_images/quan_short_tre_em_babyloveGo_a.png'),
       (313, 'product_images/quan_short_tre_em_babyloveGo_b.png'),
       (313,'product_images/quan_short_tre_em_babyloveGo_c.png');

-- Ảnh cho Áo Thun Trẻ Em (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (321, 'product_images/ao_thun_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (321, 'product_images/ao_thun_tre_em_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (321, 'product_images/ao_thun_tre_em_uniqlo_c.png');
-- Ảnh cho Áo Sơ Mi Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (331, 'product_images/ao_so_mi_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (331, 'product_images/ao_so_mi_tre_em_uniqlo_b.png');
-- Ảnh cho Áo Khoác Trẻ Em (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (341, 'product_images/ao_khoac_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (341, 'product_images/ao_khoac_tre_em_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (341, 'product_images/ao_khoac_tre_em_uniqlo_c.png');
-- Ảnh cho Váy Nữ Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (351, 'product_images/vay_nu_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (351, 'product_images/vay_nu_tre_em_uniqlo_b.png');
