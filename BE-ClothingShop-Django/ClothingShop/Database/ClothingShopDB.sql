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
        The Jean luôn nỗ lực trở thành đơn vị cung cấp các mẫu Jean tốt nhất trên thị trường, với mẫu mã đa dạng' ||
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
        'Quần Kaki Nam',
        'quan-kaki-nam-cao-cap',
        'Quần kaki nam kiểu dáng thanh lịch, phù hợp cho công sở và đi chơi.',
        450000,
        80,
        1,
        2
    ),
    (
     113,
        'Quần dài nam dáng suông kaki phong cách Hanlu Nhật Bản Streetwear mùa thu đông',
        'quan-kaki-nam-hanlu',
        'Quần dài nam kaki chất vải kaki gân chéo dày dặn, Dáng: Phom rộng mặc thoải phái, Phù hợp: Mặc đi làm, công sở, các hoạt động dã ngoại ngoài trời, dạo phố.',
        450000,
        80,
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
         'Áo Thun Nam',
        'ao-thun-nam',
        'Áo thun nam chất liệu cotton mềm mại, dễ chịu, phù hợp với mọi hoạt động.',
        250000,
        200,
        1,
        3
    ),
    (
     123,
         'Áo Thun Nam',
        'ao-thun-nam',
        'Áo thun nam chất liệu cotton mềm mại, dễ chịu, phù hợp với mọi hoạt động.',
        250000,
        200,
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
     141,
        'Áo Khoác Nam',
        'ao-khoac-nam',
        'Áo khoác nam thời trang, giữ ấm và phù hợp cho các ngày lạnh.',
        700000,
        40,
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
     251,
        'Chân Váy Nữ',
        'chan-vay-nu',
        'Chân váy nữ trẻ trung, giúp tôn dáng và dễ dàng kết hợp với áo sơ mi hoặc áo thun.',
        300000,
        150,
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
-- Ảnh cho Áo Sơ Mi Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (131, 'product_images/ao_so_mi_nam_GenViet_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (131, 'product_images/ao_so_mi_nam_GenViet_b.png');
-- Ảnh cho Áo Khoác Nam (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (141, 'product_images/ao_khoac_gio_BAD_HABITS_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (141 , 'product_images/ao_khoac_gio_BAD_HABITS_d.png');
-- Ảnh cho Quần Short Nam (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (151, 'product_images/quan_short_nam_BAD_HABITS_d.png');
-- Cho các sản phẩm thuộc Subcategory "Nữ":
-- Ảnh cho Quần Jean Nữ (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (201, 'product_images/quan_jean_nu_uniqlo_c.png');
-- Ảnh cho Quần Legging Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (211, 'product_images/quan_legging_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (211, 'product_images/quan_legging_nu_uniqlo_b.png');
-- Ảnh cho Áo Thun Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_thun_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_thun_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (221, 'product_images/ao_thun_nu_uniqlo_c.png');
-- Ảnh cho Áo Sơ Mi Nữ (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (231, 'product_images/ao_so_mi_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (231, 'product_images/ao_so_mi_nu_uniqlo_b.png');
-- Ảnh cho Áo Len Nữ (4 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (241, 'product_images/ao_len_nu_uniqlo_d.png');
-- Ảnh cho Chân Váy Nữ (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (251, 'product_images/chan_vay_nu_uniqlo_c.png');
-- Cho các sản phẩm thuộc Subcategory "Trẻ Em":
-- Ảnh cho Quần Jean Trẻ Em (3 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (301, 'product_images/quan_jean_tre_em_uniqlo_a.png');
-- Ảnh cho Quần Short Trẻ Em (2 ảnh)
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_a.png');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_b.png');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_c.png');
INSERT INTO ProductImage (product_id, image)
VALUES (311, 'product_images/quan_short_tre_em_uniqlo_d.png');
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
