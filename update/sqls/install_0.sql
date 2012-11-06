DROP TABLE IF EXISTS `%DB_PREFIX%admin`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(60) NOT NULL,
  `admin_pwd` char(32) NOT NULL,
  `last_login_time` int(11) unsigned DEFAULT '0',
  `last_login_ip` varchar(40) DEFAULT NULL,
  `login_count` mediumint(8) unsigned DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `role_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_user` (`admin_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2;

INSERT INTO `%DB_PREFIX%admin` (`id`, `admin_name`, `admin_pwd`, `last_login_time`, `last_login_ip`, `login_count`, `create_time`, `update_time`, `status`, `role_id`) VALUES
(1, 'fanwe', '6714ccb93be0fda4e51f206b91b46358', 0, '127.0.0.1', 1, 0, 0, 1, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%admin_log`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_module` varchar(60) NOT NULL DEFAULT '',
  `log_action` varchar(60) NOT NULL DEFAULT '',
  `data_id` int(11) NOT NULL COMMENT '操作的相关数据主键',
  `log_time` int(11) NOT NULL,
  `admin_id` mediumint(8) NOT NULL DEFAULT '0',
  `ip` varchar(60) NOT NULL DEFAULT '',
  `log_result` tinyint(1) NOT NULL COMMENT '0:失败 1:成功',
  `log_msg` text NOT NULL,
  `log_request` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_time` (`log_time`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%adv`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position_id` mediumint(8) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` text NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1: 图片 2:flash 3:文字 4:外部调用',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) NOT NULL,
  `desc` text NOT NULL,
  `target_key` varchar(60) NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT '10',
  `small` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `position_id` (`position_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18;

INSERT INTO `%DB_PREFIX%adv` (`id`, `position_id`, `name`, `code`, `type`, `status`, `url`, `desc`, `target_key`, `sort`, `small`) VALUES
(1, 1, '头部广告', './public/upload/adv/201112/20/4ef04005a01f5.jpg', 1, 1, 'http://www.fanwe.com', '', '', 100, ''),
(2, 2, '敏敏', './public/upload/adv/201112/20/4ef049a01bcd9.jpg', 1, 1, 'http://www.fanwe.com', '做简单系的女生', '', 100, './public/upload/adv/201112/20/4ef04b090f189.jpg'),
(3, 2, '圣诞狂享乐', './public/upload/adv/201112/20/4ef0508170a06.jpg', 1, 1, 'http://www.fanwe.com', '趣购街圣诞送好礼', '', 100, './public/upload/adv/201112/20/4ef050816fdb2.jpg'),
(4, 3, '上衣分类广告', './public/upload/adv/201112/10/4ee306f901380.jpg', 1, 1, 'http://www.fanwe.com', '', 'coats', 100, ''),
(5, 3, '下装广告', './public/upload/adv/201112/10/4ee30ef2eb5f5.jpg', 1, 1, 'http://www.fanwe.com', '', 'pants', 100, ''),
(6, 3, '鞋子', './public/upload/adv/201112/15/4ee9f16713e1d.jpg', 1, 1, 'http://www.fanwe.com', '', 'shoes', 100, ''),
(7, 2, '广告轮播3', './public/upload/adv/201112/16/4eeb58dd196da.png', 1, 1, 'http://www.fanwe.com', '轮播广告3说明', '', 100, './public/upload/adv/201112/16/4eeb590118e19.jpg'),
(8, 2, '洋洋得意', './public/upload/adv/201112/20/4ef04c8e9f488.jpg', 1, 1, 'http://www.fanwe.com', '淑女的你还不心动吗？', '', 99, './public/upload/adv/201112/20/4ef04c54a34d1.jpg'),
(9, 4, '会员信息底部广告1', '', 1, 1, 'http://www.fanwe.com', '广告1', '', 100, './public/upload/adv/201112/16/4eeb5a5bbbe79.jpg'),
(10, 4, '会员信息底部广告2', '', 1, 1, 'http://www.fanwe.com', '广告2', '', 100, ''),
(11, 4, '会员信息底部广告3', '', 1, 1, 'http://www.fanwe.com', '广告3', '', 100, ''),
(12, 4, '会员信息底部广告4', '', 1, 1, 'http://www.fanwe.com', '广告4', '', 100, ''),
(13, 4, '会员信息底部广告5', '', 1, 1, 'http://www.fanwe.com', '广告5', '', 100, './public/upload/adv/201112/16/4eeb5abf8670f.jpg'),
(14, 4, '会员信息底部广告6', '', 1, 1, 'http://www.fanwe.com', '会员信息底部广告6', '', 100, './public/upload/adv/201112/16/4eeb5ab515624.jpg'),
(15, 5, '逛街分类广告-逛街啦-1', './public/upload/images/201206/05/4fce2753ac27d.jpg', 1, 1, 'http://www.fanwe.com', '', 'cate1', 100, ''),
(16, 5, '逛街分类广告-上装', './public/upload/images/201206/06/4fce42d13bda1.jpg', 1, 1, 'http://www.fanwe.com', '', 'cate2', 100, ''),
(17, 5, '逛街分类广告-逛街啦-2', './public/upload/images/201206/06/4fce435df2d05.jpg', 1, 1, 'http://www.fanwe.com', '', 'cate1', 100, '');

DROP TABLE IF EXISTS `%DB_PREFIX%adv_layout`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%adv_layout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(255) DEFAULT NULL,
  `layout_id` varchar(255) DEFAULT NULL,
  `tmpl` varchar(255) DEFAULT NULL,
  `rec_id` int(11) DEFAULT NULL,
  `item_limit` int(11) DEFAULT NULL,
  `target_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` USING BTREE(`page`) 
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=8;

INSERT INTO `%DB_PREFIX%adv_layout` (`id`, `page`, `layout_id`, `tmpl`, `rec_id`, `item_limit`, `target_id`) VALUES
(1, '/inc/header', '头部广告位', 'pink2', 1, 0, ''),
(2, '/page/index_index', '首页轮播广告位', 'pink2', 2, 0, ''),
(3, '/inc/index/index_cate_share', '分类右侧大图广告185X330', 'pink2', 3, 1, ''),
(4, '/page/index_index', '首页右侧用户信息底部广告位', 'pink2', 4, 6, ''),
(5, '/inc/header', '头部广告位', 'concise', 1, 1, ''),
(6, '/page/index_index', '首页轮播广告位', 'black', 2, 0, ''),
(7, '/inc/header', '头部广告位', 'black', 1, 0, '');

DROP TABLE IF EXISTS `%DB_PREFIX%adv_position`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%adv_position` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `width` smallint(5) unsigned NOT NULL DEFAULT '0',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `is_flash` tinyint(1) NOT NULL DEFAULT '0',
  `flash_style` varchar(60) NOT NULL,
  `style` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_fix` tinyint(1) DEFAULT '0',
  `code` varchar(20) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

INSERT INTO `%DB_PREFIX%adv_position` (`id`, `name`, `width`, `height`, `is_flash`, `flash_style`, `style`, `status`, `is_fix`, `code`) VALUES
(1, '头部广告', 960, 86, 0, '', '<div class="blank15"></div>\r\n<table cellpadding="0" cellspacing="0">\r\n{loop $adv_list $adv}\r\n<tr><td>{$adv[html]}</td></tr>\r\n{/loop}\r\n</table>', 1, 0, ''),
(2, '首页轮播', 443, 283, 0, '', '<table cellpadding="0" cellspacing="0">\r\n{loop $adv_list $adv}\r\n<tr><td>{$adv[html]}</td></tr>\r\n{/loop}\r\n</table>', 1, 0, ''),
(3, '分类广告位', 185, 330, 0, '', '<table cellpadding="0" cellspacing="0">\r\n{loop $adv_list $adv}\r\n<tr><td>{$adv[html]}</td></tr>\r\n{/loop}\r\n</table>', 1, 0, ''),
(4, '会员信息底部广告', 0, 0, 0, '', '<table cellpadding="0" cellspacing="0">\r\n{loop $adv_list $adv}\r\n<tr><td>{$adv[html]}</td></tr>\r\n{/loop}\r\n</table>', 1, 0, ''),
(5, '逛街分类广告位', 319, 109, 0, '', '{loop $adv_list $adv}\r\n{$adv[html]}\r\n{/loop}', 1, 1, 'book_cate');

DROP TABLE IF EXISTS `%DB_PREFIX%album`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` smallint(6) NOT NULL DEFAULT '0',
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(80) NOT NULL DEFAULT '',
  `show_type` tinyint(1) NOT NULL DEFAULT '0',
  `tags` text,
  `content` text,
  `photo_count` int(11) NOT NULL DEFAULT '0',
  `goods_count` int(11) NOT NULL DEFAULT '0',
  `img_count` int(11) NOT NULL DEFAULT '0',
  `best_count` int(11) NOT NULL DEFAULT '0',
  `collect_count` int(11) NOT NULL DEFAULT '0',
  `share_count` int(11) NOT NULL DEFAULT '0',
  `create_day` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `cache_data` text,
  `is_index` tinyint(1) DEFAULT '0',
  `is_flash` tinyint(1) NOT NULL DEFAULT '0',
  `is_best` tinyint(1) NOT NULL DEFAULT '0',
  `flash_img` varchar(255) NOT NULL DEFAULT '',
  `best_img` varchar(255) NOT NULL DEFAULT '',
  `sort` smallint(5) NOT NULL DEFAULT '100',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `share_id` (`share_id`),
  KEY `is_index` (`is_index`),
  KEY `is_best` (`is_best`),
  KEY `is_flash` (`is_flash`),
  KEY `img_count` (`img_count`),
  KEY `sort` (`sort`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%album_best`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_best` (
  `album_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `best_day` int(11) NOT NULL DEFAULT '0',
  `best_time` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `aid_uid` (`album_id`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%album_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_category` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `img` varchar(255) NOT NULL DEFAULT '',
  `img_hover` varchar(255) NOT NULL DEFAULT '',
  `seo_title` varchar(255) NOT NULL DEFAULT '',
  `seo_keywords` text,
  `seo_desc` text,
  `sort` smallint(5) NOT NULL DEFAULT '10',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

INSERT INTO `%DB_PREFIX%album_category` (`id`, `name`, `img`, `img_hover`, `seo_title`, `seo_keywords`, `seo_desc`, `sort`, `status`) VALUES
(1, '时尚', './public/upload/images/201111/27/4ed1e6e200df4.png', './public/upload/images/201111/27/4ed1e7c940571.png', '', '', '', 100, 1),
(2, '美容', './public/upload/images/201111/27/4ed1e6f2a68d5.png', './public/upload/images/201111/27/4ed1e7da120e5.png', '', '', '', 100, 1),
(3, '购物', './public/upload/images/201111/27/4ed1e700ade32.png', './public/upload/images/201111/27/4ed1e7e7800fe.png', '', '', '', 100, 1),
(4, '生活', './public/upload/images/201111/27/4ed1e709c63b5.png', './public/upload/images/201111/27/4ed1e7ee17598.png', '', '', '', 100, 1),
(5, '其他', './public/upload/images/201111/27/4ed1e71912037.png', './public/upload/images/201111/27/4ed1e7f5e1d65.png', '', '', '', 100, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%album_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_match` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%album_rec`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_rec` (
  `album_id` int(11) NOT NULL,
  `ashare_id` int(11) NOT NULL,
  `share_id` int(11) NOT NULL,
  `rec_id` int(11) NOT NULL,
  `type` enum('photo','goods') NOT NULL,
  KEY `share_id` (`share_id`),
  KEY `album_id` (`album_id`),
  KEY `ashare_id` (`ashare_id`),
  KEY `album_id_2` (`album_id`,`share_id`,`rec_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%album_share`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_share` (
  `album_id` int(11) NOT NULL,
  `share_id` int(11) NOT NULL,
  `cid` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `album_id` (`album_id`),
  KEY `cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%album_share_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_share_index` (
  `album_id` int(11) NOT NULL,
  `share_id` int(11) NOT NULL,
  `cid` smallint(6) NOT NULL DEFAULT '0',
  `collect_1count` int(11) DEFAULT '0',
  `collect_7count` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `album_id` (`album_id`),
  KEY `cid` (`cid`),
  KEY `collect_1count` (`collect_1count`),
  KEY `collect_7count` (`collect_7count`),
  KEY `collect_count` (`collect_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%album_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_tags` (
  `tag_name` varchar(60) NOT NULL,
  `album_count` int(11) NOT NULL DEFAULT '0',
  `tag_img` varchar(255) NOT NULL DEFAULT '',
  `is_new` tinyint(1) NOT NULL DEFAULT '1',
  UNIQUE KEY `tag_name` (`tag_name`),
  KEY `is_new` (`is_new`),
  KEY `album_count` (`album_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%album_tags_related`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%album_tags_related` (
  `tag_name` varchar(60) NOT NULL,
  `album_id` int(11) NOT NULL,
  UNIQUE KEY `tag_aid` (`tag_name`,`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%api_log`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%api_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `act` varchar(30) NOT NULL,
  `api` varchar(400) NOT NULL,
  `p` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%apns_devices`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%apns_devices` (
  `pid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `clientid` int(11) NOT NULL DEFAULT '0',
  `appname` varchar(255) NOT NULL,
  `appversion` varchar(25) DEFAULT NULL,
  `deviceuid` char(40) NOT NULL,
  `devicetoken` char(64) NOT NULL,
  `devicename` varchar(255) NOT NULL,
  `devicemodel` varchar(100) NOT NULL,
  `deviceversion` varchar(25) NOT NULL,
  `pushbadge` enum('disabled','enabled') DEFAULT 'disabled',
  `pushalert` enum('disabled','enabled') DEFAULT 'disabled',
  `pushsound` enum('disabled','enabled') DEFAULT 'disabled',
  `development` enum('production','sandbox') CHARACTER SET latin1 NOT NULL DEFAULT 'production',
  `status` enum('active','uninstalled') NOT NULL DEFAULT 'active',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `appname` (`appname`,`appversion`,`deviceuid`),
  KEY `clientid` (`clientid`),
  KEY `devicetoken` (`devicetoken`),
  KEY `devicename` (`devicename`),
  KEY `devicemodel` (`devicemodel`),
  KEY `deviceversion` (`deviceversion`),
  KEY `pushbadge` (`pushbadge`),
  KEY `pushalert` (`pushalert`),
  KEY `pushsound` (`pushsound`),
  KEY `development` (`development`),
  KEY `status` (`status`),
  KEY `created` (`created`),
  KEY `modified` (`modified`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store unique devices' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%apns_device_history`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%apns_device_history` (
  `pid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `clientid` varchar(64) NOT NULL,
  `appname` varchar(255) NOT NULL,
  `appversion` varchar(25) DEFAULT NULL,
  `deviceuid` char(40) NOT NULL,
  `devicetoken` char(64) NOT NULL,
  `devicename` varchar(255) NOT NULL,
  `devicemodel` varchar(100) NOT NULL,
  `deviceversion` varchar(25) NOT NULL,
  `pushbadge` enum('disabled','enabled') DEFAULT 'disabled',
  `pushalert` enum('disabled','enabled') DEFAULT 'disabled',
  `pushsound` enum('disabled','enabled') DEFAULT 'disabled',
  `development` enum('production','sandbox') CHARACTER SET latin1 NOT NULL DEFAULT 'production',
  `status` enum('active','uninstalled') NOT NULL DEFAULT 'active',
  `archived` datetime NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `clientid` (`clientid`),
  KEY `devicetoken` (`devicetoken`),
  KEY `devicename` (`devicename`),
  KEY `devicemodel` (`devicemodel`),
  KEY `deviceversion` (`deviceversion`),
  KEY `pushbadge` (`pushbadge`),
  KEY `pushalert` (`pushalert`),
  KEY `pushsound` (`pushsound`),
  KEY `development` (`development`),
  KEY `status` (`status`),
  KEY `appname` (`appname`),
  KEY `appversion` (`appversion`),
  KEY `deviceuid` (`deviceuid`),
  KEY `archived` (`archived`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store unique device history' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%apns_messages`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%apns_messages` (
  `pid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `clientid` varchar(64) NOT NULL,
  `fk_device` int(9) unsigned NOT NULL,
  `message` varchar(255) NOT NULL,
  `delivery` datetime NOT NULL,
  `status` enum('queued','delivered','failed') CHARACTER SET latin1 NOT NULL DEFAULT 'queued',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`),
  KEY `clientid` (`clientid`),
  KEY `fk_device` (`fk_device`),
  KEY `status` (`status`),
  KEY `created` (`created`),
  KEY `modified` (`modified`),
  KEY `message` (`message`),
  KEY `delivery` (`delivery`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Messages to push to APNS' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%ask_post`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%ask_post` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `share_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `user_name` char(15) DEFAULT '',
  `content` text,
  `is_best` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`pid`),
  KEY `tid` (`tid`),
  KEY `uid` (`uid`),
  KEY `share_id` USING BTREE(`share_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%ask_thread`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%ask_thread` (
  `tid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL,
  `share_id` int(11) DEFAULT NULL,
  `title` varchar(80) DEFAULT '',
  `content` text,
  `uid` int(11) DEFAULT NULL,
  `user_name` char(15) DEFAULT '',
  `is_solve` tinyint(1) DEFAULT '0',
  `is_top` tinyint(1) DEFAULT '0',
  `is_best` tinyint(1) DEFAULT '0',
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1',
  `post_count` int(11) DEFAULT '0',
  `click_count` int(11) DEFAULT '0',
  `lastpost` int(11) DEFAULT '0',
  `lastposter` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`tid`),
  KEY `aid` (`aid`),
  KEY `uid` (`uid`),
  KEY `share_id` USING BTREE(`share_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%atme`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%atme` (
  `uid` int(11) DEFAULT '0',
  `user_name` varchar(100) DEFAULT NULL,
  `share_id` int(11) DEFAULT '0',
  KEY `uid` USING BTREE(`uid`) ,
  KEY `share_id` USING BTREE(`share_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%comment_me`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%comment_me` (
  `comment_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `share_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `uid` (`uid`),
  KEY `share_id` (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%cron`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%cron` (
  `server` enum('share','commission','collect') NOT NULL DEFAULT 'share',
  `type` varchar(30) NOT NULL DEFAULT '',
  `run_time` int(11) NOT NULL DEFAULT '0',
  `data` mediumtext,
  KEY `run_time` (`run_time`),
  KEY `server` USING BTREE(`server`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `%DB_PREFIX%cron` (`server`, `type`, `run_time`, `data`) VALUES
('commission', '', 1338796800, NULL),
('share', '', 1338796800, NULL);

DROP TABLE IF EXISTS `%DB_PREFIX%daren_cate`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%daren_cate` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT '',
  `content` text,
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1',
  `is_fix` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `%DB_PREFIX%daren_cate` (`id`, `name`, `content`, `sort`, `status`, `is_fix`) VALUES
(1, '晒货达人', NULL, 100, 1, 1),
(2, '搭配达人', NULL, 100, 1, 1),
(3, '杂志社作家', NULL, 100, 1, 1),
(4, '优秀小组长', NULL, 100, 1, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%event`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `share_id` int(11) NOT NULL,
  `is_event` tinyint(1) NOT NULL DEFAULT '0',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  `last_share` int(11) NOT NULL DEFAULT '0',
  `last_time` int(11) NOT NULL DEFAULT '0',
  `thread_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` USING BTREE(`uid`) ,
  KEY `title` USING BTREE(`title`) ,
  KEY `share_id` (`share_id`),
  KEY `thread_count` (`thread_count`),
  KEY `last_share` (`last_share`),
  KEY `is_hot` (`is_hot`),
  KEY `is_event` (`is_event`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%event_share`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%event_share` (
  `event_id` int(11) NOT NULL,
  `share_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  KEY `event_id` (`event_id`),
  KEY `share_id` (`share_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%exchange_goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%exchange_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `goods_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:虚拟卡 1:实体商品',
  `img` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `integral` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `buy_count` int(11) NOT NULL DEFAULT '0',
  `user_num` smallint(5) NOT NULL DEFAULT '1',
  `is_best` tinyint(1) NOT NULL DEFAULT '0',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0',
  `begin_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `begin_end_time` (`begin_time`,`end_time`),
  KEY `status` (`status`),
  KEY `sort` (`sort`),
  KEY `is_best` (`is_best`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%expression`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%expression` (
  `expression_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'tusiji',
  `emotion` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`expression_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=135 ;

INSERT INTO `%DB_PREFIX%expression` (`expression_id`, `title`, `type`, `emotion`, `filename`) VALUES
(19, '傲慢', 'qq', '[傲慢]', 'aoman.gif'),
(20, '白眼', 'qq', '[白眼]', 'baiyan.gif'),
(21, '鄙视', 'qq', '[鄙视]', 'bishi.gif'),
(22, '闭嘴', 'qq', '[闭嘴]', 'bizui.gif'),
(23, '擦汗', 'qq', '[擦汗]', 'cahan.gif'),
(24, '菜刀', 'qq', '[菜刀]', 'caidao.gif'),
(25, '差劲', 'qq', '[差劲]', 'chajin.gif'),
(26, '欢庆', 'qq', '[欢庆]', 'cheer.gif'),
(27, '虫子', 'qq', '[虫子]', 'chong.gif'),
(28, '呲牙', 'qq', '[呲牙]', 'ciya.gif'),
(29, '捶打', 'qq', '[捶打]', 'da.gif'),
(30, '大便', 'qq', '[大便]', 'dabian.gif'),
(31, '大兵', 'qq', '[大兵]', 'dabing.gif'),
(32, '大叫', 'qq', '[大叫]', 'dajiao.gif'),
(33, '大哭', 'qq', '[大哭]', 'daku.gif'),
(34, '蛋糕', 'qq', '[蛋糕]', 'dangao.gif'),
(35, '发怒', 'qq', '[发怒]', 'fanu.gif'),
(36, '刀', 'qq', '[刀]', 'dao.gif'),
(37, '得意', 'qq', '[得意]', 'deyi.gif'),
(38, '凋谢', 'qq', '[凋谢]', 'diaoxie.gif'),
(39, '饿', 'qq', '[饿]', 'er.gif'),
(40, '发呆', 'qq', '[发呆]', 'fadai.gif'),
(41, '发抖', 'qq', '[发抖]', 'fadou.gif'),
(42, '饭', 'qq', '[饭]', 'fan.gif'),
(43, '飞吻', 'qq', '[飞吻]', 'feiwen.gif'),
(44, '奋斗', 'qq', '[奋斗]', 'fendou.gif'),
(45, '尴尬', 'qq', '[尴尬]', 'gangga.gif'),
(46, '给力', 'qq', '[给力]', 'geili.gif'),
(47, '勾引', 'qq', '[勾引]', 'gouyin.gif'),
(48, '鼓掌', 'qq', '[鼓掌]', 'guzhang.gif'),
(49, '哈哈', 'qq', '[哈哈]', 'haha.gif'),
(50, '害羞', 'qq', '[害羞]', 'haixiu.gif'),
(51, '哈欠', 'qq', '[哈欠]', 'haqian.gif'),
(52, '花', 'qq', '[花]', 'hua.gif'),
(53, '坏笑', 'qq', '[坏笑]', 'huaixiao.gif'),
(54, '挥手', 'qq', '[挥手]', 'huishou.gif'),
(55, '回头', 'qq', '[回头]', 'huitou.gif'),
(56, '激动', 'qq', '[激动]', 'jidong.gif'),
(57, '惊恐', 'qq', '[惊恐]', 'jingkong.gif'),
(58, '惊讶', 'qq', '[惊讶]', 'jingya.gif'),
(59, '咖啡', 'qq', '[咖啡]', 'kafei.gif'),
(60, '可爱', 'qq', '[可爱]', 'keai.gif'),
(61, '可怜', 'qq', '[可怜]', 'kelian.gif'),
(62, '磕头', 'qq', '[磕头]', 'ketou.gif'),
(63, '示爱', 'qq', '[示爱]', 'kiss.gif'),
(64, '酷', 'qq', '[酷]', 'ku.gif'),
(65, '难过', 'qq', '[难过]', 'kuaikule.gif'),
(66, '骷髅', 'qq', '[骷髅]', 'kulou.gif'),
(67, '困', 'qq', '[困]', 'kun.gif'),
(68, '篮球', 'qq', '[篮球]', 'lanqiu.gif'),
(69, '冷汗', 'qq', '[冷汗]', 'lenghan.gif'),
(70, '流汗', 'qq', '[流汗]', 'liuhan.gif'),
(71, '流泪', 'qq', '[流泪]', 'liulei.gif'),
(72, '礼物', 'qq', '[礼物]', 'liwu.gif'),
(73, '爱心', 'qq', '[爱心]', 'love.gif'),
(74, '骂人', 'qq', '[骂人]', 'ma.gif'),
(75, '不开心', 'qq', '[不开心]', 'nanguo.gif'),
(76, '不好', 'qq', '[不好]', 'no.gif'),
(77, '很好', 'qq', '[很好]', 'ok.gif'),
(78, '佩服', 'qq', '[佩服]', 'peifu.gif'),
(79, '啤酒', 'qq', '[啤酒]', 'pijiu.gif'),
(80, '乒乓', 'qq', '[乒乓]', 'pingpang.gif'),
(81, '撇嘴', 'qq', '[撇嘴]', 'pizui.gif'),
(82, '强', 'qq', '[强]', 'qiang.gif'),
(83, '亲亲', 'qq', '[亲亲]', 'qinqin.gif'),
(84, '出丑', 'qq', '[出丑]', 'qioudale.gif'),
(85, '足球', 'qq', '[足球]', 'qiu.gif'),
(86, '拳头', 'qq', '[拳头]', 'quantou.gif'),
(87, '弱', 'qq', '[弱]', 'ruo.gif'),
(88, '色', 'qq', '[色]', 'se.gif'),
(89, '闪电', 'qq', '[闪电]', 'shandian.gif'),
(90, '胜利', 'qq', '[胜利]', 'shengli.gif'),
(91, '衰', 'qq', '[衰]', 'shuai.gif'),
(92, '睡觉', 'qq', '[睡觉]', 'shuijiao.gif'),
(93, '太阳', 'qq', '[太阳]', 'taiyang.gif'),
(96, '啊', 'tusiji', '[啊]', 'aa.gif'),
(97, '暗爽', 'tusiji', '[暗爽]', 'anshuang.gif'),
(98, 'byebye', 'tusiji', '[byebye]', 'baibai.gif'),
(99, '不行', 'tusiji', '[不行]', 'buxing.gif'),
(100, '戳眼', 'tusiji', '[戳眼]', 'chuoyan.gif'),
(101, '很得意', 'tusiji', '[很得意]', 'deyi.gif'),
(102, '顶', 'tusiji', '[顶]', 'ding.gif'),
(103, '抖抖', 'tusiji', '[抖抖]', 'douxiong.gif'),
(104, '哼', 'tusiji', '[哼]', 'heng.gif'),
(105, '挥汗', 'tusiji', '[挥汗]', 'huihan.gif'),
(106, '昏迷', 'tusiji', '[昏迷]', 'hunmi.gif'),
(107, '互拍', 'tusiji', '[互拍]', 'hupai.gif'),
(108, '瞌睡', 'tusiji', '[瞌睡]', 'keshui.gif'),
(109, '笼子', 'tusiji', '[笼子]', 'longzi.gif'),
(110, '听歌', 'tusiji', '[听歌]', 'music.gif'),
(111, '奶瓶', 'tusiji', '[奶瓶]', 'naiping.gif'),
(112, '扭背', 'tusiji', '[扭背]', 'niubei.gif'),
(113, '拍砖', 'tusiji', '[拍砖]', 'paizhuan.gif'),
(114, '飘过', 'tusiji', '[飘过]', 'piaoguo.gif'),
(115, '揉脸', 'tusiji', '[揉脸]', 'roulian.gif'),
(116, '闪闪', 'tusiji', '[闪闪]', 'shanshan.gif'),
(117, '生日', 'tusiji', '[生日]', 'shengri.gif'),
(118, '摊手', 'tusiji', '[摊手]', 'tanshou.gif'),
(119, '躺坐', 'tusiji', '[躺坐]', 'tanzuo.gif'),
(120, '歪头', 'tusiji', '[歪头]', 'waitou.gif'),
(121, '我踢', 'tusiji', '[我踢]', 'woti.gif'),
(122, '无聊', 'tusiji', '[无聊]', 'wuliao.gif'),
(123, '醒醒', 'tusiji', '[醒醒]', 'xingxing.gif'),
(124, '睡了', 'tusiji', '[睡了]', 'xixishui.gif'),
(125, '旋转', 'tusiji', '[旋转]', 'xuanzhuan.gif'),
(126, '摇晃', 'tusiji', '[摇晃]', 'yaohuang.gif'),
(127, '耶', 'tusiji', '[耶]', 'yeah.gif'),
(128, '郁闷', 'tusiji', '[郁闷]', 'yumen.gif'),
(129, '晕厥', 'tusiji', '[晕厥]', 'yunjue.gif'),
(130, '砸', 'tusiji', '[砸]', 'za.gif'),
(131, '震荡', 'tusiji', '[震荡]', 'zhendang.gif'),
(132, '撞墙', 'tusiji', '[撞墙]', 'zhuangqiang.gif'),
(133, '转头', 'tusiji', '[转头]', 'zhuantou.gif'),
(134, '抓墙', 'tusiji', '[抓墙]', 'zhuaqiang.gif');

DROP TABLE IF EXISTS `%DB_PREFIX%fav_me`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%fav_me` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `parent_id` int(11) DEFAULT '0',
  `cuid` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%forum`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) DEFAULT '0',
  `name` varchar(150) DEFAULT '',
  `uid` int(11) DEFAULT '0',
  `user_name` varchar(30) DEFAULT '' COMMENT '组员别名',
  `sort` smallint(5) DEFAULT '100',
  `create_time` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `cid` smallint(6) DEFAULT '0',
  `join_way` tinyint(1) DEFAULT '0' COMMENT '1需要小组管理员批准才能加入小组， 0允许任何人加入小组',
  `create_day` int(11) DEFAULT '0',
  `content` text,
  `icon` int(11) DEFAULT '0',
  `img_id` int(11) DEFAULT '0',
  `is_index` tinyint(1) DEFAULT '0',
  `is_best` tinyint(1) DEFAULT '0',
  `is_new` tinyint(1) DEFAULT '0',
  `cache_data` text,
  `user_count` int(11) DEFAULT '1' COMMENT '成员数量',
  `thread_count` int(11) DEFAULT '0',
  `post_count` int(11) DEFAULT NULL,
  `tags` varchar(255) DEFAULT '',
  PRIMARY KEY (`fid`),
  KEY `is_index` (`is_index`),
  KEY `is_best` (`is_best`),
  KEY `uid` (`uid`),
  KEY `thread_count` (`thread_count`),
  KEY `user_count` (`user_count`),
  KEY `create_day` (`create_day`),
  KEY `status` (`status`),
  KEY `share_id` (`share_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_apply`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `name` varchar(150) DEFAULT NULL,
  `reason` varchar(210) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  `create_day` int(11) DEFAULT '0',
  `data` text,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `create_day` (`create_day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(30) DEFAULT '',
  `icon` varchar(255) DEFAULT '',
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1',
  `cache_data` text,
  `forum_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=7 ;

INSERT INTO `%DB_PREFIX%forum_category` (`id`, `cate_name`, `icon`, `sort`, `status`, `cache_data`, `forum_count`) VALUES
(1, '扮美', '', 100, 1, '', 0),
(2, '生活', '', 100, 1, '', 0),
(3, '购物', '', 100, 1, '', 0),
(4, '品牌', '', 100, 1, '', 0),
(5, '情感', '', 100, 1, '', 0),
(6, '其他', '', 100, 1, '', 0);


DROP TABLE IF EXISTS `%DB_PREFIX%forum_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_match` (
  `fid` int(11) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`fid`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_post`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_post` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `share_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `content` text,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`pid`),
  KEY `tid` (`tid`),
  KEY `uid` (`uid`),
  KEY `share_id` USING BTREE(`share_id`) 
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_tags`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_tags` (
  `fid` int(11) NOT NULL COMMENT '小组ID',
  `tag_name` varchar(50) DEFAULT NULL,
  KEY `tag_name` (`tag_name`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_thread`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_thread` (
  `tid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL DEFAULT '0',
  `share_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT '',
  `content` text,
  `is_top` tinyint(1) DEFAULT '0',
  `is_best` tinyint(1) DEFAULT '0',
  `is_event` tinyint(1) NOT NULL DEFAULT '0',
  `sort` smallint(5) DEFAULT '100',
  `post_count` smallint(6) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  `best_count` int(11) NOT NULL DEFAULT '0',
  `lastpost` int(11) NOT NULL DEFAULT '0',
  `lastposter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tid`),
  KEY `fid` (`fid`),
  KEY `uid` (`uid`),
  KEY `share_id` USING BTREE(`share_id`),
  KEY `lastpost` (`lastpost`),
  KEY `is_top` (`is_top`),
  KEY `is_best` (`is_best`),
  KEY `is_event` (`is_event`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_thread_best`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_thread_best` (
  `uid` int(11) NOT NULL DEFAULT '0',
  `tid` int(11) DEFAULT '0',
  `share_id` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  KEY `uid_tid` (`tid`,`uid`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_thread_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_thread_match` (
  `tid` int(11) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`tid`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_update`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_update` (
  `fid` int(11) NOT NULL,
  `uid` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`fid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_users`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_users` (
  `fid` int(11) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  `type` tinyint(1) DEFAULT '0' COMMENT '0:普通会员;1:组长;2:管理员;',
  KEY `fid` (`fid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `%DB_PREFIX%forum_users_apply`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_users_apply` (
  `fid` int(11) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  KEY `fid` (`fid`),
  KEY `uid` (`uid`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `%DB_PREFIX%friend_link`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%friend_link` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `img` varchar(255) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '0',
  `height` int(11) NOT NULL DEFAULT '0',
  `sort` smallint(5) NOT NULL DEFAULT '100',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `%DB_PREFIX%friend_link` (`id`, `name`, `url`, `img`, `width`, `height`, `sort`, `status`) VALUES
(1, '方维', 'http://www.fanwe.com/', '', 0, 0, 100, 1),
(2, '方维分享官方站', 'http://fx.fanwe.com/', '', 0, 0, 100, 1),
(3, '方维社区', 'http://bbs.fanwe.com/', '', 0, 0, 100, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT '',
  `keyid` varchar(60) DEFAULT '',
  `shop_id` int(11) DEFAULT '0',
  `cid` smallint(6) DEFAULT '0',
  `img_id` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `taoke_url` varchar(255) DEFAULT '',
  `price` decimal(10,2) DEFAULT '0.00',
  `delist_time` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  `cache_data` text,
  `create_day` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyid` (`keyid`),
  KEY `shop_id` (`shop_id`),
  KEY `delist_time` (`delist_time`),
  KEY `cid` (`cid`),
  KEY `create_day` (`create_day`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%goods_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_category` (
  `cate_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(6) DEFAULT '0',
  `cate_name` varchar(80) DEFAULT '',
  `short_name` varchar(60) NOT NULL DEFAULT '',
  `cate_code` varchar(80) DEFAULT '',
  `cate_icon` varchar(255) DEFAULT '',
  `desc` varchar(255) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_desc` varchar(255) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `sort` smallint(6) NOT NULL DEFAULT '100',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_index` tinyint(1) NOT NULL DEFAULT '0',
  `is_root` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cate_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=62;

INSERT INTO `%DB_PREFIX%goods_category` (`cate_id`, `parent_id`, `cate_name`, `short_name`, `cate_code`, `cate_icon`, `desc`, `seo_keywords`, `seo_desc`, `create_time`, `sort`, `status`, `is_index`, `is_root`) VALUES
(1, 0, '逛街啦！', '最新分享', '', './public/upload/images/201108/03/4e38bfee1e8c2.png', '告诉大家你爱的宝贝', '', '', 1312313198, 100, 1, 0, 1),
(2, 0, '上装', '上装', 'coats', './public/upload/images/201206/05/4fcd9a8b7dca7.jpg', '告诉大家你爱的上装', '', '', 1312313403, 100, 1, 1, 0),
(3, 0, '下装', '下装', 'pants', './public/upload/images/201206/05/4fcd8f059d6b8.jpg', '告诉大家你爱的下装', '', '', 1312313442, 100, 1, 1, 0),
(4, 0, '鞋子', '鞋子', 'shoes', './public/upload/images/201206/05/4fcd8f0d79d30.jpg', '告诉大家你爱的鞋子', '', '', 1312313471, 100, 1, 1, 0),
(5, 0, '包包', '包包', 'bags', './public/upload/images/201206/05/4fcd8f15bbae4.jpg', '告诉大家你爱的包包', '', '', 1312313523, 100, 1, 1, 0),
(6, 0, '配饰', '配饰', 'accessories', './public/upload/images/201206/05/4fcd8f1d1984a.jpg', '告诉大家你爱的配饰', '', '', 1312313556, 100, 1, 1, 0),
(7, 0, '美妆', '美妆', 'beauties', './public/upload/images/201206/05/4fcd8f24b72ee.jpg', '告诉大家你爱的美妆', '', '', 1312313609, 100, 1, 1, 0),
(8, 0, '家居', '家居', 'home', './public/upload/images/201206/05/4fcd8f2b73ae4.jpg', '告诉大家你爱的家居', '', '', 1312313640, 100, 1, 1, 0),
(9, 2, '上衣', '上衣', '', './public/upload/images/201206/05/4fcd9616d5bdb.jpg', '', '', '', 1338844566, 100, 1, 0, 0),
(10, 2, '裙子', '裙子', '', './public/upload/images/201206/05/4fcd98912874d.jpg', '', '', '', 1338845201, 100, 1, 0, 0),
(11, 2, '内衣', '内衣', '', './public/upload/images/201206/05/4fcd995e02e78.jpg', '', '', '', 1338845406, 100, 1, 0, 0),
(12, 2, '流行元素', '流行元素', '', './public/upload/images/201206/05/4fcd9a63dc0ad.jpg', '', '', '', 1338845667, 100, 1, 0, 0),
(13, 2, '春夏必败', '春夏必败', '', './public/upload/images/201206/05/4fcda4b89f2ca.jpg', '', '', '', 1338848312, 100, 1, 0, 0),
(14, 3, '潮流单品', '潮流单品', '', '', '', '', '', 1338848478, 100, 1, 0, 0),
(15, 3, '流行元素', '流行元素', '', '', '', '', '', 1338848495, 100, 1, 0, 0),
(16, 3, '热门风格', '热门风格', '', '', '', '', '', 1338848508, 100, 1, 0, 0),
(17, 3, '材质', '材质', '', '', '', '', '', 1338848517, 100, 1, 0, 0),
(18, 4, '单鞋', '单鞋', '', './public/upload/images/201206/05/4fcda718cccfb.jpg', '', '', '', 1338848920, 100, 1, 0, 0),
(19, 4, '凉鞋', '凉鞋', '', './public/upload/images/201206/05/4fcda730a78cd.jpg', '', '', '', 1338848944, 100, 1, 0, 0),
(20, 4, '休闲鞋', '休闲鞋', '', './public/upload/images/201206/05/4fcda748bf7aa.jpg', '', '', '', 1338848968, 100, 1, 0, 0),
(21, 4, '春夏热搜', '春夏热搜', '', './public/upload/images/201206/05/4fcda77135827.jpg', '', '', '', 1338849009, 100, 1, 0, 0),
(22, 5, '春夏新款', '春夏新款', '', './public/upload/images/201206/05/4fcda997013d2.jpg', '', '', '', 1338849558, 100, 1, 0, 0),
(23, 5, '经典款', '经典款', '', './public/upload/images/201206/05/4fcda9b255fb2.jpg', '', '', '', 1338849586, 100, 1, 0, 0),
(24, 5, '功能款', '功能款', '', './public/upload/images/201206/05/4fcda9d091885.jpg', '', '', '', 1338849616, 100, 1, 0, 0),
(25, 5, '风格元素', '风格元素', '', './public/upload/images/201206/05/4fcda9eb604b1.jpg', '', '', '', 1338849643, 100, 1, 0, 0),
(26, 6, '当季爆款', '当季爆款', '', './public/upload/images/201206/05/4fcdab972f74d.jpg', '', '', '', 1338850071, 100, 1, 0, 0),
(27, 6, '服饰配件', '服饰配件', '', './public/upload/images/201206/05/4fcdabb4a06fa.jpg', '', '', '', 1338850100, 100, 1, 0, 0),
(28, 6, '首饰盒子', '首饰盒子', '', './public/upload/images/201206/05/4fcdabcf55eb6.jpg', '', '', '', 1338850127, 100, 1, 0, 0),
(29, 6, '风格元素', '风格元素', '', './public/upload/images/201206/05/4fcdabead1414.jpg', '', '', '', 1338850154, 100, 1, 0, 0),
(30, 7, '护肤', '护肤', '', './public/upload/images/201206/05/4fcdad12e8e21.jpg', '', '', '', 1338850450, 100, 1, 0, 0),
(31, 7, '彩妆', '彩妆', '', './public/upload/images/201206/05/4fcdad2a42968.jpg', '', '', '', 1338850474, 100, 1, 0, 0),
(32, 7, '品牌', '品牌', '', './public/upload/images/201206/05/4fcdad44c7ea7.jpg', '', '', '', 1338850500, 100, 1, 0, 0),
(33, 7, '功效', '功效', '', './public/upload/images/201206/05/4fcdad5b6c736.jpg', '', '', '', 1338850523, 100, 1, 0, 0),
(34, 8, '人气推荐', '人气推荐', '', './public/upload/images/201206/05/4fcdaedc4c51e.jpg', '', '', '', 1338850908, 100, 1, 0, 0),
(35, 8, '时尚起居', '时尚起居', '', './public/upload/images/201206/05/4fcdaf5081224.jpg', '', '', '', 1338851024, 100, 1, 0, 0),
(36, 8, '甜蜜卧室', '甜蜜卧室', '', './public/upload/images/201206/05/4fcdafdd5595d.jpg', '', '', '', 1338851165, 100, 1, 0, 0),
(37, 8, '百变厨房', '百变厨房', '', './public/upload/images/201206/05/4fcdaff255a27.jpg', '', '', '', 1338851186, 100, 1, 0, 0),
(38, 9, '潮流单品', '潮流单品', '', '', '', '', '', 1338851985, 100, 1, 0, 0),
(39, 9, '流行元素', '流行元素', '', '', '', '', '', 1338851999, 100, 1, 0, 0),
(40, 9, '热门风格', '热门风格', '', '', '', '', '', 1338852012, 100, 1, 0, 0),
(41, 9, '材质', '材质', '', '', '', '', '', 1338852024, 100, 1, 0, 0),
(42, 10, '潮流单品', '潮流单品', '', '', '', '', '', 1338852374, 100, 1, 0, 0),
(43, 10, '流行元素', '流行元素', '', '', '', '', '', 1338852388, 100, 1, 0, 0),
(44, 10, '热门风格', '热门风格', '', '', '', '', '', 1338852402, 100, 1, 0, 0),
(45, 10, '材质', '材质', '', '', '', '', '', 1338852433, 100, 1, 0, 0),
(46, 11, '潮流单品', '潮流单品', '', '', '', '', '', 1338852691, 100, 1, 0, 0),
(47, 11, '流行元素', '流行元素', '', '', '', '', '', 1338852706, 100, 1, 0, 0),
(48, 11, '热门风格', '热门风格', '', '', '', '', '', 1338852720, 100, 1, 0, 0),
(49, 11, '材质', '材质', '', '', '', '', '', 1338852733, 100, 1, 0, 0),
(50, 18, '热门鞋款', '热门鞋款', '', '', '', '', '', 1338853048, 100, 1, 0, 0),
(51, 18, '人气元素', '人气元素', '', '', '', '', '', 1338853063, 100, 1, 0, 0),
(52, 18, '材质', '材质', '', '', '', '', '', 1338853079, 100, 1, 0, 0),
(53, 18, '至IN风格', '至IN风格', '', '', '', '', '', 1338853093, 100, 1, 0, 0),
(54, 21, '元素', '元素', '', '', '', '', '', 1338853283, 100, 1, 0, 0),
(55, 21, '鞋型', '鞋型', '', '', '', '', '', 1338853301, 100, 1, 0, 0),
(56, 21, '品牌', '品牌', '', '', '', '', '', 1338853313, 100, 1, 0, 0),
(57, 21, '场景攻略', '场景攻略', '', '', '', '', '', 1338853326, 100, 1, 0, 0),
(58, 34, '当季新推', '当季新推', '', '', '', '', '', 1338854129, 100, 1, 0, 0),
(59, 34, '经典单品', '经典单品', '', '', '', '', '', 1338854216, 100, 1, 0, 0),
(60, 34, '潮流数码', '潮流数码', '', '', '', '', '', 1338854229, 100, 1, 0, 0),
(61, 34, '风格品牌', '风格品牌', '', '', '', '', '', 1338854241, 100, 1, 0, 0);

DROP TABLE IF EXISTS `%DB_PREFIX%goods_cates_gl`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_cates_gl` (
  `gl_id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_id` varchar(30) DEFAULT NULL,
  `f_cate_id` varchar(30) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `sort` smallint(6) DEFAULT '0',
  PRIMARY KEY (`gl_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%goods_check`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_check` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%goods_disable`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_disable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT '',
  `keyid` varchar(60) DEFAULT '',
  `name` varchar(255) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyid` (`keyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%goods_match`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_match` (
  `id` int(11) NOT NULL DEFAULT '0',
  `goods_name` text,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `goods_name` (`goods_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%goods_order`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_order` (
  `order_id` bigint(20) unsigned DEFAULT '0',
  `uid` int(10) unsigned DEFAULT '0',
  `rel_uid` int(10) unsigned DEFAULT '0',
  `share_id` int(10) unsigned DEFAULT '0',
  `goods_id` int(10) unsigned DEFAULT '0',
  `keyid` varchar(60) DEFAULT '',
  `type` smallint(2) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  `is_pay` tinyint(1) DEFAULT '0',
  `commission_rate` decimal(10,0) DEFAULT '0',
  `commission` decimal(10,2) DEFAULT '0.00',
  `create_time` int(10) unsigned DEFAULT '0',
  `pay_time` int(10) unsigned DEFAULT '0',
  `settlement_time` int(10) unsigned DEFAULT '0',
  UNIQUE KEY `oid_uid` USING BTREE(`order_id`,`uid`) ,
  KEY `pay_time` (`pay_time`),
  KEY `status` (`status`),
  KEY `is_pay` (`is_pay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%goods_order_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_order_index` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_day` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `create_day` (`create_day`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%images_0`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_0` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_1`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_1` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_2`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_2` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_3`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_3` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_4`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_4` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_5`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_5` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_6`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_6` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_7`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_7` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_8`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_8` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_9`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_9` (
  `id` int(11) NOT NULL DEFAULT '0',
  `type` enum('share','avatar','default','shop') DEFAULT NULL,
  `src` varchar(255) DEFAULT '',
  `width` smallint(5) DEFAULT '0',
  `height` smallint(5) DEFAULT '0',
  `server_code` varchar(30) DEFAULT '',
  `rel_count` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%images_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%images_index` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%image_servers`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%image_servers` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `upload_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `upload_count` (`upload_count`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%index_cate_share`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%index_cate_share` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  `cid` smallint(6) DEFAULT '0',
  `gid` smallint(6) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `cimg_id` int(10) unsigned DEFAULT '0',
  `img_id` int(10) unsigned DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `sort` smallint(5) DEFAULT '50',
  PRIMARY KEY (`share_id`),
  KEY `cid` (`cid`),
  KEY `sort` (`sort`),
  KEY `cid_gid` (`cid`,`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%index_cate_group`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%index_cate_group` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `cid` smallint(6) DEFAULT NULL,
  `name` varchar(100) DEFAULT '',
  `tags` text,
  `status` tinyint(1) DEFAULT '1',
  `sort` smallint(5) DEFAULT '50',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%ip_banned`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%ip_banned` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `ip1` smallint(3) NOT NULL DEFAULT '0',
  `ip2` smallint(3) NOT NULL DEFAULT '0',
  `ip3` smallint(3) NOT NULL DEFAULT '0',
  `ip4` smallint(3) NOT NULL DEFAULT '0',
  `admin` varchar(15) NOT NULL DEFAULT '',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `expiration` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%login_module`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%login_module` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(120) NOT NULL DEFAULT '',
  `short_name` varchar(60) NOT NULL DEFAULT '',
  `app_key` varchar(255) NOT NULL DEFAULT '',
  `app_secret` varchar(255) NOT NULL DEFAULT '',
  `is_syn` tinyint(1) NOT NULL DEFAULT '0',
  `sort` smallint(5) NOT NULL DEFAULT '10',
  `desc` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `%DB_PREFIX%login_module` (`id`, `code`, `name`, `short_name`, `app_key`, `app_secret`, `is_syn`, `sort`, `desc`, `status`) VALUES
(1, 'tqq', '腾讯微博', '腾讯', '', '', 1, 10, '申请地址：http://open.t.qq.com/websites/applykey', 1),
(2, 'sina', '新浪微博', '新浪', '', '', 1, 10, '申请地址：http://open.weibo.com/webmaster/add', 1),
(3, 'qq', 'QQ登录', 'QQ', '', '', 0, 10, '申请地址：http://connect.opensns.qq.com/', 1),
(4, 'taobao', '淘宝登录', '淘宝', '', '', 0, 10, '申请地址：http://open.taobao.com', 1);

DROP TABLE IF EXISTS `%DB_PREFIX%manage_log`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%manage_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_id` int(11) NOT NULL DEFAULT '0',
  `module` varchar(60) NOT NULL DEFAULT '',
  `action` varchar(60) NOT NULL DEFAULT '',
  `uid` int(11) NOT NULL DEFAULT '0',
  `user_name` varchar(60) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `module` (`module`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%medal`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%medal` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `image` varchar(255) DEFAULT '',
  `give_type` tinyint(1) DEFAULT '0',
  `expiration` smallint(6) DEFAULT '0',
  `conditions` varchar(60) NOT NULL DEFAULT '',
  `keywords` text,
  `confine` int(11) DEFAULT '0',
  `allow_group` text,
  `desc` text,
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1',
  `is_fix` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mid`),
  KEY `status` (`status`),
  KEY `sort` (`sort`),
  KEY `image` (`image`),
  KEY `conditions` (`conditions`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `%DB_PREFIX%medal` (`mid`, `name`, `image`, `give_type`, `expiration`, `conditions`, `keywords`, `confine`, `allow_group`, `desc`, `sort`, `status`, `is_fix`) VALUES
(1, '新人勋章', 'shequjumin.png', 0, 0, 'continue_login', NULL, 1, '', '分享你的第一个宝贝吧。', 100, 1, 0),
(2, '差价指南针', 'shequmingxing.png', 1, 0, '', NULL, 0, '', '哪里有差价，就指向哪里，让姐妹不多花一分的冤枉银子。\r\n你就是传说中独步江湖、人见人爱、花见花开的差价女王啦！', 100, 1, 0),
(3, '呼朋唤友', '18.png', 0, 0, 'referrals', NULL, 3, '', '成功邀请3个新蘑菇注册，就可拿到该勋章', 100, 1, 0);

DROP TABLE IF EXISTS `%DB_PREFIX%medal_apply`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%medal_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `mid` smallint(6) NOT NULL,
  `reason` text,
  `create_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_2` (`uid`,`mid`),
  KEY `uid` (`uid`),
  KEY `mid` (`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%m_adv`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%m_adv` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `img` varchar(255) DEFAULT '',
  `page` enum('sharelist','index') DEFAULT 'sharelist',
  `type` tinyint(1) DEFAULT '0' COMMENT '1.标签集,2.url地址,3.分类排行,4.最亮达人,5.搜索发现,6.一起拍,7.热门单品排行,8.直接显示某个分享',
  `data` text,
  `sort` smallint(5) DEFAULT '10',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

INSERT INTO `%DB_PREFIX%m_adv` (`id`, `name`, `img`, `page`, `type`, `data`, `sort`, `status`) VALUES
(1, '至In美衣', './public/upload/m/Lighthouse.jpg', 'index', 1, 'a:2:{s:3:"cid";i:2;s:4:"tags";a:20:{i:0;s:6:"衬衫";i:1;s:9:"连衣裙";i:2;s:6:"短裤";i:3;s:6:"短裙";i:4;s:6:"毛衣";i:5;s:9:"呢大衣";i:6;s:6:"西装";i:7;s:6:"斗篷";i:8;s:6:"棉服";i:9;s:9:"羽绒服";i:10;s:6:"马甲";i:11;s:6:"卫衣";i:12;s:9:"打底衫";i:13;s:6:"蕾丝";i:14;s:9:"娃娃领";i:15;s:6:"长款";i:16;s:6:"豹纹";i:17;s:6:"英伦";i:18;s:6:"日系";i:19;s:6:"复古";}}', 1, 1),
(2, '趣购街', './public/upload/m/Tulips.jpg', 'index', 2, 'a:1:{s:3:"url";s:23:"http://www.qugoujie.com";}', 2, 1),
(3, '冬季短裤女', './public/upload/m/Koala.jpg', 'index', 8, 'a:1:{s:8:"share_id";i:67240;}', 3, 1),
(4, '逛街页广告测试1', './public/upload/m/201201/07/4f0820c3e94db.jpg', 'sharelist', 1, 'a:2:{s:3:"cid";i:2;s:4:"tags";a:3:{i:0;s:6:"衣服";i:1;s:6:"上衣";i:2;s:6:"欧美";}}', 10, 1),
(5, '广告测试1', './public/upload/m/201201/07/4f08261495fac.png', 'index', 2, 'a:1:{s:3:"url";s:20:"http://www.fanwe.com";}', 10, 1),
(6, '逛街页广告测试2', './public/upload/m/201201/11/4f0d476b23d94.jpg', 'sharelist', 2, 'a:1:{s:3:"url";s:23:"http://www.qugoujie.com";}', 10, 1),
(7, '逛街页广告测试3', './public/upload/m/201201/11/4f0d47d7d7fe9.jpg', 'sharelist', 8, 'a:1:{s:8:"share_id";i:67180;}', 10, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%m_config`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%m_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `val` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

INSERT INTO `%DB_PREFIX%m_config` (`id`, `code`, `title`, `val`) VALUES
(10, 'kf_phone', '客服电话', '0591-83323127'),
(11, 'kf_email', '客服邮箱', 'kf@futuan.com'),
(16, 'page_size', '分页大小', '15'),
(17, 'about_info', '关于我们', '<p>\r\n	方维网 www.fanwe.com</p>\r\n'),
(18, 'version', '软件版本', '1.0'),
(19, 'filename', '软件文件名', 'futuan.apk'),
(20, 'program_title', '程序标题名称', '方维网'),
(21, 'index_logo', '首页LOGO', './public/upload/m/201201/12/4f0e576b8181c.png');

DROP TABLE IF EXISTS `%DB_PREFIX%m_config_list`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%m_config_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pay_id` varchar(50) DEFAULT NULL,
  `group` int(10) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `has_calc` int(1) DEFAULT NULL,
  `money` float(10,2) DEFAULT NULL,
  `is_verify` int(1) DEFAULT '0' COMMENT '0:无效；1:有效',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

INSERT INTO `%DB_PREFIX%m_config_list` (`id`, `pay_id`, `group`, `code`, `title`, `has_calc`, `money`, `is_verify`) VALUES
(1, '19', 1, 'Malipay', '支付宝/各银行', 0, NULL, 0),
(2, '20', 1, 'Mcod', '现金支付', 0, NULL, 0),
(5, NULL, 4, '新闻公告', '新闻公告dsadsada', NULL, NULL, 1),
(6, NULL, 4, '新闻公告2', 'dsatfdsaewfewa', NULL, NULL, 1);

DROP TABLE IF EXISTS `%DB_PREFIX%m_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%m_index` (
  `id` mediumint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `vice_name` varchar(100) DEFAULT NULL,
  `desc` varchar(100) DEFAULT '',
  `img` varchar(255) DEFAULT '',
  `type` tinyint(1) DEFAULT '0' COMMENT '1.标签集,2.url地址,3.分类排行,4.最亮达人,5.搜索发现,6.一起拍,7.热门单品排行,8.直接显示某个分享',
  `data` text,
  `sort` smallint(5) DEFAULT '10',
  `status` tinyint(1) DEFAULT '1',
  `is_hot` tinyint(1) DEFAULT '0',
  `is_new` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

INSERT INTO `%DB_PREFIX%m_index` (`id`, `name`, `vice_name`, `desc`, `img`, `type`, `data`, `sort`, `status`, `is_hot`, `is_new`) VALUES
(1, '至In美衣', 'Pretty Clothes', '扮美必备，件件都是的必头好', './public/upload/m/IMG_0236_02.png', 1, 'a:2:{s:3:"cid";i:2;s:4:"tags";a:20:{i:0;s:6:"衬衫";i:1;s:9:"连衣裙";i:2;s:6:"短裤";i:3;s:6:"短裙";i:4;s:6:"毛衣";i:5;s:9:"呢大衣";i:6;s:6:"西装";i:7;s:6:"斗篷";i:8;s:6:"棉服";i:9;s:9:"羽绒服";i:10;s:6:"马甲";i:11;s:6:"卫衣";i:12;s:9:"打底衫";i:13;s:6:"蕾丝";i:14;s:9:"娃娃领";i:15;s:6:"长款";i:16;s:6:"豹纹";i:17;s:6:"英伦";i:18;s:6:"日系";i:19;s:6:"复古";}}', 1, 1, 1, 0),
(2, '恋恋鞋事', 'Lady Shoes', '女人总是缺少一双鞋子', './public/upload/m/IMG_0236_04.png', 1, 'a:2:{s:3:"cid";i:4;s:4:"tags";a:12:{i:0;s:9:"高跟鞋";i:1;s:9:"牛津鞋";i:2;s:9:"及踝靴";i:3;s:6:"短靴";i:4;s:6:"长靴";i:5;s:9:"雪地靴";i:6;s:9:"家居鞋";i:7;s:9:"过膝靴";i:8;s:9:"机车靴";i:9;s:6:"英伦";i:10;s:6:"日系";i:11;s:6:"复古";}}', 2, 1, 0, 0),
(3, '暖暖饰物', 'Accessories', '恋物癖の决胜关键', './public/upload/m/IMG_0236_05.png', 1, 'a:2:{s:3:"cid";i:6;s:4:"tags";a:21:{i:0;s:6:"围巾";i:1;s:6:"帽子";i:2;s:6:"耳罩";i:3;s:6:"手套";i:4;s:6:"披肩";i:5;s:6:"腰带";i:6;s:6:"项链";i:7;s:6:"发箍";i:8;s:6:"发夹";i:9;s:6:"镜框";i:10;s:9:"轻松熊";i:11;s:5:"Hello";i:12;s:5:"Kitty";i:13;s:9:"假领子";i:14;s:6:"手表";i:15;s:6:"抱枕";i:16;s:9:"马克杯";i:17;s:9:"手机链";i:18;s:6:"雨伞";i:19;s:9:"手机壳";i:20;s:6:"情侣";}}', 3, 1, 0, 0),
(4, '最爱潮包', 'Fashion Bags', '漂亮包包，惊声尖叫吧！', './public/upload/m/IMG_0236_06.png', 1, 'a:2:{s:3:"cid";i:5;s:4:"tags";a:16:{i:0;s:9:"明星款";i:1;s:9:"公文包";i:2;s:9:"单肩包";i:3;s:9:"双肩包";i:4;s:9:"复古包";i:5;s:9:"水桶包";i:6;s:9:"手提包";i:7;s:9:"拼接包";i:8;s:6:"钱包";i:9;s:9:"旅行箱";i:10;s:9:"斜挎包";i:11;s:9:"零钱包";i:12;s:9:"相机包";i:13;s:9:"收纳包";i:14;s:9:"购物袋";i:15;s:9:"帆布包";}}', 4, 1, 0, 0),
(5, '时尚风向标', 'Hot Trend', '人气NO.1单口大搜罗！', './public/upload/m/IMG_0237_02.png', 3, NULL, 5, 1, 0, 1),
(6, '最亮达人', 'Hot Stars', '趣购街达人全家福，和她们逛街吧！', './public/upload/m/IMG_0237_05.png', 4, NULL, 6, 1, 0, 0),
(7, '搜索发现', 'Search', '一键搜索，时尚直达', './public/upload/m/IMG_0237_06.png', 5, NULL, 7, 1, 0, 0),
(8, '一起拍', 'Photo', '简单而有趣的方式和大家一起拍照分享美丽', './public/upload/m/IMG_0237_03.png', 6, NULL, 8, 1, 0, 0),
(9, '趣购街', 'QuGouJie', '趣购街，当下最时尚最流行的女性社区', './public/upload/m/IMG_0236_03.png', 2, 'a:1:{s:3:"url";s:23:"http://www.qugoujie.com";}', 9, 1, 0, 0),
(10, '冬季短裤女', 'User Share', '滚边牛角扣牛仔短裤靴裤', './public/upload/m/IMG_0237_04.png', 8, 'a:1:{s:8:"share_id";i:67240;}', 10, 1, 0, 0);

DROP TABLE IF EXISTS `%DB_PREFIX%m_searchcate`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%m_searchcate` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT '',
  `cid` smallint(6) DEFAULT '0',
  `bg` varchar(255) DEFAULT '',
  `tags` text,
  `sort` smallint(5) DEFAULT '10',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8;

INSERT INTO `%DB_PREFIX%m_searchcate` (`id`, `name`, `cid`, `bg`, `tags`, `sort`, `status`) VALUES
(1, '当季', 0, './public/upload/m/dangji.png', 'a:12:{i:0;a:2:{s:3:"tag";s:6:"显瘦";s:5:"color";s:0:"";}i:1;a:2:{s:3:"tag";s:6:"英伦";s:5:"color";s:7:"#E60E6E";}i:2;a:2:{s:3:"tag";s:6:"欧美";s:5:"color";s:0:"";}i:3;a:2:{s:3:"tag";s:6:"波点";s:5:"color";s:0:"";}i:4;a:2:{s:3:"tag";s:6:"毛绒";s:5:"color";s:7:"#E60E6E";}i:5;a:2:{s:3:"tag";s:6:"条纹";s:5:"color";s:0:"";}i:6;a:2:{s:3:"tag";s:6:"日韩";s:5:"color";s:0:"";}i:7;a:2:{s:3:"tag";s:6:"复古";s:5:"color";s:0:"";}i:8;a:2:{s:3:"tag";s:6:"情侣";s:5:"color";s:7:"#E60E6E";}i:9;a:2:{s:3:"tag";s:6:"红色";s:5:"color";s:0:"";}i:10;a:2:{s:3:"tag";s:12:"明星同款";s:5:"color";s:7:"#E60E6E";}i:11;a:2:{s:3:"tag";s:10:"vivi风格";s:5:"color";s:0:"";}}', 1, 1),
(2, '衣服', 2, './public/upload/m/yifu.png', 'a:13:{i:0;a:2:{s:3:"tag";s:6:"毛衣";s:5:"color";s:7:"#E60E6E";}i:1;a:2:{s:3:"tag";s:6:"开衫";s:5:"color";s:0:"";}i:2;a:2:{s:3:"tag";s:6:"风衣";s:5:"color";s:0:"";}i:3;a:2:{s:3:"tag";s:9:"羽绒服";s:5:"color";s:7:"#E60E6E";}i:4;a:2:{s:3:"tag";s:9:"连衣裙";s:5:"color";s:0:"";}i:5;a:2:{s:3:"tag";s:6:"卫衣";s:5:"color";s:7:"#E60E6E";}i:6;a:2:{s:3:"tag";s:6:"斗篷";s:5:"color";s:0:"";}i:7;a:2:{s:3:"tag";s:6:"衬衫";s:5:"color";s:0:"";}i:8;a:2:{s:3:"tag";s:9:"呢大衣";s:5:"color";s:7:"#E60E6E";}i:9;a:2:{s:3:"tag";s:9:"牛仔裤";s:5:"color";s:0:"";}i:10;a:2:{s:3:"tag";s:9:"打底裤";s:5:"color";s:7:"#E60E6E";}i:11;a:2:{s:3:"tag";s:6:"西装";s:5:"color";s:0:"";}i:12;a:2:{s:3:"tag";s:7:"fdsfdsf";s:5:"color";s:7:"#ed008c";}}', 2, 1),
(3, '鞋子', 4, './public/upload/m/xiezhi.png', 'a:12:{i:0;a:2:{s:3:"tag";s:9:"过膝靴";s:5:"color";s:7:"#E60E6E";}i:1;a:2:{s:3:"tag";s:9:"雪地靴";s:5:"color";s:0:"";}i:2;a:2:{s:3:"tag";s:9:"家居鞋";s:5:"color";s:7:"#E60E6E";}i:3;a:2:{s:3:"tag";s:6:"长靴";s:5:"color";s:0:"";}i:4;a:2:{s:3:"tag";s:9:"机车靴";s:5:"color";s:7:"#E60E6E";}i:5;a:2:{s:3:"tag";s:6:"雨鞋";s:5:"color";s:0:"";}i:6;a:2:{s:3:"tag";s:9:"运动鞋";s:5:"color";s:0:"";}i:7;a:2:{s:3:"tag";s:9:"坡跟鞋";s:5:"color";s:0:"";}i:8;a:2:{s:3:"tag";s:9:"马丁鞋";s:5:"color";s:7:"#E60E6E";}i:9;a:2:{s:3:"tag";s:9:"高跟鞋";s:5:"color";s:0:"";}i:10;a:2:{s:3:"tag";s:9:"及踝鞋";s:5:"color";s:7:"#E60E6E";}i:11;a:2:{s:3:"tag";s:9:"帆布鞋";s:5:"color";s:0:"";}}', 3, 1),
(4, '包包', 5, './public/upload/m/baobao.png', 'a:11:{i:0;a:2:{s:3:"tag";s:9:"旅行箱";s:5:"color";s:7:"#E60E6E";}i:1;a:2:{s:3:"tag";s:9:"环保袋";s:5:"color";s:0:"";}i:2;a:2:{s:3:"tag";s:9:"双肩包";s:5:"color";s:0:"";}i:3;a:2:{s:3:"tag";s:9:"化妆包";s:5:"color";s:0:"";}i:4;a:2:{s:3:"tag";s:6:"钱包";s:5:"color";s:7:"#E60E6E";}i:5;a:2:{s:3:"tag";s:9:"邮差包";s:5:"color";s:0:"";}i:6;a:2:{s:3:"tag";s:9:"菱格包";s:5:"color";s:7:"#E60E6E";}i:7;a:2:{s:3:"tag";s:9:"相机包";s:5:"color";s:0:"";}i:8;a:2:{s:3:"tag";s:9:"单肩包";s:5:"color";s:0:"";}i:9;a:2:{s:3:"tag";s:9:"链条包";s:5:"color";s:7:"#E60E6E";}i:10;a:2:{s:3:"tag";s:9:"水桶包";s:5:"color";s:0:"";}}', 4, 1),
(5, '配饰', 6, './public/upload/m/peishi.png', 'a:12:{i:0;a:2:{s:3:"tag";s:6:"围巾";s:5:"color";s:7:"#E60E6E";}i:1;a:2:{s:3:"tag";s:6:"手套";s:5:"color";s:7:"#E60E6E";}i:2;a:2:{s:3:"tag";s:6:"耳罩";s:5:"color";s:0:"";}i:3;a:2:{s:3:"tag";s:6:"帽子";s:5:"color";s:7:"#E60E6E";}i:4;a:2:{s:3:"tag";s:6:"镜框";s:5:"color";s:0:"";}i:5;a:2:{s:3:"tag";s:6:"耳钉";s:5:"color";s:0:"";}i:6;a:2:{s:3:"tag";s:6:"发箍";s:5:"color";s:0:"";}i:7;a:2:{s:3:"tag";s:6:"围脖";s:5:"color";s:7:"#E60E6E";}i:8;a:2:{s:3:"tag";s:6:"腰带";s:5:"color";s:0:"";}i:9;a:2:{s:3:"tag";s:6:"戒指";s:5:"color";s:0:"";}i:10;a:2:{s:3:"tag";s:6:"发夹";s:5:"color";s:0:"";}i:11;a:2:{s:3:"tag";s:6:"手表";s:5:"color";s:7:"#E60E6E";}}', 5, 1),
(6, '彩妆', 7, './public/upload/m/caizhuang.png', 'a:12:{i:0;a:2:{s:3:"tag";s:6:"香水";s:5:"color";s:7:"#E60E6E";}i:1;a:2:{s:3:"tag";s:6:"清洁";s:5:"color";s:0:"";}i:2;a:2:{s:3:"tag";s:9:"爽肤水";s:5:"color";s:0:"";}i:3;a:2:{s:3:"tag";s:6:"乳霜";s:5:"color";s:0:"";}i:4;a:2:{s:3:"tag";s:6:"唇膏";s:5:"color";s:7:"#E60E6E";}i:5;a:2:{s:3:"tag";s:6:"面膜";s:5:"color";s:7:"#E60E6E";}i:6;a:2:{s:3:"tag";s:6:"美白";s:5:"color";s:0:"";}i:7;a:2:{s:3:"tag";s:6:"眼妆";s:5:"color";s:0:"";}i:8;a:2:{s:3:"tag";s:6:"祛痘";s:5:"color";s:7:"#E60E6E";}i:9;a:2:{s:3:"tag";s:6:"底妆";s:5:"color";s:0:"";}i:10;a:2:{s:3:"tag";s:5:"BB霜";s:5:"color";s:0:"";}i:11;a:2:{s:3:"tag";s:6:"美甲";s:5:"color";s:7:"#E60E6E";}}', 6, 1),
(7, '家居', 8, './public/upload/m/jiaju.png', 'a:12:{i:0;a:2:{s:3:"tag";s:9:"手机壳";s:5:"color";s:7:"#E60E6E";}i:1;a:2:{s:3:"tag";s:9:"保温杯";s:5:"color";s:0:"";}i:2;a:2:{s:3:"tag";s:6:"礼品";s:5:"color";s:7:"#E60E6E";}i:3;a:2:{s:3:"tag";s:6:"靠垫";s:5:"color";s:0:"";}i:4;a:2:{s:3:"tag";s:6:"餐具";s:5:"color";s:0:"";}i:5;a:2:{s:3:"tag";s:9:"收纳盒";s:5:"color";s:0:"";}i:6;a:2:{s:3:"tag";s:6:"宜家";s:5:"color";s:7:"#E60E6E";}i:7;a:2:{s:3:"tag";s:6:"抱枕";s:5:"color";s:0:"";}i:8;a:2:{s:3:"tag";s:6:"相机";s:5:"color";s:0:"";}i:9;a:2:{s:3:"tag";s:12:"床上用品";s:5:"color";s:7:"#E60E6E";}i:10;a:2:{s:3:"tag";s:6:"沙发";s:5:"color";s:0:"";}i:11;a:2:{s:3:"tag";s:6:"地毯";s:5:"color";s:0:"";}}', 7, 1);


DROP TABLE IF EXISTS `%DB_PREFIX%nav`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%nav` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `cid` smallint(6) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `sort` smallint(5) NOT NULL DEFAULT '100',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_fix` tinyint(1) NOT NULL DEFAULT '0',
  `target` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%nav_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%nav_category` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(60) NOT NULL DEFAULT '',
  `sort` smallint(5) NOT NULL DEFAULT '100',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_fix` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

INSERT INTO `%DB_PREFIX%nav_category` (`id`, `parent_id`, `name`, `sort`, `status`, `is_fix`) VALUES
(1, 0, '主导航', 100, 1, 1),
(2, 0, '底部导航', 100, 1, 1),
(3, 0, '固定链接', 100, 1, 1),
(4, 2, '网站', 100, 1, 0),
(5, 2, '团队', 100, 1, 0),
(6, 2, '帮助', 100, 1, 0);

DROP TABLE IF EXISTS `%DB_PREFIX%order`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(255) NOT NULL,
  `data_name` varchar(255) NOT NULL DEFAULT '',
  `goods_status` tinyint(1) NOT NULL COMMENT '0:未发货;1:部分发货;2:全部发货;3:部分退货;4:全部退货'',',
  `data_num` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '订单状态\r\n0: 未确认\r\n1: 完成\r\n2: 作废',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `region_lv1` int(11) NOT NULL,
  `region_lv2` int(11) NOT NULL,
  `region_lv3` int(11) NOT NULL,
  `region_lv4` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile_phone` varchar(255) NOT NULL,
  `fax_phone` varchar(255) NOT NULL,
  `fix_phone` varchar(255) NOT NULL,
  `alim` varchar(255) NOT NULL,
  `msn` varchar(255) NOT NULL,
  `qq` varchar(255) NOT NULL,
  `consignee` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  `user_name` varchar(60) NOT NULL DEFAULT '',
  `memo` varchar(255) NOT NULL,
  `adm_memo` varchar(255) NOT NULL,
  `order_score` int(11) NOT NULL,
  `rec_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`),
  KEY `uid` (`uid`),
  KEY `rec_id` (`rec_id`),
  KEY `goods_status` (`goods_status`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%pub_schedule`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%pub_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `data` text NOT NULL,
  `pub_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%referrals`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%referrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `rid` int(11) NOT NULL,
  `is_pay` tinyint(1) NOT NULL,
  `score` float(10,0) NOT NULL,
  `create_time` int(10) DEFAULT '0',
  `create_day` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `rid` (`rid`),
  KEY `is_pay` (`is_pay`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%second`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%second` (
  `sid` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT '',
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`sid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%second_goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%second_goods` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` smallint(6) NOT NULL,
  `share_id` int(11) DEFAULT NULL,
  `alipay_gid` varchar(60) NOT NULL DEFAULT '',
  `name` varchar(100) DEFAULT '',
  `content` text,
  `city_id` int(11) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `transport_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `valid_time` int(11) NOT NULL DEFAULT '0',
  `page` varchar(255) NOT NULL DEFAULT '',
  `num` smallint(6) NOT NULL DEFAULT '0',
  `sign` varchar(255) NOT NULL DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`gid`),
  UNIQUE KEY `share_id` (`share_id`),
  KEY `sid` (`sid`),
  KEY `city_id` (`city_id`),
  KEY `uid` (`uid`),
  KEY `sid_city` (`sid`,`city_id`),
  KEY `alipay_gid` (`alipay_gid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%sessions`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sessions` (
  `sid` char(6) NOT NULL DEFAULT '',
  `ip1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `user_name` char(15) NOT NULL DEFAULT '',
  `gid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `share_id` int(11) NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `last_update` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `sid` (`sid`),
  KEY `uid` (`uid`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share` (
  `share_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `rec_id` int(11) NOT NULL DEFAULT '0',
  `rec_uid` int(11) DEFAULT '0',
  `content` text,
  `collect_count` int(10) unsigned DEFAULT '0',
  `collect_1count` int(10) unsigned DEFAULT '0',
  `collect_7count` int(10) unsigned DEFAULT '0',
  `comment_count` int(10) unsigned DEFAULT '0',
  `relay_count` int(10) unsigned DEFAULT '0',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  `day_time` int(11) DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `type` enum('default','fav','comments','bar','bar_post','bar_best','album','album_item','album_best','album_rec','event','event_post','group','group_join','group_best') NOT NULL DEFAULT 'default',
  `share_data` enum('goods','photo','default','goods_photo') NOT NULL DEFAULT 'default',
  `base_id` int(11) NOT NULL COMMENT '原创主题的ID，本贴为原创，则base_id为0',
  `is_best` tinyint(1) DEFAULT '0',
  `is_rec_best` tinyint(1) NOT NULL DEFAULT '0',
  `is_index` tinyint(1) DEFAULT '0',
  `collect_share` varchar(60) DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `cache_data` text,
  `sort` smallint(4) DEFAULT '100',
  `best_desc` varchar(255) DEFAULT '',
  `source` varchar(30) DEFAULT 'web',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`),
  KEY `day_time` (`day_time`),
  KEY `status` (`status`),
  KEY `rec_type` (`rec_id`,`type`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `%DB_PREFIX%sharegoods_module`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sharegoods_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `icon` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT '',
  `content` text,
  `api_data` text,
  `sort` smallint(5) DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4;

INSERT INTO `%DB_PREFIX%sharegoods_module` (`id`, `class`, `domain`, `status`, `name`, `url`, `icon`, `logo`, `content`, `api_data`, `sort`) VALUES
(1, 'taobao', 'http://item.taobao.com,http://item.tmall.com', 1, '淘宝', 'http://www.taobao.com', './public/upload/business/taobao.gif', '', '淘宝应用用于获取淘宝商品、店铺信息，可到 http://open.taobao.com/ 点击 申请成为合作伙伴 ', 'a:5:{s:7:"app_key";s:0:"";s:10:"app_secret";s:0:"";s:6:"tk_pid";s:0:"";s:11:"session_key";s:0:"";s:10:"expires_in";i:0;}', 100),
(2, 'paipai', 'http://auction1.paipai.com', 1, '拍拍', 'http://www.paipai.com', './public/upload/business/paipai.gif', '', '拍拍应用用于获取拍拍商品、店铺信息，可到 http://pop.paipai.com/ 点击 申请成为合作伙伴 ', 'a:4:{s:3:"uin";s:0:"";s:4:"spid";s:0:"";s:5:"token";s:0:"";s:6:"seckey";s:0:"";}', 100),
(3, 'yiqifa', '', 1, '亿起发', 'http://www.yiqifa.com', '', '', '使用亿起发可通过接口获取当当、凡客、京东等近200个网站的商品数据（注：有少量商品可能无法获取到相关数据），访问 http://www.yiqifa.com/userRegEdit.do?regType=earner 注册成为网站主（注册时在推荐人处填写方维推荐，将有专门的客服人员进行维护），注册成功后进入 http://open.yiqifa.com 创建相关应用。(客服QQ：1153691793)', 'a:4:{s:7:"app_key";s:0:"";s:10:"app_secret";s:0:"";s:3:"uid";s:0:"";s:7:"site_id";s:0:"";}', 100);

DROP TABLE IF EXISTS `%DB_PREFIX%share_cancel`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_cancel` (
  `share_id` int(11) NOT NULL,
  `uid` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_category`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_category` (
  `share_id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL,
  `uid` int(11) DEFAULT '0',
  KEY `share_id` (`share_id`),
  KEY `cate_id` (`cate_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_check`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_check` (
  `share_id` int(11) NOT NULL,
  `uid` int(11) DEFAULT '0',
  PRIMARY KEY (`share_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_collect1`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_collect1` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_collect7`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_collect7` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_collect_temp`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_collect_temp` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`share_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_comment`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `content` text,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `share_id` (`share_id`),
  KEY `uid` (`uid`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `%DB_PREFIX%share_dapei_best`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_dapei_best` (
  `share_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `%DB_PREFIX%share_dapei_goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_dapei_goods` (
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

DROP TABLE IF EXISTS `%DB_PREFIX%share_dapei_index`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_dapei_index` (
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

DROP TABLE IF EXISTS `%DB_PREFIX%share_goods`;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0',
  `img_id` int(11) DEFAULT '0',
  `shop_id` int(11) DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0',
  `share_id` int(11) NOT NULL DEFAULT '0',
  `price` decimal(10,2) DEFAULT '0.00',
  `sort` smallint(5) DEFAULT '10',
  `base_id` int(11) DEFAULT '0',
  `base_share` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `share_id` (`share_id`),
  KEY `uid_goods` USING BTREE(`uid`,`goods_id`) ,
  KEY `shop_id` (`shop_id`),
  KEY `base_id` (`base_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;