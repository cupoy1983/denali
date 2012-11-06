DROP TABLE IF EXISTS `%DB_PREFIX%share_goods_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_goods_index` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_1count` int(11) DEFAULT '0',
  `collect_7count` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  `min_price` decimal(10,2) DEFAULT '0.00',
  `max_price` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_1count` (`collect_1count`),
  KEY `collect_7count` (`collect_7count`),
  KEY `collect_count` (`collect_count`),
  KEY `price` (`min_price`,`max_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_goods_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_goods_match` (
  `share_id` int(11) NOT NULL,
  `content_match` text NOT NULL,
  PRIMARY KEY (`share_id`),
  FULLTEXT KEY `content_match` (`content_match`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_images_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_images_index` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_1count` int(11) DEFAULT '0',
  `collect_7count` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_1count` (`collect_1count`),
  KEY `collect_7count` (`collect_7count`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_image_sizes`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_image_sizes` (
  `id` varchar(60) NOT NULL DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `is_cut` tinyint(1) DEFAULT '0',
  `is_water` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `%DB_PREFIX%share_image_sizes` (`id`, `width`, `height`, `is_cut`, `is_water`, `status`) VALUES
('image_1', 100, 100, 1, 0, 1),
('image_2', 200, 999, 0, 0, 1),
('image_3', 468, 468, 0, 1, 1),
('image_4', 160, 160, 0, 0, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%share_look_best`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_look_best` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_look_goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_look_goods` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_1count` int(11) DEFAULT '0',
  `collect_7count` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_1count` (`collect_1count`),
  KEY `collect_7count` (`collect_7count`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_look_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_look_index` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_1count` int(11) DEFAULT '0',
  `collect_7count` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_1count` (`collect_1count`),
  KEY `collect_7count` (`collect_7count`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_match` (
  `share_id` int(11) NOT NULL,
  `content_match` text NOT NULL,
  PRIMARY KEY (`share_id`),
  FULLTEXT KEY `content_match` (`content_match`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_photo`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `share_id` int(11) NOT NULL DEFAULT '0',
  `type` enum('default','dapei','look') NOT NULL DEFAULT 'default',
  `img_id` int(11) NOT NULL DEFAULT '0',
  `sort` smallint(5) DEFAULT '10',
  `base_id` int(11) DEFAULT '0',
  `base_share` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `share_id` (`share_id`),
  KEY `base_id` (`base_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%share_photo_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_photo_index` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_1count` int(11) DEFAULT '0',
  `collect_7count` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_1count` (`collect_1count`),
  KEY `collect_7count` (`collect_7count`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_photo_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_photo_match` (
  `share_id` int(11) NOT NULL,
  `content_match` text NOT NULL,
  PRIMARY KEY (`share_id`),
  FULLTEXT KEY `content_match` (`content_match`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_tags` (
  `share_id` int(11) NOT NULL,
  `tag_name` varchar(100) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  KEY `share_id` (`share_id`),
  KEY `tag_name` (`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_text_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_text_index` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_text_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_text_match` (
  `share_id` int(11) NOT NULL,
  `content_match` text NOT NULL,
  PRIMARY KEY (`share_id`),
  FULLTEXT KEY `content_match` (`content_match`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_user_dapei`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_user_dapei` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_user_goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_user_goods` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_user_images`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_user_images` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_user_look`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_user_look` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_user_photo`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_user_photo` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%shop`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_id` smallint(6) NOT NULL DEFAULT '0',
  `shop_name` varchar(255) DEFAULT '',
  `shop_logo` varchar(255) DEFAULT '',
  `shop_url` varchar(255) DEFAULT '',
  `recommend_count` int(11) DEFAULT '0',
  `taoke_url` varchar(255) DEFAULT '',
  `data` text,
  `sort` smallint(5) NOT NULL DEFAULT '100',
  PRIMARY KEY (`shop_id`),
  KEY `cate_id` (`cate_id`),
  KEY `recommend_count` (`recommend_count`),
  KEY `sort` (`sort`),
  KEY `shop_url` (`shop_url`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%shop_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_category` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(6) DEFAULT NULL,
  `name` varchar(100) DEFAULT '',
  `sort` smallint(5) DEFAULT '100',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12;

INSERT INTO `%DB_PREFIX%shop_category` (`id`, `parent_id`, `name`, `sort`) VALUES
(1, 0, '风格', 100),
(2, 0, '看点', 100),
(3, 1, '日韩杂志款', 100),
(4, 1, '小清新混搭', 100),
(5, 1, '欧美高街', 100),
(6, 1, '休闲混搭', 100),
(7, 2, '外贸原单', 100),
(8, 2, '潮流女鞋', 100),
(9, 2, '流行饰品', 100),
(10, 2, '包包手袋', 100),
(11, 2, '手套配件', 100);

DROP TABLE IF EXISTS `%DB_PREFIX%shop_check`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_check` (
  `shop_id` int(11) NOT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%shop_disable`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_disable` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(255) DEFAULT '',
  `shop_logo` varchar(255) DEFAULT '',
  `shop_url` varchar(255) DEFAULT '',
  PRIMARY KEY (`shop_id`),
  KEY `shop_url` (`shop_url`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

DROP TABLE IF EXISTS `%DB_PREFIX%shop_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_match` (
  `id` int(11) NOT NULL DEFAULT '0',
  `shop_name` text,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `shop_name` (`shop_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%shop_share`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_share` (
  `shop_id` int(11) DEFAULT '0',
  `share_id` int(11) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  UNIQUE KEY `shop_share` (`shop_id`,`share_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%style_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%style_category` (
  `cate_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(6) DEFAULT '0',
  `cate_name` varchar(80) DEFAULT '',
  `short_name` varchar(60) NOT NULL DEFAULT '',
  `desc` varchar(255) DEFAULT '',
  `sort` smallint(6) NOT NULL DEFAULT '100',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_fix` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cate_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%style_category_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%style_category_tags` (
  `cate_id` smallint(6) NOT NULL,
  `tag_id` smallint(6) NOT NULL,
  `sort` smallint(5) NOT NULL DEFAULT '100',
  KEY `cate_id` (`cate_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%sys_conf`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_conf` (
  `name` varchar(80) NOT NULL DEFAULT '',
  `val` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `list_type` tinyint(1) NOT NULL COMMENT '0:手动输入 1:单选 2:下拉 3:文本域 4:图像',
  `val_arr` varchar(255) NOT NULL COMMENT '可选的值的集合。序列化存放',
  `group_id` tinyint(2) NOT NULL,
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `is_js` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `%DB_PREFIX%sys_conf` (`name`, `val`, `status`, `sort`, `list_type`, `val_arr`, `group_id`, `is_show`, `is_js`) VALUES
('SITE_NAME', '方维', 1, 1, 0, '', 1, 1, 0),
('SITE_TITLE', '方维购物分享', 1, 2, 0, '', 1, 1, 0),
('SITE_KEYWORDS', '方维,方维购物分享,网购,淘宝网购物,淘宝网导购', 1, 12, 3, '', 1, 1, 0),
('SITE_DESCRIPTION', '方维购物分享是一个纯买家社区，百万网友一起淘宝网购物，挖掘好店、分享网购，您可以获得最可靠的店铺排行和淘宝网购物分享。', 1, 13, 3, '', 1, 1, 0),
('SITE_TMPL', 'pink2', 1, 6, 2, '', 1, 1, 0),
('SYS_ADMIN', 'fanwe', 1, 7, 0, '', 1, 1, 0),
('SITE_LOGO', './logo.gif', 1, 3, 4, '', 1, 1, 0),
('FOOTER_HTML', '<p>\r\n	方维购物分享系统 系统版本：v2.21 版权所有&copy; 方维</p>\r\n', 1, 14, 5, '方维购物分享系统 系统版本：v2.21 版权所有© 方维\r\n', 1, 1, 0),
('SECOND_ARTICLES', '    当您点击"我接受以上条款，确定"，即表示您已经充分了解并同意接受以下条款（而无论您是否已经注册为会员）：\r\n    1. 二手闲置交易信息发布公告板（即本页，下称本服务）是为网友提供的一项公益性质信息服务，我们不参与任何交易过程，也不对任何交易信息的真实性负责；\r\n    2. 本服务仅供网友发布二手闲置交易信息，不允许发布任何批量贩卖、代购等信息。不欢迎专业卖家和电商在此发布信息。\r\n    3. 发布交易信息请遵守国家及当地的法律、法规，不发布任何有可能影响网站平台安全的信息（包括但不限于武器、毒品、淫秽等信息）。我们保留无理由随时删除任何交易信息的权利。\r\n    4. 交易双方在交易前请充分沟通，交易过程请尽可能选择"支付宝担保交易"服务或同城见面交易。网站不对任何交易后果（包括担不限于财物损失）负责，也不承担任何连带责任，所有交易后果由交易双方独自承担。', 1, 0, 0, '', 7, 0, 0),
('EXPIRED_TIME', '3600', 1, 8, 0, '', 1, 1, 0),
('SYS_VERSION', '2.21', 1, 10, 0, '', 1, 0, 0),
('TIME_ZONE', '8', 1, 9, 0, '', 1, 1, 0),
('DEFAULT_LANG', 'zh-cn', 1, 10, 2, '', 1, 1, 0),
('APP_LOG', '0', 1, 11, 2, '0,1', 1, 1, 0),
('FOOT_LOGO', './foot_logo.gif', 1, 4, 4, '', 1, 1, 0),
('LINK_LOGO', './link_logo.gif', 1, 5, 4, '', 1, 1, 0),
('BG_COLOR', '#ffffff', 1, 10, 0, '', 2, 1, 0),
('MAX_UPLOAD', '2048', 1, 10, 0, '', 2, 1, 0),
('ALLOW_UPLOAD_EXTS', 'jpg,gif,png,jpeg', 1, 10, 0, '', 2, 1, 0),
('WATER_MARK', '1', 1, 10, 1, '0,1', 2, 1, 0),
('BIG_WIDTH', '500', 1, 10, 0, '', 2, 1, 0),
('BIG_HEIGHT', '0', 1, 10, 0, '', 2, 1, 0),
('SMALL_WIDTH', '200', 1, 10, 0, '', 2, 1, 0),
('SMALL_HEIGHT', '0', 1, 10, 0, '', 2, 1, 0),
('WATER_IMAGE', '', 1, 10, 4, '', 2, 1, 0),
('WATER_POSITION', '5', 1, 10, 2, '1,2,3,4,5', 2, 1, 0),
('WATER_ALPHA', '50', 1, 10, 0, '', 2, 1, 0),
('AUTO_GEN_IMAGE', '0', 1, 10, 2, '0,1', 2, 1, 0),
('URL_MODEL', '0', 1, 10, 2, '0,1', 1, 1, 0),
('SECOND_TAOBAO_SIGN', '', 1, 0, 0, '', 7, 0, 0),
('SECOND_TAOBAO_FORUMID', '', 1, 0, 0, '', 7, 0, 0),
('SITE_SERVICE_EMAIL', 'service@fanwe.com', 1, 9, 0, '', 1, 1, 0),
('SHARE_GOODS_COUNT', '3', 1, 10, 0, '', 3, 0, 1),
('SHARE_PIC_COUNT', '3', 1, 10, 0, '', 3, 0, 1),
('SHARE_TAG_COUNT', '10', 1, 10, 0, '', 3, 0, 1),
('SMTP_SERVER', '', 1, 10, 0, '', 5, 1, 0),
('SMTP_PORT', '25', 1, 10, 0, '', 5, 1, 0),
('SMTP_ACCOUNT', '', 1, 10, 0, '', 5, 1, 0),
('SMTP_PASSWORD', '', 1, 10, 0, '', 5, 1, 0),
('SMTP_IS_SSL', '0', 1, 10, 1, '0,1', 5, 1, 0),
('SMTP_AUTH', '1', 1, 10, 1, '0,1', 5, 1, 0),
('INTEGRATE_CODE', 'fanwe', 1, 0, 0, '', 0, 0, 0),
('INTEGRATE_CONFIG', 'a:14:{s:5:"uc_id";s:1:"2";s:6:"uc_key";s:64:"d1Pft6mdz5Wdq6fcS6G536P5B9P0mb86o9i7q8Bfw6p6mdS9t3nfz768f2ves0F8";s:6:"uc_url";s:30:"http://localhost/bbs/uc_server";s:5:"uc_ip";s:0:"";s:10:"uc_connect";s:4:"post";s:10:"uc_charset";s:5:"utf-8";s:7:"db_host";s:9:"localhost";s:7:"db_user";s:4:"root";s:7:"db_name";s:6:"discuz";s:7:"db_pass";s:0:"";s:6:"db_pre";s:7:"cdb_uc_";s:10:"db_charset";s:4:"utf8";s:13:"cookie_domain";s:0:"";s:11:"cookie_path";s:1:"/";}', 1, 0, 0, '', 0, 0, 0),
('INTEGRATE_FIELD_ID', 'uid', 1, 0, 0, '', 0, 0, 0),
('USER_IS_MEDAL', '1', 1, 10, 2, '0,1', 6, 0, 0),
('USER_AGREEMENT', '', 1, 16, 6, '', 6, 0, 0),
('SECOND_STATUS', '1', 1, 0, 0, '', 7, 0, 0),
('ALBUM_DEFAULT_TAGS', 'a:10:{i:0;s:6:"时尚";i:1;s:6:"购物";i:2;s:6:"品牌";i:3;s:6:"美容";i:4;s:6:"生活";i:5;s:6:"街拍";i:6;s:6:"秀场";i:7;s:6:"明星";i:8;s:9:"搭配秀";i:9;s:6:"晒货";}', 0, 0, 0, '', 8, 0, 0),
('ALBUM_TAG_COUNT', '4', 0, 0, 0, '', 8, 0, 0),
('TODAY_MAX_SCORE', '100', 1, 0, 0, '', 6, 0, 0),
('USER_REGISTER_SCORE', '10', 1, 0, 0, '', 6, 0, 0),
('USER_AVATAR_SCORE', '10', 1, 10, 0, '', 6, 0, 0),
('USER_LOGIN_SCORE', '1', 1, 0, 0, '', 6, 0, 0),
('USER_REFERRAL_SCORE', '10', 1, 0, 0, '', 6, 0, 0),
('CLEAR_REFERRAL_SCORE', '-20', 1, 0, 0, '', 6, 0, 0),
('SHARE_DEFAULT_SCORE', '1', 1, 0, 0, '', 6, 0, 0),
('SHARE_IMAGE_SCORE', '5', 1, 0, 0, '', 6, 0, 0),
('DELETE_SHARE_IMAGE_SCORE', '-20', 1, 0, 0, '', 6, 0, 0),
('DELETE_SHARE_DEFAULT_SCORE', '-10', 1, 0, 0, '', 6, 0, 0),
('USER_SORE_RULE', '<h1>\r\n	会员加减分规则</h1>\r\n<p>\r\n	1、会员注册＋10分；</p>\r\n<p>\r\n	2、每日登陆＋1分；</p>\r\n<p>\r\n	3、上传头像＋10分；</p>\r\n<p>\r\n	4、会员成功邀请＋10分；</p>\r\n<p>\r\n	5、删除取消会员邀请－20分；</p>\r\n<p>\r\n	6、发布普通(无图)分享＋1分；</p>\r\n<p>\r\n	7、发布有图分享＋5分；</p>\r\n<p>\r\n	8、管理员删除普通分享－10分；</p>\r\n<p>\r\n	9、管理员删除有图分享－20分；</p>\r\n', 1, 16, 5, '', 6, 0, 0),
('REGRESULT_TO_BIND', '0', 1, 8, 2, '0,1', 6, 0, 0),
('BIND_PUSH_WEIBO', '0', 1, 8, 2, '0,1', 6, 0, 0),
('BOOK_PHOTO_GOODS', '0', 1, 8, 2, '0,1,2', 1, 0, 0),
('SHARE_IS_TAG', '1', 1, 10, 0, '', 3, 0, 1),
('SHARE_IS_CATE', '0', 1, 10, 0, '', 3, 0, 1),
('SHARE_CHECK_TYPE', '0', 1, 10, 0, '', 3, 0, 0),
('SHARE_INTERVAL_TIME', '10', 1, 10, 0, '', 3, 0, 0),
('SHARE_CACHE_TIME', '600', 1, 10, 0, '', 3, 0, 0),
('IMAGE_CREATE_QUALITY', '90', 1, 10, 0, '', 2, 1, 0),
('SHARE_GOODS_SHOW_TYPE', '0', 1, 10, 0, '', 3, 0, 0),
('SHARE_PB_LOAD_COUNT', '10', 1, 10, 0, '', 3, 0, 0),
('SHARE_PB_ITEM_COUNT', '16', 1, 10, 0, '', 3, 0, 0),
('SHARE_IS_CATE_BY_TAGS', '0', 1, 10, 0, '', 3, 0, 0),
('IS_OPEN_COMMISSION', '1', 1, 8, 0, '', 10, 0, 0),
('GROUP_AGREEMENT', '', 1, 10, 0, '', 9, 0, 0),
('GROUP_FANS_COUNT', '10', 1, 10, 0, '', 9, 0, 0),
('GROUP_SHARE_COUNT', '10', 1, 10, 0, '', 9, 0, 0),
('USER_COMMISSION_TYPE', '2', 1, 10, 0, '', 10, 0, 0),
('COMMISSION_DESC', '<p>\r\n佣金说明</p>\r\n', 1, 10, 0, '', 10, 0, 0),
('GROUP_GROUP_IDS', '', 1, 10, 0, '', 9, 0, 0),
('GROUP_IS_CHECK', '1', 1, 10, 0, '', 9, 0, 0),
('GROUP_IS_OPEN', '1', 1, 10, 0, '', 9, 0, 0),
('GROUP_ADMIN_UID', '', 1, 10, 0, '', 9, 0, 0),
('GROUP_ADMIN_FID', '', 1, 10, 0, '', 9, 0, 0),
('APP_DOWN_URL', '', 1, 5, 0, '', 1, 1, 0),
('APK_DOWN_URL', '', 1, 5, 0, '', 1, 1, 0),
('LOG_APP', '', 1, 10, 0, '', 1, 0, 0),
('SHOP_CLOSED', '0', 1, 2, 2, '0,1', 1, 1, 0);

DROP TABLE IF EXISTS `%DB_PREFIX%sys_msg`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_msg` (
  `mid` mediumint(8) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `user_name` varchar(60) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`mid`),
  KEY `end_time` (`end_time`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%sys_msg_member`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_msg_member` (
  `mid` mediumint(8) NOT NULL,
  `uid` int(11) NOT NULL,
  `dateline` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mid`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%sys_msg_user_group`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_msg_user_group` (
  `mid` mediumint(8) NOT NULL,
  `gid` smallint(6) NOT NULL,
  KEY `mid` (`mid`),
  KEY `gid` (`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%sys_msg_user_no`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_msg_user_no` (
  `mid` mediumint(8) NOT NULL,
  `uid` int(11) NOT NULL,
  KEY `mid` (`mid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%sys_msg_user_yes`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_msg_user_yes` (
  `mid` mediumint(8) NOT NULL,
  `uid` int(11) NOT NULL,
  KEY `mid` (`mid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%sys_notice`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `content` text,
  `create_time` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`status`),
  KEY `uid_2` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%taobaoke_report`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%taobaoke_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trade_id` bigint(20) unsigned DEFAULT '0',
  `num_iid` bigint(20) unsigned DEFAULT '0',

  `item_title` varchar(255) DEFAULT '',
  `item_num` smallint(6) DEFAULT '0',
  `pay_price` decimal(10,2) DEFAULT '0.00',
  `real_pay_fee` decimal(10,2) DEFAULT '0.00',
  `commission_rate` decimal(10,2) DEFAULT '0.00',
  `commission` decimal(10,2) DEFAULT '0.00',
  `outer_code` varchar(20) DEFAULT '',
  `app_key` varchar(20) DEFAULT '',
  `pay_time` int(10) unsigned DEFAULT '0',
  `pay_day` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `num_iid` (`num_iid`),
  KEY `outer_code` (`outer_code`),
  KEY `pay_day` USING BTREE(`pay_day`) 
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%taobaoke_report_temp`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%taobaoke_report_temp` (
  `trade_id` bigint(20) unsigned DEFAULT '0',
  `num_iid` bigint(20) unsigned DEFAULT '0',
  `item_title` varchar(255) DEFAULT '',
  `item_num` smallint(6) DEFAULT '0',
  `pay_price` decimal(10,2) DEFAULT '0.00',
  `real_pay_fee` decimal(10,2) DEFAULT '0.00',
  `commission_rate` decimal(10,2) DEFAULT '0.00',
  `commission` decimal(10,2) DEFAULT '0.00',
  `outer_code` varchar(20) DEFAULT '',
  `app_key` varchar(20) DEFAULT '',
  `pay_time` int(10) unsigned DEFAULT '0',
  `pay_day` int(10) unsigned DEFAULT '0',
  KEY `report_order` USING BTREE(`pay_time`,`trade_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gid` smallint(6) NOT NULL,
  `email` varchar(60) DEFAULT '',
  `user_name` varchar(60) DEFAULT '',
  `password` char(32) DEFAULT '',
  `money` decimal(10,2) DEFAULT '0.00',
  `credits` int(11) DEFAULT '0',
  `reg_time` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `email_status` tinyint(1) DEFAULT '0',
  `avatar` int(11) DEFAULT '0',
  `is_daren` tinyint(1) DEFAULT '0',
  `ucenter_id` int(11) DEFAULT '0',
  `invite_id` int(11) NOT NULL DEFAULT '0',
  `is_buyer` tinyint(1) NOT NULL DEFAULT '0',
  `buyer_level` smallint(2) NOT NULL DEFAULT '0',
  `seller_level` smallint(2) NOT NULL DEFAULT '0',
  `server_code` varchar(60) DEFAULT '',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `gid` (`gid`),
  KEY `email` USING BTREE(`email`) ,
  KEY `invite_id` (`invite_id`),
  KEY `credits` (`credits`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_auction_log`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_auction_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT '0.00',
  `content` text,
  `is_pay` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  `adm` text,
  `pay_time` int(11) DEFAULT '0',
  `create_day` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `is_pay` (`is_pay`),
  KEY `create_day` (`create_day`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_authority`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_authority` (
  `uid` int(11) NOT NULL,
  `module` varchar(60) NOT NULL DEFAULT '',
  `action` varchar(60) NOT NULL DEFAULT '',
  `sort` smallint(3) DEFAULT '0',
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_bind`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_bind` (
  `uid` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `keyid` varchar(100) NOT NULL,
  `info` text,
  `sync` text,
  `refresh_time` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `uid_type` (`uid`,`type`),
  KEY `uid` (`uid`),
  KEY `refresh_time` (`refresh_time`),
  KEY `type_keyid` (`type`,`keyid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_category` (
  `id` smallint(6) NOT NULL,
  `name` varchar(100) DEFAULT '',
  `cate_desc` text,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_category_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_category_tags` (
  `tag_id` smallint(6) NOT NULL,
  `cate_id` smallint(6) NOT NULL,
  KEY `tag_id` (`tag_id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_collect`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_collect` (
  `uid` int(11) NOT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `rec_id` int(11) DEFAULT NULL,
  `share_id` int(11) DEFAULT '0',
  `type` tinyint(4) DEFAULT '0' COMMENT '0:普通 1:论坛 2:问答 3:二手',
  `create_time` int(11) DEFAULT '0',
  KEY `uid` (`uid`),
  KEY `c_uid` (`c_uid`),
  KEY `rec_id` (`rec_id`),
  KEY `share_id` (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_consignee`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_consignee` (
  `uid` int(11) NOT NULL,
  `region_lv1` int(11) NOT NULL DEFAULT '0',
  `region_lv2` int(11) NOT NULL DEFAULT '0',
  `region_lv3` int(11) NOT NULL DEFAULT '0',
  `region_lv4` int(11) NOT NULL DEFAULT '0',
  `address` varchar(255) NOT NULL DEFAULT '',
  `mobile_phone` varchar(255) NOT NULL DEFAULT '',
  `fix_phone` varchar(255) NOT NULL DEFAULT '',
  `consignee` varchar(255) NOT NULL DEFAULT '',
  `zip` varchar(255) NOT NULL DEFAULT '',
  `qq` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `fax_phone` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_count`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_count` (
  `uid` int(11) NOT NULL,
  `follows` int(11) unsigned DEFAULT '0',
  `fans` int(11) unsigned DEFAULT '0',
  `collects` int(11) unsigned DEFAULT '0',
  `favs` int(11) unsigned DEFAULT '0',
  `threads` int(11) unsigned DEFAULT '0',
  `photos` int(11) unsigned DEFAULT '0',
  `goods` int(11) unsigned DEFAULT '0',
  `shares` int(11) unsigned DEFAULT '0',
  `forums` int(11) unsigned DEFAULT '0',
  `forum_posts` int(11) unsigned DEFAULT '0',
  `albums` int(11) unsigned DEFAULT '0',
  `referrals` int(11) unsigned DEFAULT '0',
  `looks` int(11) DEFAULT '0',
  `dapei` int(11) DEFAULT '0',
  `groups` int(11) DEFAULT '0',
  `events` int(11) DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_daren`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_daren` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `img` varchar(255) NOT NULL DEFAULT '',
  `gift_name` varchar(255) DEFAULT '',
  `gift_url` varchar(255) DEFAULT '',
  `sponsor_name` varchar(255) DEFAULT '',
  `sponsor_url` varchar(255) DEFAULT '',
  `is_best` tinyint(1) DEFAULT '0',
  `is_index` tinyint(1) NOT NULL DEFAULT '0',
  `index_img` varchar(255) NOT NULL DEFAULT '',
  `day_time` int(11) DEFAULT '0',
  `reason` varchar(255) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `cids` varchar(255) DEFAULT '',
  `sort` smallint(5) DEFAULT '100',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `is_index` (`is_index`),
  KEY `status` (`status`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_daren_cate`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_daren_cate` (
  `id` int(11) DEFAULT '0',
  `cid` smallint(6) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `sort` smallint(5) DEFAULT '100',
  `content` varchar(255) DEFAULT '',
  KEY `id` (`id`),
  KEY `cid` (`cid`),
  KEY `uid` (`uid`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_follow`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_follow` (
  `f_uid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  KEY `uid` (`uid`),
  KEY `f_uid` (`f_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_group`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_group` (
  `gid` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT '',
  `type` enum('system','user') DEFAULT 'user',
  `is_special` tinyint(4) DEFAULT '0',
  `is_admin` tinyint(1) DEFAULT '0',
  `stars` tinyint(1) DEFAULT '0',
  `color` varchar(8) DEFAULT '',
  `icon` varchar(255) DEFAULT '',
  `credits_higher` int(11) DEFAULT '0',
  `credits_lower` int(11) DEFAULT '0',
  `commission_rate` decimal(10,2) DEFAULT '0.00',
  `buy_rate` decimal(10,2) DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8;

INSERT INTO `%DB_PREFIX%user_group` (`gid`, `name`, `type`, `is_special`, `is_admin`, `stars`, `color`, `icon`, `credits_higher`, `credits_lower`, `commission_rate`, `buy_rate`, `status`) VALUES
(6, '游客', 'system', 0, 0, 0, '', '', 0, 0, '0.00', '0.00', 1),
(7, '普通会员', 'system', 0, 0, 0, '', '', 1000, 0, '10.00', '10.00', 1);

DROP TABLE IF EXISTS `%DB_PREFIX%user_group_authority`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_group_authority` (
  `gid` int(11) NOT NULL,
  `module` varchar(60) NOT NULL DEFAULT '',
  `action` varchar(60) NOT NULL DEFAULT '',
  KEY `uid` (`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_match` (
  `uid` int(11) NOT NULL DEFAULT '0',
  `user_name` varchar(255) DEFAULT '',
  PRIMARY KEY (`uid`),
  FULLTEXT KEY `user_name` (`user_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_medal`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_medal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `deadline` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_2` (`uid`,`mid`),
  KEY `uid` (`uid`),
  KEY `mid` (`mid`),
  KEY `deadline` (`deadline`),
  KEY `type` (`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_me_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_me_tags` (
  `uid` int(11) NOT NULL,
  `tag_name` varchar(100) DEFAULT NULL,
  `tag_name_match` text,
  KEY `uid` (`uid`),
  KEY `tag_name` (`tag_name`),
  FULLTEXT KEY `tag_name_match` (`tag_name_match`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_money_log`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_money_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `create_time` int(11) unsigned NOT NULL,
  `create_day` int(11) unsigned NOT NULL DEFAULT '0',
  `content` text,
  `rec_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rec_module` varchar(30) NOT NULL DEFAULT '',
  `rec_action` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `create_day` (`create_day`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) DEFAULT NULL COMMENT 'author_id为0时为系统消息',
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`mid`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_0`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_0` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',

  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_1`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_1` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_2`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_2` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_3`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_3` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_4`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_4` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_5`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_5` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_6`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_6` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_7`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_7` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_8`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_8` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_9`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_9` (
  `miid` int(11) unsigned NOT NULL DEFAULT '0',
  `mlid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`,`status`,`dateline`),
  KEY `dateline` (`mlid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_index` (
  `miid` int(11) NOT NULL AUTO_INCREMENT,
  `mlid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`miid`),
  KEY `mlid` (`mlid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_list`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_list` (
  `mlid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `subject` varchar(80) NOT NULL,
  `members` smallint(5) NOT NULL DEFAULT '0',
  `min_max` varchar(23) NOT NULL,
  `dateline` int(11) NOT NULL DEFAULT '0',
  `msg_config` text NOT NULL,
  PRIMARY KEY (`mlid`),
  KEY `type` (`type`),
  KEY `min_max` (`min_max`),
  KEY `uid` (`uid`,`dateline`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_member`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_member` (
  `mlid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL,
  `last_update` int(11) NOT NULL DEFAULT '0',
  `last_dateline` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mlid`,`uid`),
  KEY `is_new` (`is_new`),
  KEY `last_update` (`uid`,`last_update`),
  KEY `last_dateline` (`uid`,`last_dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_msg_rel`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_msg_rel` (
  `mid` int(11) NOT NULL,
  `uid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_notice`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_notice` (
  `uid` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:关注，2:喜欢，3:评论，4:提到，5:信件，6:通知',
  `num` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`uid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_profile`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_profile` (
  `uid` int(11) NOT NULL DEFAULT '0',
  `nick_name` varchar(60) DEFAULT '',
  `gender` tinyint(1) DEFAULT '0',
  `birth_year` smallint(6) DEFAULT '0',
  `birth_month` smallint(6) DEFAULT '0',
  `birth_day` smallint(4) DEFAULT '0',
  `reside_province` int(11) DEFAULT '0',
  `reside_city` int(11) DEFAULT '0',
  `school` varchar(100) DEFAULT '',
  `workplace` varchar(100) DEFAULT '',
  `occupation` smallint(6) DEFAULT '0',
  `weibo` varchar(255) DEFAULT '',
  `hobby` varchar(255) DEFAULT '',
  `introduce` text,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_score_log`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL,
  `create_day` int(11) NOT NULL DEFAULT '0',
  `content` text,
  `rec_id` int(11) NOT NULL,
  `rec_module` varchar(255) NOT NULL,
  `rec_action` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `create_day` (`create_day`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%user_statistics`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_statistics` (
  `uid` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `last_time` int(11) DEFAULT '0',
  UNIQUE KEY `uid` (`uid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_status`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_status` (
  `uid` int(11) NOT NULL,
  `reg_ip` char(15) DEFAULT '',
  `last_ip` char(15) DEFAULT '',
  `last_time` int(11) DEFAULT '0',
  `last_activity` int(11) DEFAULT '0',
  `active_hash` varchar(255) DEFAULT '',
  `reset_hash` varchar(255) DEFAULT '',
  `edit_name_count` smallint(5) DEFAULT '0',
  `black_users` text,
  `medals` text,
  `last_share` int(11) DEFAULT '0',
  `cache_data` text,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%user_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_tags` (
  `tag_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(100) DEFAULT '',
  `sort` smallint(5) DEFAULT '100',
  PRIMARY KEY (`tag_id`),
  KEY `tag_name` (`tag_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=73 ;

INSERT INTO `%DB_PREFIX%user_tags` (`tag_id`, `tag_name`, `sort`) VALUES
(1, '擅长找白菜', 100),
(2, '擅长找白菜', 100),
(3, '擅长搭配', 100),
(4, '擅长找差价', 100),
(5, '擅长找同款', 100),
(6, '擅长找原单', 100),
(7, '擅长组团', 100),
(8, '擅长找好店', 100),
(9, '擅长分享团购', 100),
(10, '擅长护肤', 100),
(11, '擅长彩妆', 100),
(12, '擅长美白', 100),
(13, '擅长护发', 100),
(14, '擅长减重', 100),
(15, '擅长淘包包', 100),
(16, '擅长淘配饰', 100),
(17, '擅长淘鞋子', 100),
(18, '格子控', 100),
(19, '细节控', 100),
(20, '豹纹控', 100),
(21, '黑色控', 100),
(22, '丝袜控', 100),
(23, '色彩控', 100),
(24, '条纹控', 100),
(25, '波点控', 100),
(26, '白菜控', 100),
(27, '蓝色控', 100),
(28, '衬衫控', 100),
(29, '蕾丝控', 100),
(30, '原单控', 100),
(31, '美瞳控', 100),
(32, '蝴蝶结控', 100),
(33, '粉色控', 100),
(34, '鞋子控', 100),
(35, '牛仔控', 100),
(36, '碎花控', 100),
(37, '平底鞋控', 100),
(38, '高跟鞋控', 100),
(39, '真丝控', 100),
(40, '护肤控', 100),
(41, '饰品控', 100),
(42, '面膜控', 100),
(43, '棉麻控', 100),
(44, '学院风格', 100),
(45, '欧美风格', 100),
(46, '混搭风格', 100),
(47, '甜美风格', 100),
(48, '清新风格', 100),
(49, '英伦风格', 100),
(50, 'vintage复古风格', 100),
(51, 'BF风格', 100),
(52, '极简风格', 100),
(53, '中性风格', 100),
(54, '朋克风格', 100),
(55, '摇滚风格', 100),
(56, '森女风格', 100),
(57, '洛丽塔风格', 100),
(58, '公主风格', 100),
(59, '名媛风格', 100),
(60, '波西米亚风格', 100),
(61, '民族风格', 100),
(62, '休闲风格', 100),
(63, '御姐风格', 100),
(64, '性感风格', 100),
(65, '模特', 100),
(66, '造型师', 100),
(67, '品牌工作人员', 100),
(68, '美容编辑', 100),
(69, '时尚编辑', 100),
(70, '时尚媒体', 100),
(71, '时装买手', 100),
(72, '我在其它网站是达人', 100);

DROP TABLE IF EXISTS `%DB_PREFIX%word`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%word` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `cid` smallint(6) NOT NULL DEFAULT '0',
  `word` varchar(255) NOT NULL DEFAULT '',
  `replacement` varchar(255) NOT NULL DEFAULT '',
  `type` tinyint(2) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `cid` (`cid`),
  KEY `word` (`word`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

INSERT INTO `%DB_PREFIX%word` (`id`, `cid`, `word`, `replacement`, `type`, `status`) VALUES
(1, 1, '法轮', '', 1, 1),
(2, 1, 'fa轮', '', 1, 1),
(3, 1, '9评', '', 1, 1),
(4, 1, '九凭', '', 1, 1),
(5, 1, 'LHZ', '', 1, 1),
(6, 1, '自焚', '', 1, 1),
(7, 1, '藏字石', '', 1, 1),
(8, 1, '李洪X', '', 1, 1),
(9, 1, '9ping', '', 1, 1),
(10, 1, '九ping', '', 1, 1),
(11, 1, '自fen', '', 1, 1),
(12, 1, '法X功', '', 1, 1),
(13, 1, '轮子功', '', 1, 1),
(14, 2, '美女上门', '***', 2, 1),
(15, 2, '上网文凭', '***', 2, 1),
(16, 2, '赌博机', '***', 2, 1),
(17, 2, '卖血', '***', 2, 1),
(18, 2, '出售肾', '***', 2, 1),
(19, 2, '出售器官', '***', 2, 1),
(20, 2, '眼角膜', '***', 2, 1),
(21, 2, '求肾', '***', 2, 1),
(22, 2, '换肾', '***', 2, 1),
(23, 2, '有偿肾', '***', 2, 1),
(24, 2, '预测答案', '***', 2, 1),
(25, 2, '考前预测', '***', 2, 1),
(26, 2, '押题', '***', 2, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%word_type`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%word_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `%DB_PREFIX%word_type` (`id`, `name`, `status`) VALUES
(1, '政治', 1),
(2, '社会', 1);

DROP TABLE IF EXISTS `%DB_PREFIX%yiqifa_report`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%yiqifa_report` (
  `unique_id` varchar(20) NOT NULL DEFAULT '',
  `action_id` int(11) DEFAULT '0',
  `action_name` varchar(255) DEFAULT '',
  `sid` int(11) DEFAULT '0',
  `wid` int(11) DEFAULT '0',
  `order_no` varchar(30) DEFAULT '',
  `order_time` int(11) DEFAULT '0',
  `prod_id` bigint(20) DEFAULT '0',
  `prod_name` varchar(255) DEFAULT NULL,
  `prod_count` smallint(6) DEFAULT '0',
  `prod_money` decimal(10,2) DEFAULT '0.00',
  `comm_type` varchar(60) DEFAULT '',
  `commision` decimal(10,2) DEFAULT '0.00',
  `feed_back` varchar(30) DEFAULT NULL,
  `status` enum('F','A','R') DEFAULT NULL,
  `prod_type` varchar(60) DEFAULT '',
  `am` decimal(10,2) DEFAULT '0.00',
  `create_date` int(11) DEFAULT '0',
  `order_day` int(11) DEFAULT '0',
  PRIMARY KEY (`unique_id`),
  KEY `status` (`status`),
  KEY `order_no` (`order_no`),
  KEY `order_day` USING BTREE(`order_day`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%yiqifa_shop`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%yiqifa_shop` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  `domain` varchar(255) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `icon` varchar(255) DEFAULT '',
  `status` tinyint(1) DEFAULT '0',
  `sort` smallint(5) DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `%DB_PREFIX%yiqifa_shop` (`id`, `name`, `domain`, `url`, `icon`, `status`, `sort`) VALUES
(100002, '我耶商城', '', 'http://www.woye.com/', '', 0, 100),
(100003, '百丽官方购物网', '', 'http://www.topshoes.cn/', '', 0, 100),
(100004, '麦包包', '', 'http://www.mbaobao.com/', '', 0, 100),
(100006, '芬理希梦', '', 'http://www.felissimo.com.cn', '', 0, 100),
(100007, '视客眼镜', '', 'http://www.sigo.cn/', '', 0, 100),
(100008, '乐友网', '', 'http://www.leyou.com.cn', '', 0, 100),
(100010, 'Yeecare益生康健', '', 'http://www.yeecare.com/', '', 0, 100),
(100011, '我买网', '', 'http://www.womai.com/', '', 0, 100),
(100013, 'X档案', '', 'http://www.x-playboy.com', '', 0, 100),
(100015, '亚马逊', 'http://*.amazon.cn', 'http://www.amazon.cn/', 'amazon.png', 1, 100),
(100016, '京东商城', 'http://*.360buy.com', 'http://www.360buy.com/', '360buy.png', 1, 100),
(100017, '趣玩网', '', 'http://www.quwan.com/', '', 0, 100),
(100020, 'D1优尚网', '', 'http://www.d1.com.cn/', '', 0, 100),
(100022, '玛萨玛索', '', 'http://www.masamaso.com/', '', 0, 100),
(100023, '伊家网', '', 'http://www.ejia.com/', '', 0, 100),
(100024, 'NO5时尚广场', '', 'http://www.no5.com.cn/', '', 0, 100),
(100025, '桔色', '', 'http://www.x.com.cn/', '', 0, 100),
(100028, '金象网', '', 'http://www.jxdyf.com/', '', 0, 100),
(100029, '逛街网', '', 'http://www.togj.com/', '', 0, 100),
(100031, '时尚起义', '', 'http://www.shishangqiyi.com/', '', 0, 100),
(100034, '中国鲜花专递', '', 'http://www.cnfse.com/', '', 0, 100),
(100035, '一点达', '', 'http://www.yidianda.com/', '', 0, 100),
(100038, '新蛋商城', '', 'http://www.newegg.com.cn/', '', 0, 100),
(100040, '爱之谷商城', '', 'http://www.aizhigu.com/', '', 0, 100),
(100046, '99网上书城', '', 'http://www.99read.com/', '', 0, 100),
(100047, '凡客诚品', 'http://*.vancl.com', 'http://www.vancl.com/', 'vancl.png', 1, 100),
(100048, '红孩子商城', '', 'http://www.redbaby.com.cn/', '', 0, 100),
(100049, '当当网', 'http://*.dangdang.com', 'http://www.dangdang.com/', 'dangdang.png', 1, 100),
(100050, '乐蜂网', '', 'http://www.lafaso.com/', '', 0, 100),
(100051, '一号店', '', 'http://www.yihaodian.com/', '', 0, 100),
(100055, '易迅', '', 'http://www.51buy.com', '', 0, 100),
(100056, '麦考林', '', 'http://www.m18.com/', '', 0, 100),
(100057, '北发图书网', '', 'http://www.beifabook.com/', '', 0, 100),
(100060, '名鞋库', '', 'http://www.s.cn', '', 0, 100),
(100062, '名品打折网', '', 'http://www.dazhe.cn/', '', 0, 100),
(100071, '天天网', '', 'http://www.tiantian.com/', '', 0, 100),
(100073, '漂亮100', '', 'http://www.piaoliang100.com/', '', 0, 100),
(100076, '怡致服饰', '', 'http://www.viszs.com/', '', 0, 100),
(100080, '我要我乐', '', 'http://www.515l.com', '', 0, 100),
(100087, '太平鸟服饰', '', 'http://www.pb89.com', '', 0, 100),
(100088, '合亚眼镜', '', 'http://www.yaahe.cn', '', 0, 100),
(100098, '兰缪内衣', '', 'http://www.lamiu.com', '', 0, 100),
(100107, '尚透社', '', 'http://www.chictalk.com.cn/', '', 0, 100),
(100108, '维思诺', '', 'http://www.vsnoon.org', '', 0, 100),
(100115, '阿福购物网', '', 'http://www.afffff.com', '', 0, 100),
(100116, '乐到家商城', '', 'http://www.ledaojia.com/', '', 0, 100),
(100118, '春水堂', '', 'http://www.oyeah.cn', '', 0, 100),
(100123, '唯品会', '', 'http://www.vipshop.com/index.php', '', 0, 100),
(100124, '酒美网', '', 'http://www.winenice.com/', '', 0, 100),
(100126, '淘鞋网', '', 'http://www.taoxie.cn', '', 0, 100),
(100143, '卡当网', '', 'http://www.kadang.com/', '', 0, 100),
(100144, '橡果国际', '', 'http://www.chinadrtv.com', '', 0, 100),
(100146, '俏物悄语', '', 'http://www.ihush.com/', '', 0, 100),
(100147, '法瑞儿', '', 'http://www.outlets001.com/', '', 0, 100),
(100157, '欧莱诺', '', 'http://www.olomo.com', '', 0, 100),
(100164, '聚尚网', '', 'http://www.fclub.cn', '', 0, 100),
(100169, 'Justyle男装', '', 'http://www.justyle.com/', '', 0, 100),
(100175, '苏宁易购', '', 'http://www.suning.cn', '', 0, 100),
(100177, '母婴之家', '', 'http://www.muyingzhijia.com', '', 0, 100),
(100178, '伊人堂', '', 'http://www.oltang.com', '', 0, 100),
(100179, '好实再', '', 'http://www.hsz88.cn/', '', 0, 100),
(100182, '体坛网', '', 'http://www.titan24.com', '', 0, 100),
(100184, '和茶网', '', 'http://www.hecha.cn', '', 0, 100),
(100189, '型尚网', '', 'http://www.51xingshang.com', '', 0, 100),
(100190, '李宁', '', 'http://www.e-lining.com', '', 0, 100),
(100195, '绿森数码', '', 'http://www.lusen.com', '', 0, 100),
(100198, '品橙网', '', 'http://www.orange3c.com/', '', 0, 100),
(100203, '开心人大药房', '', 'http://www.360kxr.com/', '', 0, 100),
(100204, '新七天电器网', '', 'http://www.new7.com/', '', 0, 100),
(100205, '爱慕官网', '', 'http://www.aimer.com.cn', '', 0, 100),
(100207, '银泰网', '', 'http://www.yintai.com', '', 0, 100),
(100208, '海泰客', '', 'http://www.hi-tec.cn', '', 0, 100),
(100209, '皙肤泉', '', 'http://www.xifuquan.com/ ', '', 0, 100),
(100210, '古缇女包', '', 'http://www.chris-tina.com', '', 0, 100),
(100215, 'TS官网', '', 'http://www.onlyts.com ', '', 0, 100),
(100216, '飞虎乐购', '', 'http://www.efeihu.com', '', 0, 100),
(100217, '衣街尚品', '', 'http://www.estreet.cn', '', 0, 100),
(100218, '酷运动', '', 'http://www.k121.com/ ', '', 0, 100),
(100220, '上品折扣网', '', 'http://www.shopin.net', '', 0, 100),
(100221, 'likefac化妆品商城', '', 'http://www.likeface.com', '', 0, 100),
(100223, '高鸿商城', '', 'http://www.tao3c.com/', '', 0, 100),
(100225, '中国零食网', '', 'http://www.lingshi.com', '', 0, 100),
(100226, '零度官方商城', '', 'http://www.ezeroshop.com', '', 0, 100),
(100228, '唯伊网', '', 'http://www.w1.cn', '', 0, 100),
(100251, '第九大道', '', 'http://www.9dadao.com', '', 0, 100),
(100260, '牛尔官网', '', 'http://www.naruko.com.cn', '', 0, 100),
(100265, '优雅100', '', 'http://www.uya100.com', '', 0, 100),
(100324, '丽人密码', '', 'http://www.lirenmima.com/', '', 0, 100),
(100332, 'VIP特卖', '', 'http://www.viptemai.com', '', 0, 100),
(100333, '莎啦啦', '', 'http://www.salala.com.cn', '', 0, 100),
(100334, '棉花宝宝', '', 'http://www.mianhuabaobao.com/', '', 0, 100),
(100335, '依纷内衣', '', 'http://www.efshop.com', '', 0, 100),
(100336, '瑞丝家居', '', 'http://www.reislife.com', '', 0, 100),
(100337, '封面网', '', 'http://www.513523.com', '', 0, 100),
(100340, '久尚网', '', 'http://www.do93.com', '', 0, 100),
(100341, '国美电器', '', 'http://www.gome.com.cn/', '', 0, 100),
(100342, '蔚蓝网', '', 'http://www.wl.cn/', '', 0, 100),
(100344, '美美商城', '', 'http://www.maymay.cn', '', 0, 100),
(100345, '薄荷时尚', '', 'http://www.boheshop.com', '', 0, 100),
(100346, 'nala', '', 'http://www.nala.com.cn', '', 0, 100),
(100347, 'TCL', '', 'http://www.etcl.cn/', '', 0, 100),
(100348, '桃花坞', '', 'http://www.taohv.com.cn', '', 0, 100),
(100352, '寺库', '', 'http://www.secoo.com/', '', 0, 100),
(100353, '有好网', '', 'http://www.buyfine.net', '', 0, 100),
(100354, '1折店', '', 'http://www.yizhedian.com', '', 0, 100),
(100356, '依芙娜', '', 'http://www.efnuw.com', '', 0, 100),
(100358, 'pba官方商城', '', 'http://www.pba.cn/', '', 0, 100),
(100359, '孕肤宝', '', 'http://www.yunfubao.com', '', 0, 100),
(100360, '韩都衣舍', '', 'http://www.hstyle.com/', '', 0, 100),
(100361, '银联在线', '', 'http://emall.chinapay.com/', '', 0, 100),
(100362, '为为网', '', 'http://www.homevv.com', '', 0, 100),
(100364, 'CAMEL骆驼官方商城', '', 'http://www.camel.com.cn', '', 0, 100),
(100366, '九九维康', '', 'http://www.99vk.com', '', 0, 100),
(100367, '莱客', '', 'http://laikoo.com/', '', 0, 100),
(100368, '卓美网', '', 'http://www.zm7.cn/index.php ', '', 0, 100),
(100370, '珍珠美人珍珠美人', '', 'http://www.yespearl.com', '', 0, 100),
(100371, '品尚红酒', '', 'http://www.wine9.com/', '', 0, 100),
(100372, 'DHC中国', '', 'http://www.dhc.net.cn/top/index.jsp', '', 0, 100),
(100373, '乐纷纷网上商城', '', 'http://www.lefeny.com', '', 0, 100),
(100374, '亮视', '', 'http://www.lenses.cn ', '', 0, 100),
(100375, '华强商城', '', 'http://www.hqbuy.com/ ', '', 0, 100),
(100376, '初刻', '', 'http://www.crucco.com/ ', '', 0, 100),
(100377, '爱婴岛', '', 'http://www.baby.com.cn/ ', '', 0, 100),
(100378, 'jockey内衣', '', 'http://www.jockey.cn/ ', '', 0, 100),
(100379, '礼意久久', '', 'http://www.liyi99.com', '', 0, 100),
(100380, '梦芭莎', '', 'http://www.moonbasa.com/', '', 0, 100),
(100381, '优悦生活网', '', 'http://www.yoye.cn', '', 0, 100),
(100382, '炫网', '', 'http://www.ouxuan.com', '', 0, 100),
(100383, '维棉', '', 'http://www.vcotton.com', '', 0, 100),
(100384, 'Vjia', '', 'http://www.vjia.com/', '', 0, 100),
(100385, '乐品酒', '', 'http://www.lepinjiu.com', '', 0, 100),
(100386, '酒仙网', '', 'http://www.jiuxian.com', '', 0, 100),
(100387, '波司登', '', 'http://shop.bosideng.com', '', 0, 100),
(100388, '博库书城', '', 'http://www.bookuu.com', '', 0, 100),
(100389, '传奇茶叶', '', 'http://www.supertea.cn', '', 0, 100),
(100390, '鳄鱼恤', '', 'http://www.hk1952.com', '', 0, 100),
(100391, '菲星数码', '', 'http://shop.phisung.com/ ', '', 0, 100),
(100392, '高街', '', 'http://www.gaojie.com/', '', 0, 100),
(100393, '购酒网', '', 'http://www.goujiuwang.net', '', 0, 100),
(100394, '好孩子', '', 'http://www.mamabb.com', '', 0, 100),
(100395, '聚爱商城', '', 'http://www.5jui.com', '', 0, 100),
(100396, '康品汇', '', 'http://kangpinhui.com', '', 0, 100),
(100397, '科婷', '', 'http://www.kt-mall.com', '', 0, 100),
(100398, '酷克商城', '', 'http://cook100.com', '', 0, 100),
(100399, '快乐购', '', 'http://www.happigo.com', '', 0, 100),
(100400, '乐趣网', '', 'http://www.lequ360.com', '', 0, 100),
(100401, '99淘金', '', 'http://www.99taojin.com', '', 0, 100),
(100402, '艾格官网', '', 'http://www.etam.cn/', '', 0, 100),
(100405, '百洋健康网', '', 'http://www.baiyjk.com', '', 0, 100),
(100407, '美国购物网', '', 'http://www.usashopcn.com', '', 0, 100),
(100408, '美酒乐', '', 'http://www.mix1.com.cn/', '', 0, 100),
(100409, '欧乐乐', '', 'http://www.oulele.com', '', 0, 100),
(100411, '品聚网', '', 'http://www.ibuying.com', '', 0, 100),
(100412, '森森购物', '', 'http://www.33go.com.cn', '', 0, 100),
(100413, '手礼网', '', 'http://www.giftport.com.cn', '', 0, 100),
(100414, '唐狮', '', 'http://www.tonlion.com', '', 0, 100),
(100415, '沱沱工社', '', 'http://www.tootoo.cn', '', 0, 100),
(100417, '鞋途网', '', 'http://www.xietoo.com', '', 0, 100),
(100418, '新世界百货', '', 'http://www.xinbaigo.com', '', 0, 100),
(100419, '秀唯网', '', 'http://www.xiuwe.com', '', 0, 100),
(100420, '央广购物', '', 'http://www.cnrmall.com', '', 0, 100),
(100421, '洋码头', '', 'http://www.ymatou.com', '', 0, 100),
(100422, '易果网', '', 'http://www.yiguo.com', '', 0, 100),
(100423, '易斯来福', '', 'http://www.easy361.com', '', 0, 100),
(100424, '银座网', '', 'http://www.yinzuo100.com', '', 0, 100),
(100425, '樱桃网', '', 'http://www.yingtao.me', '', 0, 100),
(100426, '优1宝贝', '', 'http://www.u1baby.com', '', 0, 100),
(100427, '优购物', '', 'http://www.17ugo.com/ ', '', 0, 100),
(100428, '优乐视', '', 'http://www.uelux.com ', '', 0, 100),
(100429, '珍品网', '', 'http://www.zhenpin.com', '', 0, 100),
(100430, '尊酷网', '', 'http://www.vipku.com/', '', 0, 100),
(100431, '天天红酒', '', 'http://www.365wine.com', '', 0, 100),
(100432, '土里土气', '', 'http://www.tulituqi.com', '', 0, 100),
(100433, '居品氏商城', '', 'http://www.jupins.com', '', 0, 100),
(100434, '汇美丽', '', 'http://www.hmeili.com', '', 0, 100),
(100435, '可得眼镜', '', 'http://www.keede.com/', '', 0, 100),
(100437, '正大天地', '', 'http://www.itruelife.com', '', 0, 100),
(100438, '邦购', '', 'http://www.banggo.com', '', 0, 100),
(100439, '文轩网', '', 'http://www.winxuan.com/', '', 0, 100),
(100440, '云中书城', '', 'http://www.yuncheng.com/ ', '', 0, 100),
(100441, '海e家', '', 'http://www.hyj.com', '', 0, 100),
(100443, '哇噻网', '', 'http://www.wowsai.com', '', 0, 100),
(100444, 'E宠商城', '', 'http://www.epetbar.com', '', 0, 100),
(100445, '中麦网上商城', '', 'http://www.zonmall.com', '', 0, 100),
(100446, '山族365美食网', '', 'http://www.shanzu365.com', '', 0, 100),
(100447, '珂兰钻石', '', 'http://www.kela.cn', '', 0, 100),
(100448, '丝芙兰', '', 'http://www.sephora.cn', '', 0, 100),
(100449, '悦己网', '', 'http://www.yueji.com/', '', 0, 100);

DROP TABLE IF EXISTS `%DB_PREFIX%taobao_collect`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%taobao_collect` (
  `num_iid` bigint(11) NOT NULL,
  `keyid` varchar(60) DEFAULT '',
  `nick` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT '',
  `price` decimal(10,2) DEFAULT '0.00',
  `click_url` varchar(255) DEFAULT '',
  `shop_click_url` varchar(255) DEFAULT '',
  `pic_url` varchar(255) DEFAULT '',
  `item_location` varchar(60) DEFAULT '',
  `volume` int(11) DEFAULT '0',
  `commission_rate` decimal(10,2) DEFAULT '0.00',
  `commission` decimal(10,2) DEFAULT '0.00',
  `commission_num` int(11) DEFAULT '0',
  `commission_volume` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`num_iid`),
  UNIQUE KEY `keyid` (`keyid`),
  KEY `nick` (`nick`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%taobao_share`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%taobao_share` (
  `num_iid` bigint(11) NOT NULL,
  `keyid` varchar(60) DEFAULT '',
  `nick` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT '',
  `price` decimal(10,2) DEFAULT '0.00',
  `click_url` varchar(255) DEFAULT '',
  `shop_click_url` varchar(255) DEFAULT '',
  `pic_url` varchar(255) DEFAULT '',
  `detail_url` varchar(255) DEFAULT '',
  `delist_time` int(11) DEFAULT '0',
  `cid` varchar(30) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`num_iid`),
  UNIQUE KEY `keyid` USING BTREE(`keyid`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%taobao_shop`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%taobao_shop` (
  `nick` varchar(100) NOT NULL,
  `sid` varchar(30) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `logo` varchar(255) DEFAULT '',
  PRIMARY KEY (`nick`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%taobao_shop_temp`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%taobao_shop_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;