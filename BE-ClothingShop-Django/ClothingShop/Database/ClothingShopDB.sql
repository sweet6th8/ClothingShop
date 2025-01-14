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
SELECT * FROM User
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
        104,
        ' quần jean nam cạp chun quần jean baggy',
        'quan-jean-nam-cap-chun',
        'Chúng Tôi Là Quần Jean Làm Bằng Tay Chuyên Nghiệp, Bán Tất Cả Các Loại Quần Áo Nam Thời Trang, Tất Cả Các Sản Phẩm Là Hàng Mới Và Hoàn Hảo, Hãy Yên Tâm Mua Hàng.',
        324000,
        730,
        1,
        1
    ),
    (
        105,
        'Quần Jean Túi Hộp Nam ',
        'quan-jean-nam-tui-hop',
        ' Quần Jean Túi Hộp 8 Túi Nam Nữ Kèm Dây Đai Phong Cách Đường Phố Quần Chất Lương Cao Ống Đứng Dáng Dài MIAA',
        173000,
        53,
        1,
        1
    ),
    (
        106,
        'Quần jean nam ROWAY',
        'quan-jean-nam-ROWAY',
        ' vải denim cotton, form suông | Jean suông trắng',
        299000,
        252,
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
     114,
        'Quần Dài Kaki GUPO Unisex Túi Hộp',
        'quan-kaki-nam-tui-hop',
        'Dáng quần bigsize ống rộng và suông mang lại cảm giác mặc thoải mái.Túi hộp có thể giúp bạn mang theo những vật dụng cần thiết như điện thoại di động, chìa khóa, ví tiền...',
        332000,
        100 ,
        1,
        2
    ),
    (
     115,
        'Quần kaki cạp chun tăng giảm thông minh trung niên ANCHI',
        'quan-kaki-nam-Anchi',
        ' Quần kaki cạp chun tăng giảm thông minh trung niên nam ANCHI được may từ chất vải cotton nhập khẩu cao cấp, thân thiện với làn da, thoáng mát và thấm hút mồ hôi tốt. Công nghệ cách nhiệt, chống tia UV, bảo vệ da trước cái nắng gay gắt của mùa hè. Chất kaki mềm, chống nhăn tối đa, co giãn nhẹ mang đến sự thoải mái cho người mặc.',
        335000,
        85 ,
        1,
        2
    ),
    (
     116,
        'Quần baggy kaki nam FABUMAN',
        'quan-kaki-nam-FABUMAN',
        'ống suông rộng dáng đứng trơn cạp chun unisex phong cách Hàn quốc 2023 hot trend',
        209000,
        158 ,
        1,
        2
    ),
    (
     121,
         'Áo Thun Nam ORGLS ',
        'ao-thun-nam',
        'Áo thun nam chất liệu cotton mềm mại, dễ chịu, phù hợp với mọi hoạt động.',
        250000,
        200,
        1,
        3
    ),
    (
     122,
         'Áo Thun TOMMY ',
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
         'Áo Thun Nam tay lỡ LEVIS ',
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
     124,
         'Áo ÁO POLO LEVIS  ',
        'ao-thun-nam-SAIGONESE',
        'Vải Cotton Phối Jean Denim Hoạ Tiết Shuriken Form Rộng Unisex Nam',
        143000,
        492,
        1,
        3
    ),
    (
     125,
         'Áo thun JACK JONES',
        'ao-thun-TEESHARKBUY',
        'Hàm lượng chất liệu: 71% (Bao gồm) -80% (Bao gồm). Yếu tố phổ biến: Chữ cái, Cũ, thời trang .Phong cách: Văn học Retro / Phong cách cổ điển',
        103000,
        97,
        1,
        3
    ),
    (
     126,
         'Áo thun ORIGINALS',
        'ao-thun-nam-LIFE',
        'Chất liệu: thun cotton 95% - 5% spandex co giãn 4 chiều, vải mềm, vải mịn, thoáng mát, không xù lông.',
        65000,
        931,
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
<<<<<<< Updated upstream
<<<<<<< Updated upstream

     (
     134,
        'Áo Sơ Mi Tay Ngắn Teelab Eco Oxford Signature',
        'ao-so-mi-nam-Teelab',
        'Không chỉ là thời trang, TEELAB còn là “phòng thí nghiệm” của tuổi trẻ - nơi nghiên cứu và cho ra đời năng lượng mang tên “Youth”. Chúng mình luôn muốn tạo nên những trải nghiệm vui vẻ, năng động và trẻ trung',
        179000,
        2460,
        1,
        4
    ),
     (
     135,
        'Áo Sơ Mi Tay Dài Kẻ Sọc Oversize ',
        'ao-so-mi-nam-ke-soc',
        'Lấy cảm hứng từ giới trẻ, sáng tạo liên tục, bắt kịp xu hướng và phát triển đa dạng các dòng sản phẩm là cách mà chúng mình hoạt động để tạo nên phong cách sống hằng ngày của bạn. ',
        255000,
        100,
        1,
        4
    ),
     (
     136,
        'Áo sơ mi đũi nam cổ trụ 2 túi cúc áo sơ mi cổ tàu ZUTEE',
        'ao-so-mi-co-tau-ZUTEE',
        'Sơ mi nam cổ tàu là kiểu áo cách tân mới được nhiều bạn nam yêu thích vì sự trẻ trung, năng động, phá cách nó mang lại.',
        160000,
=======
=======
>>>>>>> Stashed changes
     (
     134,
        'Áo Sơ Mi Nam Nữ JAMINE HOUSE Lụa',
        'ao-so-mi-JAMINE-HOUSE',
        'Lụa MANGO CAO CẤP, mềm mịn, Không nhăn, thấm hút  mồ hôi tốt. Giúp người mặc thoáng mát, không gò bó hay hầm bí. Cam kết không ra màu không bai nhão',
        143000,
        88,
        1,
        4
    ),
       (
     135,
        'Áo Sơ Mi Dài Tay Raglan',
        'ao-so-mi-Raglan',
        'Áo Sơ Mi Dài Tay Raglan Form Rộng Chất Dày Dặn Mềm Mại Phong Cách Hàn Quốc,Sơ Mi Nam Phối Tay Thoáng Mát Cao Cấp',
        149000,
        453,
        1,
        4
    ),
       (
     136,
        'Tianlesiwei American Street College Style',
        'ao-so-mi-nam-Tianlesiwei',
        'Để bạn mặc với sự tự tin và phong cách. Chú ý đến từng chi tiết và chất lượng tạo ra trang phục độc đáo, chất lượng cao sẽ khiến bạn nổi bật giữa đám đông.',
        87000,
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
        100,
        1,
        4
    ),
<<<<<<< Updated upstream
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
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
    (
     144,
        'Áo khoác Varsity Teelab Academy Colorific',
        'ao-khoac-Hoodie-Academy',
        'You will never be younger than you are at this very moment “Enjoy Your Youth!” ',
        320000,
        211,
        1,
        5
    ),
    (
     145,
        'Áo Khoác Varsity Bóng Chày ATINO',
        'ao-khoac-Hoodie-ATINO',
        'Áo Hoodie form rộng Tay Lỡ với chất nỉ bông mịn, ấm với đường may kỹ, lên dáng đẹp . ',
        250000,
        45,
        1,
        5
    ),
    (
     146,
        'Áo Khoác Gió Unisex DYPOISON NAD',
        'ao-khoac-DYPOISON',
        'Chống Gió Chống Nước Chống Bụi - Áo khoác dù nam nữ 2 lớp form rộng ',
        175000,
        288,
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
    ),
     (154,
        'Quần Short Phong Cách Harajuku',
        'quan-short-Harajuku',
        'Quần short nam thoải mái cho các hoạt động thể thao và du lịch.',
        76000,
        140,
        1,
        6
    ),
     (155,
        'Quần short nam ESEA',
        'quan-short-ESEA',
        'Quần short nam ESEA mùa hè mới phong cách Hàn Quốc cổ điển đơn giản thời trang nhiều túi dáng rộng thoải mái giản dị đa năng quần',
        184000,
        154,
        1,
        6
    ),
     (156,
        'Quần Short denim',
        'quan-short-denim',
        'Quần short nam thoải mái cho các hoạt động thể thao và du lịch.',
        127000,
        124,
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
        204,
        'Quần Jean Hari',
        'quan-jean-Hari',
        ' Quần được làm từ vải jean cao cấp, dày dặn và bền bỉ, mang lại cảm giác thoải mái và chắc chắn khi mặc.',
        147000,
        120,
        2,
        1
    ),
      (
        205,
        'Sinransinya Quần jean',
        'quan-jean-Sinransinya',
        'Chúng tôi có kinh nghiệm phong phú và sản phẩm chất lượng cao, tập trung vào chất lượng và giá cả thấp!Mang đến cho bạn trải nghiệm mua sắm tốt nhất!',
        243000,
        157,
        2,
        1
    ),
      (
        206,
        'Quần jean mới Retro ',
        'quan-jean-Retro',
        ' quần jean nam mới retro Phong Cách Đường Phố Cao Cấp Thích Hợp Dây Kéo Chia Bò Thiết Kế Cảm Giác Rời Đường Phố Cao Cấp Thi',
        235000,
        72,
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
     214,
        'Quần legging Lovito',
        'quan-legging-Lovito',
        'Thành phần: 95% Polyester + 5% Spandex, Độ vừa vặn: Vừa vặn thông thường',
        78000,
        154,
        2,
        2
    ),
     (
     215,
        'Quần Legging Cạp cao',
        'quan-legging-tam',
        'Quần legging nữ co giãn tốt, dễ dàng kết hợp với nhiều trang phục khác.',
        75100,
        91,
        2,
        2
    ),
     (
     216,
        'tập gym yoga chất liệu su đúc định hình nâng mông dáng ôm siêu co dãn',
        'quan-legging-yoga',
        'Quần legging nữ co giãn tốt, dễ dàng kết hợp với nhiều trang phục khác.',
        250000,
        200,
        2,
        2
    ),
    (
     221,
        'Áo Thun Nữ jdypisa',
        'ao-thun-nu-jdypisa',
        'Áo thun nữ dễ thương, chất liệu vải mát mẻ, thích hợp cho mùa hè.',
        180000,
        250,
        2,
        3
    ),
    (
     222,
        'Áo Thun onlravenna',
        'ao-thun-nu-onlravenna',
        ' Loại áo này “khó tính” hơn áo thun nam nữ ngắn tay, nếu biết cách mix đồ, bạn sẽ trở nên thật cá tính với phong cách thời trang đậm chất Hàn Quốc,
         nhưng nếu phối đồ không tốt trông bạn như đang “lọt thỏm” trong chiếc áo thun tay lỡ.',
        86000,
        100,
        2,
        3
    ),
    (
     223,
        'Áo phông deloris',
        'ao-thun-nu-deloris',
        '1.100% cotton, chất vải mềm mại mịn màng tinh tế,không bị co ngắn sau khi giặt.
2.Toàn bộ hình ảnh của cửa hàng đều là ảnh thật do xưởng tự chụp.
3.Sản phẩm của chúng tôi là dành cho cả nam và nữ,cặp đôi nhân tình và cặp đôi Chị Em đều có thể mặc được.',
        95000,
        350,
        2,
        3
    ),
     (
     224,
        'Áo Thun Nữ Calvin Klein',
        'ao-thun-nu-Calvin-Klein',
        'Áo thun nữ dễ thương, chất liệu vải mát mẻ, thích hợp cho mùa hè.',
        180000,
        250,
        2,
        3
    ),
     (
     225,
        'Áo Thun Nữ HERO',
        'ao-thun-nu-HERO',
        'Áo thun nữ dễ thương, chất liệu vải mát mẻ, thích hợp cho mùa hè.',
        180000,
        250,
        2,
        3
    ),
     (
     226,
        'Áo Thun Nữ Light Brown',
        'ao-thun-nu-Light',
        'Áo thun nữ dễ thương, chất liệu vải mát mẻ, thích hợp cho mùa hè.',
        180000,
        250,
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
     234,
        'Áo Sơ Mi Oxford Dáng Boxy ',
        'ao-so-mi-nu-Oxford',
        'Sản phẩm thiết kế đơn giản, năng động giúp người mặc thoải mái vận động nhưng vẫn mang lại sự thanh lịch và trẻ trung',
        183000,
        25,
        2,
        4
    ),
     (
     235,
        'Áo Kiểu Vải Rayon ',
        'ao-so-mi-nu-Rayon',
        'Với chất liệu Rayon mang lại cảm giác nhẹ nhàng thoải mái cho người mặc',
        183000,
        25,
        2,
        4
    ),
     (
     236,
        'Áo kiểu cổ chữ V ',
        'ao-so-mi-nu-v',
        'Áo kiểu cổ chữ V bằng vải dệt thoi hơi óng ánh. Có cổ, khuy dọc thân trước, tay dài với nẹp tay áo, măng sét cài khuy và vạt áo tròn.',
        183000,
        25,
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
     242,
        'Áo len Đỏ Năm Mới Giáng Sinh Slim Fit Cổ Tròn Micro Flare',
        'ao-len-nu-micro-flare',
        'Mặc đi chụp noel thì phải gọi là bá cháy bọ chét,Mặc lên dịu keo nha còn tôn dáng nữa Kích thước (CM)',
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
     244,
        'Áo len thu đông của millane',
        'ao-len-nu-millane',
        'Sản phẩm này được làm bằng vật liệu tái chế và được tạo ra bằng cách tái sử dụng các vật liệu trước hoặc sau khi tiêu dùng. Sử dụng vật liệu tái chế trong các sản phẩm giúp giảm lượng nguyên liệu thô đầu vào và chất thải, năng lượng và nước liên quan trong quá trình sản xuất nguyên liệu thô.',
        141000,
        425,
        2,
        5
    ),
      (
     245,
        'Áo len urban Classic',
        'ao-len-nu-urban',
        '
GIỚI THIỆU VỀ BẠN cung cấp giao hàng miễn phí cho các đơn hàng có giá trị từ 147.000đ. Chúng tôi cũng cung cấp dịch vụ hoàn trả miễn phí và chi trả chi phí đóng gói hàng hóa. Đơn đặt hàng với nhiều sản phẩm có thể được vận chuyển riêng.',
        147000,
        425,
        2,
        5
    ),
      (
     246,
        'Áo len MYLAVIE ',
        'ao-len-nu-MYLAVIE',
        'Sử dụng vật liệu tái chế trong các sản phẩm giúp giảm lượng nguyên liệu thô đầu vào và chất thải, năng lượng và nước liên quan trong quá trình sản xuất nguyên liệu thô.',
        482000,
        425,
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
     322,
        'Áo thun ngắn tay Jayja',
        'ao-thun-tre-em-jayja',
        'Áo thun ngắn tay Cotton nguyên chất cho bé trai phiên bản Hàn Quốc dáng rộng phong cách mới cho trẻ em Áo đẹp trai in hình',
        63000,
        193,
        3,
        3
    ),
    (
     323,
        'NASA áo thun cotton trẻ em 2024',
        'ao-thun-tre-em-nasa',
        'Chất liệu rất thoải mái và màu sắc thì đẹp tuyệt vời. Tôi đã mua thêm vài món nữa và hoàn toàn hài lòng. Bé tự chọn sản phẩm này, ngay từ lần đầu nhìn đã thích ngay họa tiết phía trước.
        Nhận hàng không hề thất vọng, sản phẩm thực tế còn đẹp hơn cả trong ảnh. Chất liệu mềm mại, dễ chịu, khi mặc lên người rất thời trang và thanh lịch.',
        88000,
        642,
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
     332,
        'Set sơ mi cộc tay cho bé trai đi tiệc kèm cà vạt 1 đến 7 tuổi BERNIE kids',
        'ao-so-mi-tre-em-BERNIE-kids',
        'sơ mi cho bé trai, bộ quần áo sơ mi kèm cà vạt cho bé trai dự sinh nhật, đi tiệc với gam màu basic, vintage, nổi bật nhưng không hề kén da bé mặc',
        180000,
        78,
        3,
        4
    ),
     (
     333,
        'Áo Sơ Mi Dài Tay BiBo',
        'ao-so-mi-tre-em-bibo',
        'Set sơ m dài tay cho bé trai mặc đi tiệc, đi đám cưới, sinh nhật, tất niên siêu thanh lịch, với thiết kế kèm cà vạt rời tiện lợi, tag kim loại nổi bật trưởng thành, quần lưng chun nhẹ nhàng, có túi thật 2 bên sườn, thoải mái cho bé yêu',
        430000,
        31,
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
     342,
        'Áo khoác Hoodie zip cho bé,chất liệu nỉ cotton,in hình sinh nhật Capy Bara',
        'ao-khoac-tre-em-Capy-Bara',
        'Áo khoác Hoodie zip chất liệu nỉ cotton in hình  Capy Bara với chất liệu thoáng mát giúp bé năng động hòa cuộc chơi',
        142000,
        43,
        3,
        5
    ),
     (
     343 ,
        'Áo khoác jean bé trai',
        'ao-khoac-tre-em-jean',
        'Áo khoác jean cho bé trai là hàng CAO CẤP, áo khoác bò dài tay khoác ngoài cho bé_T31 mặc cực kì thoải mái là sản phẩm chất lượng cao do Việt Nam sản xuất.',
        258000,
        24,
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
    ),
    (
     352,
        'Váy Thô Cotton bé gái thêu hoa tay bồng size từ 8kg-25kg IK2323 - I am Kids',
        'vay-nu-tre-em-im-kids',
        'Chất liệu mát mẻ mùa hè dành cho bé, đi du lịch, đi học , đi chơi đều rất đẹp và xinh xắn.',
        790000,
        40,
        3,
        6
    ),(
     353,
        'Set yếm lụa hoa sen cho bé gái dễ thương chất lụa sần BERNIE kids',
        'vay-nu-tre-em-BERNIE',
        'Yếm lụa hoa sen cho bé gái chất liệu lụa sần cao cấp, đanh mịn, mềm mại, thấm hút mồ hôi vượt trội, cho bé yêu cảm giác thoải mái vui chơi hoạt động',
        253000,
        10,
        3,
        6
    );
 


-- Cho các sản phẩm thuộc Subcategory "Nam": 
-- Ảnh cho Quần Jean Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (101, 'product_images/quan_jean_nam_G_Jeans_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (101, 'product_images/quan_jean_nam_G_Jeans_b.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (102, 'product_images/quan_jean_nam_wash_retro_a.jpg'),
       (102, 'product_images/quan_jean_nam_wash_retro_b.jpg'),
       (102, 'product_images/quan_jean_nam_wash_retro_c.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (103, 'product_images/quan_jean_thoi_trang_a.jpg'),
       (103, 'product_images/quan_jean_thoi_trang_b.jpg'),
       (103, 'product_images/quan_jean_thoi_trang_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (104, 'product_images/quan_jean_nam_cap_chun_a.jpg'),
       (104, 'product_images/quan_jean_nam_cap_chun_b.jpg'),
       (104, 'product_images/quan_jean_nam_cap_chun_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (105, 'product_images/quan_jean_nam_tui_hop_a.jpg'),
       (105, 'product_images/quan_jean_nam_tui_hop_b.jpg'),
       (105, 'product_images/quan_jean_nam_tui_hop_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (106, 'product_images/quan_jean_nam_ROWAY_a.jpg'),
       (106, 'product_images/quan_jean_nam_ROWAY_b.jpg'),
       (106, 'product_images/quan_jean_nam_ROWAY_c.jpg');

-- Ảnh cho Quần Kaki Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (111, 'product_images/quan_kaki_nam_Gen_Viet_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (111, 'product_images/quan_kaki_nam_Gen_Viet_b.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (112, 'product_images/quan_kaki_nam_cao_cap_a.jpg'),
       (112, 'product_images/quan_kaki_nam_cao_cap_b.jpg'),
       (112, 'product_images/quan_kaki_nam_cao_cap_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (113, 'product_images/quan_kaki_nam_hanlu_a.jpg'),
       (113, 'product_images/quan_kaki_nam_hanlu_b.jpg'),
       (113, 'product_images/quan_kaki_nam_hanlu_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (114, 'product_images/quan_kaki_nam_tui_hop_a.jpg'),
       (114, 'product_images/quan_kaki_nam_tui_hop_b.jpg'),
       (114, 'product_images/quan_kaki_nam_tui_hop_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (115, 'product_images/quan_kaki_nam_Anchi_a.jpg'),
       (115, 'product_images/quan_kaki_nam_Anchi_b.jpg'),
       (115, 'product_images/quan_kaki_nam_Anchi_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (116, 'product_images/quan_kaki_nam_FABUMAN_a.jpg'),
       (116, 'product_images/quan_kaki_nam_FABUMAN_b.jpg'),
       (116, 'product_images/quan_kaki_nam_FABUMAN_c.jpg');


-- Ảnh cho Áo Thun Nam (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (121, 'product_images/ao_thun_1_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (121, 'product_images/ao_thun_1_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (121, 'product_images/ao_thun_1_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (122, 'product_images/ao_thun_nam_2_a.jpg'),
       (122, 'product_images/ao_thun_nam_2_b.jpg'),
       (122, 'product_images/ao_thun_nam_2_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (123, 'product_images/ao_thun_nam_3_a.jpg'),
       (123, 'product_images/ao_thun_nam_3_b.jpg'),
       (123, 'product_images/ao_thun_nam_3_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (124, 'product_images/ao_thun_nam_4a.jpg'),
       (124, 'product_images/ao_thun_nam_4c.jpg'),
       (124, 'product_images/ao_thun_nam_4b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (125, 'product_images/ao_thun_nam_5a.jpg'),
       (125, 'product_images/ao_thun_nam_5b.jpg'),
       (125, 'product_images/ao_thun_nam_5c .jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (126, 'product_images/ao_thun_nam_6a.jpg'),
       (126, 'product_images/ao_thun_nam_6b.jpg'),
       (126, 'product_images/ao_thun_nam_6c.jpg');


-- Ảnh cho Áo Sơ Mi Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (131, 'product_images/ao_so_mi_nam_GenViet_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (131, 'product_images/ao_so_mi_nam_GenViet_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (132, 'product_images/ao_so_mi_nam_Pastel_Premium_a.jpg'),
       (132, 'product_images/ao_so_mi_nam_Pastel_Premium_b.jpg'),
       (132, 'product_images/ao_so_mi_nam_Pastel_Premium_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (133, 'product_images/ao_so_mi_nam_tay_ngan_a.jpg'),
       (133, 'product_images/ao_so_mi_nam_tay_ngan_b.jpg'),
       (133 ,'product_images/ao_so_mi_nam_tay_ngan_c.jpg');
INSERT INTO ProductImage (product_id, image)
<<<<<<< Updated upstream
<<<<<<< Updated upstream
VALUES (134, 'product_images/ao_so_mi_nam_Teelab_a.jpg'),
       (134 ,'product_images/ao_so_mi_nam_Teelab_b.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (135, 'product_images/ao_so_mi_nam_ke_soc_a.jpg'),
       (135, 'product_images/ao_so_mi_nam_ke_soc_b.jpg'),
       (135 ,'product_images/ao_so_mi_nam_ke_soc_c.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (136, 'product_images/ao_so_mi_co_tau_ZUTEE_a.jpg'),
       (136, 'product_images/ao_so_mi_co_tau_ZUTEE_b.jpg'),
       (136 ,'product_images/ao_so_mi_co_tau_ZUTEE_c.jpg');
=======
=======
>>>>>>> Stashed changes
VALUES (134, 'product_images/ao_so_mi_JAMINE_HOUSE_a.jpg'),
       (134, 'product_images/ao_so_mi_JAMINE_HOUSE_b.jpg'),
       (134 ,'product_images/ao_so_mi_JAMINE_HOUSE_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (135, 'product_images/ao_so_mi_Raglan_a.jpg'),
       (135, 'product_images/ao_so_mi_Raglan_b.jpg'),
       (135 ,'product_images/ao_so_mi_Raglan_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (136, 'product_images/ao_so_mi_nam_Tianlesiwei_a.jpg'),
       (136, 'product_images/ao_so_mi_nam_Tianlesiwei_b.jpg'),
       (136 ,'product_images/ao_so_mi_nam_Tianlesiwei_c.jpg');
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes


-- Ảnh cho Áo Khoác Nam (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (141 , 'product_images/ao_khoac_gio_BAD_HABITS_d.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (142, 'product_images/ao_khoac_nam_Bomber_a.jpg'),
       (142, 'product_images/ao_khoac_nam_Bomber_b.jpg'),
       (142 ,'product_images/ao_khoac_nam_Bomber_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (143, 'product_images/ao_khoac_Hoodie_nam_a.jpg'),
       (143, 'product_images/ao_khoac_Hoodie_nam_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (144, 'product_images/ao_khoac_Hoodie_Academy_a.jpg'),
       (144, 'product_images/ao_khoac_Hoodie_Academy_b.jpg'),
       (144 ,'product_images/ao_khoac_Hoodie_Academy_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (145, 'product_images/ao_khoac_ATINO_a.jpg'),
       (145, 'product_images/ao_khoac_ATINO_b.jpg'),
       (145 ,'product_images/ao_khoac_ATINO_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (146, 'product_images/ao_khoac_DYPOISON_a.jpg'),
       (146, 'product_images/ao_khoac_DYPOISON_b.jpg'),
       (146 ,'product_images/ao_khoac_DYPOISON_c.jpg');

-- Ảnh cho Quần Short Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_d.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (152, 'product_images/quan_short_tui_hop_nam_a.jpg'),
       (152, 'product_images/quan_short_tui_hop_nam_b.jpg'),
       (152, 'product_images/quan_short_tui_hop_nam_c.jpg'),
       (152, 'product_images/quan_short_tui_hop_nam_d.jpg'),
       (152 ,'product_images/quan_short_tui_hop_nam_e.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (153, 'product_images/quan_short_JOGGER_nam_a.jpg'),
       (153, 'product_images/quan_short_JOGGER_nam_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (154, 'product_images/quan_short_Harajuku_a.jpg'),
       (154, 'product_images/quan_short_Harajuku_b.jpg'),
       (154, 'product_images/quan_short_Harajuku_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (155, 'product_images/quan_short_ESEA_a.jpg'),
       (155, 'product_images/quan_short_ESEA_b.jpg'),
       (155, 'product_images/quan_short_ESEA_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (156, 'product_images/quan_short_denim_a.jpg'),
       (156, 'product_images/quan_short_denim_b.jpg'),
       (156, 'product_images/quan_short_denim_c.jpg');

-- Cho các sản phẩm thuộc Subcategory "Nữ":
-- Ảnh cho Quần Jean Nữ (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (202, 'product_images/quan_jean_SUNAIXUE_nu_a.jpg'),
       (202, 'product_images/quan_jean_SUNAIXUE_nu_b.jpg'),
       (202 ,'product_images/quan_jean_SUNAIXUE_nu_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (203, 'product_images/quan_jean_lovito_nu_a.jpg'),
       (203, 'product_images/quan_jean_lovito_nu_b.jpg'),
       (203 ,'product_images/quan_jean_lovito_nu_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (204, 'product_images/quan_jean_Hari_a.jpg'),
       (204, 'product_images/quan_jean_Hari_b.jpg'),
       (204 ,'product_images/quan_jean_Hari_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (205, 'product_images/quan_jean_Sinransinya_a.jpg'),
       (205, 'product_images/quan_jean_Sinransinya_b.jpg'),
       (205 ,'product_images/quan_jean_Sinransinya_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (206, 'product_images/quan_jean_Retro_a.jpg'),
       (206, 'product_images/quan_jean_Retro_b.jpg'),
       (206 ,'product_images/quan_jean_Retro_c.jpg');

-- Ảnh cho Quần Legging Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (211, 'product_images/quan_legging_nu_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (211, 'product_images/quan_legging_nu_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (212, 'product_images/quan_legging_ECOCHIC_nu_a.jpg'),
       (212, 'product_images/quan_legging_ECOCHIC_nu_b.jpg'),
       (212 ,'product_images/quan_legging_ECOCHIC_nu_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (213, 'product_images/quan_legging_Fitme_Zeta_nu_a.jpg'),
       (213 ,'product_images/quan_legging_Fitme_Zeta_nu_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (214, 'product_images/quan_legging_Lovito_a.jpg'),
       (214, 'product_images/quan_legging_Lovito_b.jpg'),
       (214 ,'product_images/quan_legging_Lovito_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (215, 'product_images/quan_legging_tam_a.jpg'),
       (215, 'product_images/quan_legging_tam_b.jpg'),
       (215 ,'product_images/quan_legging_tam_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (216, 'product_images/quan_jean_Retro_a.jpg'),
       (216, 'product_images/quan_jean_Retro_b.jpg'),
       (216 ,'product_images/quan_jean_Retro_c.jpg');
-- Ảnh cho Áo Thun Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_nu_jdypisa_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_nu_jdypisa_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_nu_jdypisa_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (222, 'product_images/ao_nu_onlravenna_a.jpg'),
       (222, 'product_images/ao_nu_onlravenna_b.jpg'),
       (222 ,'product_images/ao_nu_onlravenna_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (223, 'product_images/ao_nu_deloris_a.jpg'),
       (223, 'product_images/ao_nu_deloris_b.jpg'),
       (223 ,'product_images/ao_nu_deloris_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (224, 'product_images/ao_thun_nu_Calvin_Klein_a.jpg'),
       (224, 'product_images/ao_thun_nu_Calvin_Klein_b.jpg'),
       (224 ,'product_images/ao_thun_nu_Calvin_Klein_c.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (225, 'product_images/ao_thun_nu_HERO_a.jpg'),
       (225, 'product_images/ao_thun_nu_HERO_a.jpg'),
       (225 ,'product_images/ao_thun_nu_HERO_a.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (226, 'product_images/ao_thun_nu_Light_a.jpg'),
       (226, 'product_images/ao_thun_nu_Light_b.jpg'),
       (226 ,'product_images/ao_thun_nu_Light_c.jpg');

-- Ảnh cho Áo Sơ Mi Nữ (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (231, 'product_images/ao_so_mi_nu_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (231, 'product_images/ao_so_mi_nu_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (232, 'product_images/ao_so_mi_nu_ceci_a.jpg'),
       (232, 'product_images/ao-so-mi-nu-ceci_b.jpg'),
       (232,'product_images/ao-so-mi-nu-ceci_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (233, 'product_images/ao_so_mi_nu_retro_a.jpg'),
       (233, 'product_images/ao_so_mi_nu_retro_b.jpg'),
       (233,'product_images/ao_so_mi_nu_retro_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (234, 'product_images/ao_so_mi_nu_Oxford_a.jpg'),
       (234, 'product_images/ao_so_mi_nu_Oxford_b.jpg'),
       (234,'product_images/ao_so_mi_nu_Oxford_c.jpg');
    INSERT INTO ProductImage (product_id, image)
VALUES (235, 'product_images/ao_so_mi_nu_Rayon_a.jpg'),
       (235, 'product_images/ao_so_mi_nu_Rayon_b.jpg'),
       (235,'product_images/ao_so_mi_nu_Rayon_c.jpg');
    INSERT INTO ProductImage (product_id, image)
VALUES (236, 'product_images/ao_so_mi_nu_v_a.jpg'),
       (236, 'product_images/ao_so_mi_nu_v_b.jpg'),
       (236,'product_images/ao_so_mi_nu_v_c.jpg');

-- Ảnh cho Áo Len Nữ (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_d.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (242, 'product_images/ao_len_nu_micro_flare_a.jpg'),
       (242, 'product_images/ao_len_nu_micro_flare_b.jpg'),
       (242,'product_images/ao_len_nu_micro_flare_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (243, 'product_images/ao_len_nu_ruiche_a.jpg'),
       (243, 'product_images/ao_len_nu_ruiche_b.jpg'),
       (243,'product_images/ao_len_nu_ruiche_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (244, 'product_images/ao_len_nu_millane_a.jpg'),
       (244, 'product_images/ao_len_nu_millane_b.jpg'),
       (244,'product_images/ao_len_nu_millane_c.jpg');
    INSERT INTO ProductImage (product_id, image)
VALUES (245, 'product_images/ao_len_nu_urban_a.jpg'),
       (245, 'product_images/ao_len_nu_urban_b.jpg'),
       (245,'product_images/ao_len_nu_urban_c.jpg');
    INSERT INTO ProductImage (product_id, image)
VALUES (246, 'product_images/ao_len_nu_MYLAVIE_a.jpg'),
       (246, 'product_images/ao_len_nu_MYLAVIE_b.jpg'),
       (246,'product_images/ao_len_nu_MYLAVIE_c.jpg');
    
-- Ảnh cho Chân Váy Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (243, 'product_images/chan_vay_nu_miu_miu_a.jpg'),
       (243, 'product_images/chan_vay_nu_miu_miu_b.jpg'),
       (243,'product_images/chan_vay_nu_miu_miu_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (243, 'product_images/chan_vay_nu_limisu_a.jpg'),
       (243, 'product_images/chan_vay_nu_limisu_b.jpg'),
       (243,'product_images/chan_vay_nu_limisu_c.jpg');

-- Cho các sản phẩm thuộc Subcategory "Trẻ Em":
-- Ảnh cho Quần Jean Trẻ Em (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (302, 'product_images/quan_jean_tre_em_babimama_a.jpg'),
       (302, 'product_images/quan_jean_tre_em_babimama_b.jpg'),
       (302,'product_images/quan_jean_tre_em_babimama_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (303, 'product_images/quan_jean_tre_em_tiingxuyu_a.jpg'),
       (303, 'product_images/quan_jean_tre_em_tiingxuyu_b.jpg'),
       (303,'product_images/quan_jean_tre_em_tiingxuyu_c.jpg');

-- Ảnh cho Quần Short Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_d.jpg');

INSERT INTO ProductImage (product_id, image)
VALUES (312, 'product_images/quan_short_tre_em_bobdog_a.jpg'),
       (312, 'product_images/quan_short_tre_em_bobdog_b.jpg'),
       (312,'product_images/quan_short_tre_em_bobdog_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (313, 'product_images/quan_short_tre_em_babyloveGo_a.jpg'),
       (313, 'product_images/quan_short_tre_em_babyloveGo_b.jpg'),
       (313,'product_images/quan_short_tre_em_babyloveGo_c.jpg');

-- Ảnh cho Áo Thun Trẻ Em (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (321, 'product_images/ao_thun_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (321, 'product_images/ao_thun_tre_em_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (321, 'product_images/ao_thun_tre_em_uniqlo_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (322, 'product_images/ao_thun_tre_em_jayja_a.jpg'),
       (322, 'product_images/ao_thun_tre_em_jayja_b.jpg'),
       (322,'product_images/ao_thun_tre_em_jayja_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (323, 'product_images/ao_thun_tre_em_nasa_a.jpg'),
       (323, 'product_images/ao_thun_tre_em_nasa_b.jpg'),
       (323, 'product_images/ao_thun_tre_em_nasa_c.jpg');

-- Ảnh cho Áo Sơ Mi Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (331, 'product_images/ao_so_mi_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (331, 'product_images/ao_so_mi_tre_em_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (332, 'product_images/ao_so_mi_tre_em_BERNIE_kids_a.jpg'),
       (332, 'product_images/ao_so_mi_tre_em_BERNIE_kids_b.jpg'),
       (332, 'product_images/ao_so_mi_tre_em_BERNIE_kids_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (333, 'product_images/ao_so_mi_tre_em_bibo_a.jpg'),
       (333, 'product_images/ao_so_mi_tre_em_bibo_b.jpg'),
       (333, 'product_images/ao_so_mi_tre_em_bibo_c.jpg');

-- Ảnh cho Áo Khoác Trẻ Em (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (341, 'product_images/ao_khoac_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (341, 'product_images/ao_khoac_tre_em_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (341, 'product_images/ao_khoac_tre_em_uniqlo_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (342, 'product_images/ao_khoac_tre_em_Capy_Bara_a.jpg'),
       (342, 'product_images/ao_khoac_tre_em_Capy_Bara_b.jpg'),
       (342, 'product_images/ao_khoac_tre_em_Capy_Bara_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (343, 'product_images/ao_khoac_tre_em_jean_a.jpg'),
       (343, 'product_images/ao_khoac_tre_em_jean_b.jpg'),
       (343, 'product_images/ao_khoac_tre_em_jean_c.jpg');


-- Ảnh cho Váy Nữ Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (351, 'product_images/vay_nu_tre_em_uniqlo_a.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (351, 'product_images/vay_nu_tre_em_uniqlo_b.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (352, 'product_images/vay_nu_tre_em_im_kids_a.jpg'),
       (352, 'product_images/vay_nu_tre_em_im_kids_b.jpg'),
       (352, 'product_images/vay_nu_tre_em_im_kids_c.jpg');
INSERT INTO ProductImage (product_id, image)
VALUES (353, 'product_images/vay_nu_tre_em_BERNIE_a.jpg'),
       (353, 'product_images/vay_nu_tre_em_BERNIE_b.jpg'),
       (353, 'product_images/vay_nu_tre_em_BERNIE_c.jpg');