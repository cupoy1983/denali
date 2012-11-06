3.0;
CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`title`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`share_id`  int(11) NULL DEFAULT 0 ,
	`uid`  int(11) NULL DEFAULT 0 ,
	`cid`  smallint(6) NULL DEFAULT 0 ,
	`cost`  decimal(10,2) NULL DEFAULT 0.00 ,
	`begin_time`  int(11) NULL DEFAULT 0 ,
	`end_time`  int(11) NULL DEFAULT 0 ,
	`place`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`gender`  tinyint(1) NULL DEFAULT 0 ,
	`number`  smallint(6) NULL DEFAULT 0 ,
	`apply_number`  smallint(6) NULL DEFAULT 0 ,
	`expiration_time`  int(11) NULL DEFAULT 0 ,
	`fields`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`score`  smallint(6) NULL DEFAULT 0 ,
	`province`  smallint(6) NULL DEFAULT 0 ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `share_id` USING BTREE(`share_id`)  ,
	INDEX `uid` USING BTREE(`uid`)  ,
	INDEX `apply_number` USING BTREE(`apply_number`)  ,
	INDEX `province` USING BTREE (`province`) ,
	INDEX `cid` USING BTREE (`cid`) 
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_apply` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`uid`  int(11) NULL DEFAULT 0 ,
	`aid`  int(11) NULL DEFAULT 0 ,
	`content`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`status`  tinyint(1) NULL DEFAULT 0 ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	`fields_data`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	PRIMARY KEY (`id`),
	INDEX `uid` USING BTREE (`uid`) ,
	INDEX `aid` USING BTREE(`aid`)  ,
	INDEX `status` USING BTREE (`aid`, `status`) 
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_cate` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`status`  tinyint(1) NULL DEFAULT 1 ,
	`sort`  smallint(5) NULL DEFAULT 10 ,
	PRIMARY KEY (`id`)
)ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `%DB_PREFIX%activity_cate` (`id`, `name`, `status`, `sort`) VALUES
(1, '朋友聚会', 1, 10),
(2, '出外郊游', 1, 10),
(3, '自驾出行', 1, 10),
(4, '公益活动', 1, 10),
(5, '线上活动', 1, 10);

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_match` (
	`id`  int(11) NOT NULL ,
	`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	PRIMARY KEY (`id`),
	FULLTEXT INDEX `content` (`content`) 
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_post` (
	`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
	`aid`  int(11) NULL DEFAULT NULL ,
	`share_id`  int(11) NULL DEFAULT NULL ,
	`uid`  int(11) NULL DEFAULT NULL ,
	`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `uid` USING BTREE(`uid`)  ,
	INDEX `share_id` USING BTREE(`share_id`)  ,
	INDEX `aid` USING BTREE(`aid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `%DB_PREFIX%album` ADD `seo_title` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_keywords` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_description` VARCHAR( 255 ) NOT NULL DEFAULT  '';
ALTER TABLE `%DB_PREFIX%album_category` CHANGE `seo_desc` `seo_description` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%anchor` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`word`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`brief`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`url`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`target`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '_blank' ,
	`status`  tinyint(1) NULL DEFAULT 1 ,
	PRIMARY KEY (`id`)
)ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci ;

ALTER TABLE `%DB_PREFIX%cron` MODIFY COLUMN `server` enum('share','commission','goods','collect') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'share';

ALTER TABLE `%DB_PREFIX%daren_cate` ADD `seo_title` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_keywords` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_description` VARCHAR( 255 ) NOT NULL DEFAULT  '';

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%delist_share` (
	`share_id`  int(11) NULL DEFAULT NULL 
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `%DB_PREFIX%exchange_goods` ADD `uid`  int(11) NULL DEFAULT 0,ADD `share_id`  int(11) NULL DEFAULT 0,ADD `apply_type`  tinyint(1) NULL DEFAULT 0,ADD `img_id`  int(11) NULL DEFAULT 0,ADD `price`  decimal(10,2) NULL DEFAULT 0.00,ADD `apply_content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,ADD `apply_count`  int(11) NULL DEFAULT 0,ADD `apply_cache`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,ADD `seo_title`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',ADD `seo_keywords`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',ADD COLUMN `seo_description`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';

CREATE INDEX `uid` USING BTREE ON `%DB_PREFIX%exchange_goods` (`uid`)  ;
CREATE INDEX `share_id` USING BTREE  ON `%DB_PREFIX%exchange_goods` (`share_id`) ;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%exchange_post` (
	`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
	`eid`  int(11) NULL DEFAULT NULL ,
	`share_id`  int(11) NULL DEFAULT NULL ,
	`uid`  int(11) NULL DEFAULT NULL ,
	`type`  tinyint(1) NULL DEFAULT 0 ,
	`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `uid` USING BTREE (`uid`) ,
	INDEX `share_id` USING BTREE (`share_id`) ,
	INDEX `aid` USING BTREE(`eid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `%DB_PREFIX%forum` ADD `seo_title` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_keywords` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_description` VARCHAR( 255 ) NOT NULL DEFAULT  '';

ALTER TABLE `%DB_PREFIX%forum_thread` ADD `seo_title` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_keywords` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_description` VARCHAR( 255 ) NOT NULL DEFAULT  '';

ALTER TABLE `%DB_PREFIX%goods` ADD `commission`  decimal(10,2) NULL DEFAULT 0.00,ADD `comment_collect_time`  int(11) NULL DEFAULT 0,ADD `color`  smallint(6) NULL DEFAULT 0,ADD COLUMN `content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;


ALTER TABLE `%DB_PREFIX%goods_category` CHANGE `seo_desc` `seo_description` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
ALTER TABLE `%DB_PREFIX%goods_category` ADD COLUMN `seo_title`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';

ALTER TABLE `%DB_PREFIX%goods_cates` DROP INDEX `id_type`;
ALTER TABLE `%DB_PREFIX%goods_cates` ADD COLUMN `pids`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '';
CREATE UNIQUE INDEX `id_type_pid` USING BTREE  ON `%DB_PREFIX%goods_cates` (`type`, `id`, `pid`) ;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_cate_collect` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`cid`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' ,
	`pids`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_cate_disable` (
	`id`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`pid`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`type`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	UNIQUE INDEX `id_pid_type` USING BTREE(`id`, `type`, `pid`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_color` (
	`id`  smallint(6) NOT NULL AUTO_INCREMENT ,
	`name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`color`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`icon`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`sort`  smallint(5) NULL DEFAULT 10 ,
	`status`  tinyint(1) NULL DEFAULT 1 ,
	PRIMARY KEY (`id`)
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `%DB_PREFIX%goods_color` (`id`, `name`, `color`, `icon`, `sort`, `status`) VALUES
(1, '黄色系', '#ffd403', '', 100, 1),
(2, '橙色系', '#f46f22', '', 100, 1),
(3, '红色系', '#ee183a', '', 100, 1),
(4, '紫色系', '#5b2d90', '', 100, 1),
(5, '蓝色系', '#0173bc', '', 100, 1),
(6, '绿色系', '#486a00', '', 100, 1),
(7, '灰色系', '#b5b5b5', '', 100, 1),
(8, '黑色系', '#000000', '', 100, 1);

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_comment` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`goods_id`  int(11) NULL DEFAULT 0 ,
	`commont_id`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' ,
	`user_name`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`avatar`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `goods_id` USING BTREE(`goods_id`)  ,
	INDEX `commont_id` USING BTREE(`commont_id`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_dictionary` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`word`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`rword`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`status`  tinyint(1) NULL DEFAULT 1 ,
	PRIMARY KEY (`id`)
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE INDEX `goods_id` USING BTREE ON `%DB_PREFIX%goods_order` (`goods_id`)  ;

ALTER TABLE `%DB_PREFIX%image_servers` ADD COLUMN `url_rewrite`  tinyint(1) NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%mail_rss_category` (
	`cate_id`  smallint(6) NOT NULL AUTO_INCREMENT ,
	`parent_id`  smallint(6) NULL DEFAULT 0 ,
	`cate_name`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`short_name`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' ,
	`cate_code`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`cate_icon`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '小图标' ,
	`cate_logo`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '详细页显示logo' ,
	`cate_img`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '详细页面大图' ,
	`about`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '简介' ,
	`desc`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '说明' ,
	`seo_keywords`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`seo_desc`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	`last_send_time`  int(11) NULL DEFAULT 0 COMMENT '最后发布时间' ,
	`sort`  smallint(6) NOT NULL DEFAULT 100 ,
	`status`  tinyint(1) NOT NULL DEFAULT 1 ,
	`is_best`  tinyint(1) NOT NULL DEFAULT 0 ,
	`rss_count`  int(11) NULL DEFAULT 0 COMMENT '订阅数量' ,
	PRIMARY KEY (`cate_id`),
	INDEX `parent_id` USING BTREE(`parent_id`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `%DB_PREFIX%mail_rss_category` VALUES ('1', '0', '生活', '生活', 'shenghuo', '', '', '', '', '', '', '', '1350845539', '0', '100', '1', '0', '0');
INSERT INTO `%DB_PREFIX%mail_rss_category` VALUES ('2', '1', '微语录', '微语录', 'weiyulu', './public/upload/mailrss/5084b5aecff3d.gif', './public/upload/mailrss/5084b5aed68ae.gif', './public/upload/mailrss/5084b5aed7fee.jpg', '在不知不觉中，我突然有一种这样的感觉', '在不知不觉中，我突然有一种这样的感觉，不是不爱，是不能爱。走进一个人的世界，哭着，想着，恋着，笑着，讲述着，你总是看着，没有说过一句话。因为有你，所以渴望。但我从那些片只语中听到了失望，于是说服自己习惯独处，习惯一个人默默行走。不是不想爱，是不能爱。因为怕伤人，也怕被伤。\r\n \r\n 微语录相关推荐：\r\n有时候，就是想安安静静， 因为真的我累了\r\n秋思，是一回欣赏，不是愁思\r\n我们唯一可以做的，就是珍惜眼前的幸福\r\n人生如梦，岁月无情\r\n他们幸运的相遇，却最终不能在一起\r\n有的时候爱的太久，人心会醉\r\n ', '微语录', '微语录', '1350845742', '0', '100', '1', '1', '0');
INSERT INTO `%DB_PREFIX%mail_rss_category` VALUES ('3', '1', '青春写真', '青春写真', 'qcxz', './public/upload/mailrss/5084b686b11e0.gif', './public/upload/mailrss/5084b686b6bcb.gif', './public/upload/mailrss/5084b686b7bb7.jpg', '静夏时光：献给永远长不大的熊孩子们[20P]', '夏天来到的时刻，街上白皙的娇俏的女孩晒着健康的肤色，露出洁白的牙齿笑得很灿烂。于是又在Wei bo上大张旗鼓的叫嚣道：这个夏天，快让我在草地上撒点野！多么激情澎... ', '青春 写真', '青春 写真 静夏时光：献给永远长不大的熊孩子们', '1350845958', '1350847351', '100', '1', '1', '0');
INSERT INTO `%DB_PREFIX%mail_rss_category` VALUES ('4', '1', '旅行路上', '旅行路上', 'lxls', './public/upload/mailrss/5084b71b448bc.gif', './public/upload/mailrss/5084b71b49824.gif', './public/upload/mailrss/5084b71b4a763.jpg', '美食界的萌物，和果子', '旅行导读：日本人追求精致这件事，已经渗到骨子里了。就拿和果子（日本的点心）来说，这一手的细腻，恨不得全揉到一口大的小果子上，每一粒食材和色彩都极致琢磨推敲，暂且... ', '旅行路上', '旅行路上', '1350846107', '0', '100', '1', '1', '0');


CREATE TABLE IF NOT EXISTS `%DB_PREFIX%mail_rss_content` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`cate_id`  int(11) NOT NULL ,
	`title`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题' ,
	`sids`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分享信息id 集合' ,
	`is_html`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '订阅内容类型 0.根据分享ID，1.html内容' ,
	`html_content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	`status`  tinyint(1) NOT NULL DEFAULT 0 ,
	PRIMARY KEY (`id`)
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `%DB_PREFIX%mail_rss_content` VALUES ('1', '3', '那年花季：谁为年华做媒', '', '1', '<p>\r\n	<span style=\"color: rgb(0, 0, 0); font-family: Verdana; font-size: 14px; line-height: 23px; \">走进花季，激起所有色彩的轻舞飞扬，穿越一季的倾情歌唱，哲人对着蓝天微笑说：&ldquo;是青春 灿烂的青春年华。&rdquo;书声朗朗的教室，朝气蓬勃的操场，点燃青春，传递希望，照亮我们心中埋藏已久的梦想！那里是我们梦的起点，大学生活充满激情、充满斗志、充满向往，真正的人生将从那里出发，怀揣梦想飞向未来。</span></p>\r\n<p style=\"line-height: 23px; color: rgb(0, 0, 0); font-family: Verdana; font-size: 14px; \">\r\n	大学使一大批四面八方来的朋友都聚在了一起畅谈理想，或卧谈会里尽抒青涩情怀。所谓有朋自远方来，不亦乐乎。我们欢喜着踏入了人生的另一个层次，我们欢呼着享受这历经十年寒窗而来自不易的自由，天知道那些青春的芳华岁月有多么香醇迷人。然而这也是理想，爱情与现实相互交织，彼此冲撞的地方，就在我们彷徨，挣扎，呐喊，逃脱的漫长过程中，我们长大了。当一切再次回头观望时，不由得让人哑然失笑，然而当时青春就是那么执拗。　　</p>\r\n<p style=\"line-height: 23px; color: rgb(0, 0, 0); font-family: Verdana; font-size: 14px; \">\r\n	过往的岁月，流逝的情怀，淡去的记忆，增长的年岁慢慢的剥蚀着我们饱满充实的曾经。有人曾说，忘记过去就意味着背叛，那么就在闲暇时偶尔重拾回味一下青春年华吧，看看自己当时是多么的年轻。</p>\r\n', '1350847208', '1');



CREATE TABLE IF NOT EXISTS `%DB_PREFIX%mail_rss_send_log` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`uid`  int(11) NOT NULL ,
	`content_id`  int(11) NOT NULL ,
	`status`  tinyint(1) NOT NULL ,
	`create_time`  int(11) NULL DEFAULT NULL ,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%mail_rss_user` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`uid`  int(11) NOT NULL ,
	`cate_id`  int(11) NOT NULL ,
	`status`  tinyint(1) NOT NULL DEFAULT 1 ,
	`create_time`  int(11) NOT NULL ,
	`rss_sn`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `id_uid_index` USING BTREE(`uid`, `cate_id`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%mail_template` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`mail_title`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`mail_content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`is_html`  tinyint(1) NOT NULL COMMENT '0:text 1:html' ,
	PRIMARY KEY (`id`),
	INDEX `inx_mail_template_001` USING BTREE(`name`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `%DB_PREFIX%order` ADD `order_type`  tinyint(1) NULL DEFAULT 0,ADD `reason`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
CREATE INDEX `order_type` USING BTREE ON `%DB_PREFIX%order` (`order_type`)  ;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seo` (
	`id`  smallint(6) NOT NULL AUTO_INCREMENT ,
	`type`  char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`key`  char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`name`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`title`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`keywords`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`description`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`rewrite`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`title_type`  tinyint(1) NULL DEFAULT 0 ,
	`keywords_type`  tinyint(1) NULL DEFAULT 0 ,
	`description_type`  tinyint(1) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `type` USING BTREE(`type`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `%DB_PREFIX%seo` (`id`, `type`, `key`, `name`, `title`, `keywords`, `description`, `rewrite`, `title_type`, `keywords_type`, `description_type`) VALUES
(1, 'book', 'book_shopping', '逛街首页', '{SEO_TITLE}\r\n{SHORT_NAME}-{GLOBAL_TITLE}\r\n{CATE_NAME}-{GLOBAL_TITLE}\r\n', '{SEO_KEYWORDS}\r\n{GLOBAL_NAME},逛街,网购,购物分享,淘宝网购物,淘宝网女装,衣服搭配', '{SEO_DESCRIPTION}\r\n{DESC}\r\n{GLOBAL_DESCRIPTION}', 'a:4:{s:6:"module";s:4:"book";s:6:"action";s:8:"shopping";s:14:"is_action_type";s:1:"1";s:4:"args";s:0:"";}', 0, 0, 0),
(2, 'book', 'book_cate', '逛街分类页', '{GROUP_NAME}-{SEO_TITLE}\r\n{TAG}-{SEO_TITLE}\r\n{SEO_TITLE}\r\n{GROUP_NAME}-{SHORT_NAME}-{GLOBAL_TITLE}\r\n{TAG}-{SHORT_NAME}-{GLOBAL_TITLE}\r\n{GROUP_NAME}-{CATE_NAME}-{GLOBAL_TITLE}\r\n{TAG}-{CATE_NAME}-{GLOBAL_TITLE}\r\n{SHORT_NAME}-{GLOBAL_TITLE}\r\n{CATE_NAME}-{GLOBAL_TITLE}', '{SEO_KEYWORDS}\r\n{CATE_NAME}, {CATE_NAME}价格, {CATE_NAME}女装, {CATE_NAME}单品推荐, {CATE_NAME}搭配', '{SEO_DESCRIPTION}\r\n欢迎访问{GLOBAL_NAME}{CATE_NAME}频道，这里有淘宝网购物达人们精心挑选的最热新款时尚{CATE_NAME}，发现当季最潮{CATE_NAME}和最佳{CATE_NAME}搭配心得。', 'a:4:{s:6:"module";s:4:"book";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:11:"([a-z0-9]+)";}', 0, 0, 0),
(3, 'note', 'note_all', '分享详细页', '{SEO_TITLE}-{GLOBAL_NAME}\r\n{GOODS_TITLE}-{GLOBAL_NAME}\r\n{TITLE}-{GLOBAL_NAME}\r\n{CONTENT}-{GLOBAL_NAME}', '{SEO_KEYWORDS}\r\n{USER_NAME},{TAGS}\r\n{USER_NAME},{CATE_NAME},{GLOBAL_KEYWORDS}', '{SEO_DESCRIPTION}\r\n{GOODS_ALT}\r\n{PHOTO_ALT}', 'a:4:{s:6:"module";s:4:"note";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:5:"(\\d+)";}', 0, 0, 0),
(4, 'album', 'album_index', '杂志社首页', '杂志社-{GLOBAL_NAME}', '{GLOBAL_NAME},杂志,图片,购物分享,淘宝网购物,专辑,街拍,时尚,美容', '{GLOBAL_NAME}杂志,{GLOBAL_NAME}专辑是风格的小世界，欧美、甜美、森女、朋克，应有尽有！兴趣相投的MM聚焦在这里分享时尚生活，创办属于自己的个性杂志', 'a:4:{s:6:"module";s:5:"album";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(5, 'album', 'album_category', '杂志社分类页', '{SEO_TITLE}\r\n{NAME}-杂志社-{GLOBAL_NAME}', '{SEO_KEYWORDS}\r\n{NAME},{GLOBAL_NAME},杂志,图片,购物分享,淘宝网购物,专辑,街拍,时尚,美容', '{SEO_DESCRIPTION}\r\n{NAME}杂志,{GLOBAL_NAME}专辑是风格的小世界，欧美、甜美、森女、朋克，应有尽有！兴趣相投的MM聚焦在这里分享时尚生活，创办属于自己的个性杂志', 'a:4:{s:6:"module";s:5:"album";s:6:"action";s:8:"category";s:14:"is_action_type";s:1:"1";s:4:"args";s:6:"c(\\d+)";}', 0, 0, 0),
(6, 'album', 'album_show', '杂志社详细页', '{SEO_TITLE}\r\n{TITLE}-{CATE_NAME}-杂志社-{GLOBAL_NAME}\r\n', '{SEO_KEYWORDS}\r\n{TAGS},{CATE_NAME},{GLOBAL_NAME},杂志,图片,购物分享,淘宝网购物,专辑,街拍,时尚,美容', '{SEO_DESCRIPTION}\r\n{CONTENT}\r\n{CATE_NAME}杂志,{GLOBAL_NAME}专辑是风格的小世界，欧美、甜美、森女、朋克，应有尽有！兴趣相投的MM聚焦在这里分享时尚生活，创办属于自己的个性杂志', 'a:4:{s:6:"module";s:5:"album";s:6:"action";s:4:"show";s:14:"is_action_type";s:1:"1";s:4:"args";s:6:"a(\\d+)";}', 0, 0, 0),
(7, 'look', 'look_index', '晒货页', '晒货-{GLOBAL_NAME}', '晒货,{GLOBAL_NAME}晒货,{GLOBAL_NAME}', '欢迎访问{GLOBAL_NAME}晒货频道，看看时尚达人们2012年都喜欢什么宝贝', 'a:4:{s:6:"module";s:4:"look";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(8, 'dapei', 'dapei_index', '搭配页', '搭配-{GLOBAL_NAME}', '搭配,{GLOBAL_NAME}搭配,服饰搭配,服装搭配', '欢迎访问{GLOBAL_NAME}服装搭配频道，时尚达人们教你如何搭配衣服，分享2012年最新时装搭配、冬季女装搭配经验心得', 'a:4:{s:6:"module";s:5:"dapei";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(9, 'group', 'group_index', '小组首页', '小组-{GLOBAL_NAME}', '小组,{GLOBAL_NAME}小组,', '发现、购物、分享、交流，在这里能发起讨论，分享购物乐趣。你也可以创建专属的小组，找到同好、扎堆抱团', 'a:4:{s:6:"module";s:5:"group";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(10, 'group', 'group_detail', '小组详细页', '{SEO_TITLE}\r\n{NAME}-{CATE_NAME}-小组-{GLOBAL_NAME}', '{SEO_KEYWORDS}\r\n{TAGS},{USER_NAME},{CATE_NAME}\r\n{USER_NAME},{CATE_NAME}', '{SEO_DESCRIPTION}\r\n{CONTENT}', 'a:4:{s:6:"module";s:5:"group";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:5:"(\\d+)";}', 0, 0, 0),
(11, 'topic', 'topic_detail', '主题详细页', '{SEO_TITLE}-{GLOBAL_NAME}\r\n{TITLE}-{GLOBAL_NAME}', '{SEO_KEYWORDS}\r\n{USER_NAME},{GROUP_USER_NAME},{GROUP_NAME},{GROUP_TAGS}\r\n{USER_NAME},{GROUP_USER_NAME},{GROUP_NAME}', '{SEO_DESCRIPTION}\r\n{CONTENT}', 'a:4:{s:6:"module";s:5:"topic";s:6:"action";s:6:"detail";s:14:"is_action_type";s:1:"1";s:4:"args";s:5:"(\\d+)";}', 0, 0, 0),
(12, 'daren', 'daren_index', '达人首页', '达人-做最喜欢的自己-{GLOBAL_NAME}', '达人,{GLOBAL_NAME}达人,{GLOBAL_NAME}', '记录{GLOBAL_NAME}达人们的精彩，在这里能看搭配心机，学美容秘笈。你也可以在这里成为最受关注的{GLOBAL_NAME}达人，享受粉丝们的热情追随', 'a:4:{s:6:"module";s:5:"daren";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(13, 'daren', 'daren_cate', '达人分类页', '{SEO_TITLE}\r\n{NAME}达人-{GLOBAL_NAME}', '{SEO_KEYWORDS}\r\n达人,{GLOBAL_NAME}达人,{NAME}达人,{NAME},{GLOBAL_NAME}', '{SEO_DESCRIPTION}\r\n{CONTENT}\r\n{GLOBAL_DESCRIPTION}', 'a:4:{s:6:"module";s:5:"daren";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:5:"(\\d+)";}', 0, 0, 0),
(14, 'shop', 'shop_index', '好店首页', '当红好店–时尚网购店铺推荐-{GLOBAL_NAME}', '当红好店,淘宝店铺,网购大全,皇冠店铺', '欢迎访问{GLOBAL_NAME}好店频道，看看时尚达人们2012年都喜欢逛那些店铺', 'a:4:{s:6:"module";s:4:"shop";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(16, 'shop', 'shop_show', '好店详细页', '{SEO_TITLE}\r\n{SHOP_NAME}-{GLOBAL_NAME}当红好店', '{SEO_KEYWORDS}\r\n{CATE_NAME}当红好店', '{SEO_DESCRIPTION}\r\n欢迎访问{SHOP_TITLE}，时尚达人们2012年都喜欢逛{SHOP_TITLE}', 'a:4:{s:6:"module";s:4:"shop";s:6:"action";s:4:"show";s:14:"is_action_type";s:1:"1";s:4:"args";s:6:"s(\\d+)";}', 0, 0, 0),
(17, 'exchange', 'exchange_index', '试用首页', '试用中心-{GLOBAL_NAME}', '免费,试用,试穿,兑换,{GLOBAL_NAME}', '{GLOBAL_DESCRIPTION}', 'a:4:{s:6:"module";s:8:"exchange";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:0:"";}', 0, 0, 0),
(18, 'exchange', 'exchange_info', '试用详细页', '{SEO_TITLE}\r\n{NAME}-试用中心-{GLOBAL_NAME}', '{SEO_KEYWORDS}\r\n免费,试用,试穿,兑换,{GLOBAL_NAME}', '{SEO_DESCRIPTION}\r\n{GLOBAL_DESCRIPTION}', 'a:4:{s:6:"module";s:8:"exchange";s:6:"action";s:4:"info";s:14:"is_action_type";s:1:"1";s:4:"args";s:5:"(\\d+)";}', 0, 0, 0),
(15, 'shop', 'shop_cate', '好店分类页', '{SEO_TITLE}\r\n{NAME}-{GLOBAL_NAME}当红好店', '{SEO_KEYWORDS}\r\n{NAME},当红好店,淘宝店铺,网购大全,皇冠店铺', '{SEO_DESCRIPTION}\r\n欢迎访问{GLOBAL_NAME}好店频道，时尚达人们2012年都喜欢逛{NAME}店铺', 'a:4:{s:6:"module";s:4:"shop";s:6:"action";s:0:"";s:14:"is_action_type";s:1:"2";s:4:"args";s:6:"c(\\d+)";}', 0, 0, 0);

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%smtp` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`smtp_server`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`smtp_account`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`smtp_password`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`smtp_port`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`smtp_auth`  tinyint(4) NOT NULL ,
	`is_ssl`  tinyint(4) NOT NULL ,
	`batch_limit`  int(11) NOT NULL COMMENT '每次批量发送的数量' ,
	`batch_count`  int(11) NOT NULL ,
	`auto_reset`  tinyint(1) NOT NULL ,
	`status`  tinyint(1) NOT NULL ,
	`from_address`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	PRIMARY KEY (`id`),
	INDEX `id` USING BTREE(`id`)  ,
	INDEX `status` USING BTREE(`status`)  ,
	INDEX `batch_limit` USING BTREE(`batch_limit`)  ,
	INDEX `is_ssl` USING BTREE(`is_ssl`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_color` (
	`share_id`  int(11) NULL DEFAULT NULL ,
	`color_id`  smallint(6) NULL DEFAULT NULL ,
	`uid`  int(11) NULL DEFAULT 0 ,
	INDEX `color_id` USING BTREE(`color_id`)  ,
	INDEX `share_id` USING BTREE(`share_id`)  ,
	INDEX `uid` USING BTREE(`uid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `%DB_PREFIX%share_goods` ADD COLUMN `alt`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',ADD COLUMN `color`  smallint(6) NULL DEFAULT 0;

ALTER TABLE `%DB_PREFIX%share_photo` ADD COLUMN `alt`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '';

ALTER TABLE `%DB_PREFIX%shop` ADD `seo_title` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_keywords` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_description` VARCHAR( 255 ) NOT NULL DEFAULT  '';

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_cates` (
	`id`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`pid`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`type`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'taobao' ,
	`name`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`sort`  smallint(6) NULL DEFAULT 0 ,
	`pids`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	UNIQUE INDEX `id_type_pid` USING BTREE(`type`, `id`, `pid`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shop_cates_related` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`cid`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`sc_id`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`type`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`sort`  smallint(6) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `cids` USING BTREE(`cid`, `sc_id`)  
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `%DB_PREFIX%taobao_share` ADD `commission`  decimal(10,2) NOT NULL DEFAULT 0.00,ADD `desc`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `%DB_PREFIX%taobao_shop` ADD `title`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';

ALTER TABLE `%DB_PREFIX%user` ADD COLUMN `active_sn`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '';
ALTER TABLE `%DB_PREFIX%user_count` ADD `activity`  int(11) NULL DEFAULT 0,ADD `activity_post`  int(11) NULL DEFAULT 0,ADD `vote`  int(11) NULL DEFAULT 0,ADD `vote_post`  int(11) NULL DEFAULT 0,ADD `trial`  int(11) NULL DEFAULT 0,ADD `trial_post`  int(11) NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%vote` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`uid`  int(11) NULL DEFAULT 0 ,
	`share_id`  int(11) NULL DEFAULT 0 ,
	`title`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`num`  int(11) NULL DEFAULT 0 ,
	`users`  int(11) NULL DEFAULT 0 ,
	`multiple`  tinyint(1) NULL DEFAULT 0 ,
	`visibility`  tinyint(1) NULL DEFAULT 0 ,
	`expiration_time`  int(11) NULL DEFAULT 0 ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `users` USING BTREE (`users`)  ,
	INDEX `share_id` USING BTREE(`share_id`)  ,
	INDEX `uid` USING BTREE(`uid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%vote_match` (
	`id`  int(11) NOT NULL ,
	`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	PRIMARY KEY (`id`),
	FULLTEXT INDEX `content` (`content`) 
)
ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%vote_option` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`vid`  int(11) NULL DEFAULT 0 ,
	`title`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
	`num`  int(11) NULL DEFAULT 0 ,
	`sort`  smallint(5) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `vid` USING BTREE(`vid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%vote_post` (
	`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
	`vid`  int(11) NULL DEFAULT NULL ,
	`share_id`  int(11) NULL DEFAULT NULL ,
	`uid`  int(11) NULL DEFAULT NULL ,
	`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `uid`USING BTREE (`uid`)  ,
	INDEX `share_id` USING BTREE(`share_id`)  ,
	INDEX `vid` USING BTREE(`vid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%vote_user` (
	`id`  int(11) NOT NULL AUTO_INCREMENT ,
	`vid`  int(11) NULL DEFAULT 0 ,
	`oid`  int(11) NULL DEFAULT 0 ,
	`uid`  int(11) NULL DEFAULT 0 ,
	`create_time`  int(11) NULL DEFAULT 0 ,
	PRIMARY KEY (`id`),
	INDEX `vid`USING BTREE(`vid`)  ,
	INDEX `oid` USING BTREE(`oid`)  ,
	INDEX `uid` USING BTREE(`uid`)  
)
ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `%DB_PREFIX%sys_conf` (`name`, `val`, `status`, `sort`, `list_type`, `val_arr`, `group_id`, `is_show`, `is_js`) VALUES
('BIND_IS_MAIL_ACTIVATE', '0', 1, 8, 1, '', 6, 0, 0),
('CLOSE_REGISTER_DESC', '关闭注册', 1, 8, 0, '', 6, 0, 0),
('IS_GOODS_DELIST', '0', 1, 10, 1, '0,1', 3, 0, 0),
('IS_MAIL_ACTIVATE', '0', 1, 8, 1, '0,1', 6, 0, 0),
('IS_OPEN_REGISTER', '1', 1, 8, 2, '0,1', 6, 0, 0),
('IS_SHOW_FOLLOW', '1', 1, 10, 0, '', 6, 0, 0),
('GOODS_BUY_SCORE_RATE', '1', 1, 10, 0, '', 10, 0, 0),
('GOODS_BUY_SCORE_TYPE', '1', 1, 10, 0, '', 10, 0, 0),
('SHARE_IMAGE_SAVE_TYPE', '0', 1, 10, 0, '', 3, 0, 0);

UPDATE `%DB_PREFIX%sharegoods_module` SET `api_data` = 'a:5:{s:3:"uin";s:0:"";s:10:"appoauthid";s:0:"";s:11:"appoauthkey";s:0:"";s:11:"accesstoken";s:0:"";s:6:"userid";s:0:"";}' WHERE `class` = 'paipai';

TRUNCATE TABLE `%DB_PREFIX%role_nav`;
TRUNCATE TABLE `%DB_PREFIX%role_access`;
TRUNCATE TABLE `%DB_PREFIX%role_node`;

INSERT INTO `%DB_PREFIX%role_nav` (`id`, `name`, `status`, `sort`) VALUES
(1, '首页', 1, 1),
(2, '分享', 1, 2),
(3, '分享相关', 1, 3),
(4, '会员', 1, 4),
(5, '佣金', 1, 5),
(6, '前台', 1, 6),
(7, '权限', 1, 7),
(8, '数据库', 1, 8),
(9, '系统', 1, 9),
(10, '手机', 1, 10);

INSERT INTO `%DB_PREFIX%role_node` (`id`, `action`, `action_name`, `status`, `module`, `module_name`, `nav_id`, `sort`, `auth_type`, `is_show`, `log_type`, `is_log`) VALUES
(1, '', '', 1, 'Index', '站点信息', 1, 100, 1, 0, 0, 0),
(2, 'main', '站点信息', 1, 'Index', '站点信息', 1, 100, 0, 1, 0, 0),
(3, '', '', 1, 'SysConf', '系统管理', 9, 100, 1, 0, 0, 0),
(4, 'index', '系统设置', 1, 'SysConf', '系统管理', 9, 100, 0, 1, 0, 0),
(5, 'update', '更新设置', 1, 'SysConf', '系统管理', 9, 100, 0, 0, 1, 0),
(6, '', '', 1, 'SharegoodsModule', '商品接口管理', 9, 100, 1, 0, 0, 0),
(7, 'index', '接口列表', 1, 'SharegoodsModule', '商品接口管理', 9, 100, 0, 1, 0, 0),
(8, 'update', '更新接口', 1, 'SharegoodsModule', '商品接口管理', 9, 100, 0, 0, 1, 0),
(9, '', '', 1, 'LoginModule', '同步登陆管理', 9, 100, 1, 0, 0, 0),
(10, 'index', '模块列表', 1, 'LoginModule', '同步登陆管理', 9, 100, 0, 1, 0, 0),
(11, 'update', '更新模块', 1, 'LoginModule', '同步登陆管理', 9, 100, 0, 0, 1, 0),
(12, '', '', 1, 'ImageServers', '图片服务器管理', 9, 100, 1, 0, 0, 0),
(13, 'index', '服务器列表', 1, 'ImageServers', '图片服务器管理', 9, 100, 0, 1, 0, 0),
(14, 'add', '添加服务器', 1, 'ImageServers', '图片服务器管理', 9, 100, 0, 1, 1, 0),
(15, 'update', '更新服务器', 1, 'ImageServers', '图片服务器管理', 9, 100, 0, 0, 1, 0),
(16, '', '', 1, 'UpYun', '又拍云存储', 9, 100, 1, 0, 0, 0),
(17, 'index', '又拍云管理', 1, 'UpYun', '又拍云存储', 9, 100, 0, 1, 0, 0),
(18, 'update', '更新设置', 1, 'UpYun', '又拍云存储', 9, 100, 0, 0, 1, 0),
(19, '', '', 1, 'Seo', 'SEO管理', 9, 100, 1, 0, 0, 0),
(20, 'index', 'SEO设置', 1, 'Seo', 'SEO管理', 9, 100, 0, 1, 0, 0),
(21, 'update', '更新设置', 1, 'Seo', 'SEO管理', 9, 100, 0, 0, 1, 0),
(22, 'down', '下载重写规则', 1, 'Seo', 'SEO管理', 9, 100, 0, 0, 0, 0),
(23, '', '', 1, 'Anchor', '锚词库管理', 9, 100, 1, 0, 0, 0),
(24, 'index', '词库列表', 1, 'Anchor', '锚词库管理', 9, 100, 0, 1, 0, 0),
(25, 'add', '添加锚词', 1, 'Anchor', '锚词库管理', 9, 100, 0, 1, 1, 0),
(26, 'update', '更新锚词', 1, 'Anchor', '锚词库管理', 9, 100, 0, 0, 1, 0),
(27, 'remove', '删除锚词', 1, 'Anchor', '锚词库管理', 9, 100, 0, 0, 1, 0),
(28, 'import', '导入词库', 1, 'Anchor', '锚词库管理', 9, 100, 0, 0, 1, 0),
(29, 'export', '导出词库', 1, 'Anchor', '锚词库管理', 9, 100, 0, 0, 1, 0),
(30, '', '', 1, 'Smtp', '邮件服务器管理', 9, 100, 1, 0, 0, 0),
(31, 'index', '服务器列表', 1, 'Smtp', '邮件服务器管理', 9, 100, 0, 1, 0, 0),
(32, 'add', '添加服务器', 1, 'Smtp', '邮件服务器管理', 9, 100, 0, 1, 1, 0),
(33, 'update', '更新服务器', 1, 'Smtp', '邮件服务器管理', 9, 100, 0, 0, 1, 0),
(34, 'remove', '删除服务器', 1, 'Smtp', '邮件服务器管理', 9, 100, 0, 0, 1, 0),
(35, '', '', 1, 'Cache', '缓存管理', 9, 100, 1, 0, 0, 0),
(36, 'system', '清除系统缓存', 1, 'Cache', '缓存管理', 9, 100, 0, 1, 1, 0),
(37, 'custom', '清除程序缓存', 1, 'Cache', '缓存管理', 9, 100, 0, 1, 1, 0),
(38, '', '', 1, 'TempFile', '临时文件管理', 9, 100, 1, 0, 0, 0),
(39, 'index', '临时文件列表', 1, 'TempFile', '临时文件管理', 9, 100, 0, 1, 0, 0),
(40, 'clear', '清除临时文件', 1, 'TempFile', '临时文件管理', 9, 100, 0, 0, 0, 0),
(41, '', '', 1, 'AdminLog', '操作日志管理', 9, 100, 1, 0, 0, 0),
(42, 'index', '操作日志列表', 1, 'AdminLog', '操作日志管理', 9, 100, 0, 1, 0, 0),
(43, 'remove', '删除操作日志', 1, 'AdminLog', '操作日志管理', 9, 100, 0, 0, 0, 0),
(44, 'clear', '清除操作日志', 1, 'AdminLog', '操作日志管理', 9, 100, 0, 0, 0, 0),
(45, '', '', 1, 'Region', '城市管理', 9, 100, 1, 0, 0, 0),
(46, 'index', '城市列表', 1, 'Region', '城市管理', 9, 100, 0, 1, 0, 0),
(47, 'add', '添加城市', 1, 'Region', '城市管理', 9, 100, 0, 1, 1, 0),
(48, 'update', '更新城市', 1, 'Region', '城市管理', 9, 100, 0, 0, 1, 0),
(49, 'remove', '删除城市', 1, 'Region', '城市管理', 9, 100, 0, 0, 1, 0),
(50, '', '', 1, 'WordType', '敏感词分类管理', 9, 100, 1, 0, 0, 0),
(51, 'index', '分类列表', 1, 'WordType', '敏感词分类管理', 9, 100, 0, 1, 0, 0),
(52, 'add', '添加分类', 1, 'WordType', '敏感词分类管理', 9, 100, 0, 1, 1, 0),
(53, 'update', '更新分类', 1, 'WordType', '敏感词分类管理', 9, 100, 0, 0, 1, 0),
(54, 'remove', '删除分类', 1, 'WordType', '敏感词分类管理', 9, 100, 0, 0, 1, 0),
(55, '', '', 1, 'Word', '敏感词管理', 9, 100, 1, 0, 0, 0),
(56, 'index', '敏感词列表', 1, 'Word', '敏感词管理', 9, 100, 0, 1, 0, 0),
(57, 'add', '添加敏感词', 1, 'Word', '敏感词管理', 9, 100, 0, 1, 1, 0),
(58, 'update', '更新敏感词', 1, 'Word', '敏感词管理', 9, 100, 0, 0, 1, 0),
(59, 'remove', '删除敏感词', 1, 'Word', '敏感词管理', 9, 100, 0, 0, 1, 0),
(60, 'import', '导入敏感词', 1, 'Word', '敏感词管理', 9, 100, 0, 0, 1, 0),
(61, 'export', '导出敏感词', 1, 'Word', '敏感词管理', 9, 100, 0, 0, 1, 0),
(62, '', '', 1, 'DataBase', '数据库操作', 8, 100, 1, 0, 0, 0),
(63, 'index', '数据库备份', 1, 'DataBase', '数据库操作', 8, 100, 0, 1, 0, 0),
(64, 'dump', '备份操作', 1, 'DataBase', '数据库操作', 8, 100, 0, 0, 1, 0),
(65, 'delete', '删除操作', 1, 'DataBase', '数据库操作', 8, 100, 0, 0, 1, 0),
(66, 'restore', '恢复操作', 1, 'DataBase', '数据库操作', 8, 100, 0, 0, 1, 0),
(67, '', '', 1, 'Sql', 'SQL操作', 8, 100, 1, 0, 0, 0),
(68, 'index', 'SQL操作', 1, 'Sql', 'SQL操作', 8, 100, 0, 1, 0, 0),
(69, 'execute', '执行SQL', 1, 'Sql', 'SQL操作', 8, 100, 0, 0, 1, 0),
(70, '', '', 1, 'Admin', '管理员管理', 7, 100, 1, 0, 0, 0),
(71, 'index', '管理员列表', 1, 'Admin', '管理员管理', 7, 100, 0, 1, 0, 0),
(72, 'add', '添加管理员', 1, 'Admin', '管理员管理', 7, 100, 0, 1, 1, 0),
(73, 'update', '更新管理员', 1, 'Admin', '管理员管理', 7, 100, 0, 0, 1, 0),
(74, 'remove', '删除管理员', 1, 'Admin', '管理员管理', 7, 100, 0, 0, 1, 0),
(75, '', '', 1, 'Role', '权限组管理', 7, 100, 1, 0, 0, 0),
(76, 'index', '角色列表', 1, 'Role', '权限组管理', 7, 100, 0, 1, 0, 0),
(77, 'add', '添加角色', 1, 'Role', '权限组管理', 7, 100, 0, 1, 1, 0),
(78, 'update', '更新角色', 1, 'Role', '权限组管理', 7, 100, 0, 0, 1, 0),
(79, 'remove', '删除角色', 1, 'Role', '权限组管理', 7, 100, 0, 0, 1, 0),
(80, '', '', 1, 'RoleNode', '权限节点管理', 7, 100, 1, 0, 0, 0),
(81, 'index', '节点列表', 1, 'RoleNode', '权限节点管理', 7, 100, 0, 1, 0, 0),
(82, 'add', '添加节点', 1, 'RoleNode', '权限节点管理', 7, 100, 0, 1, 1, 0),
(83, 'update', '更新节点', 1, 'RoleNode', '权限节点管理', 7, 100, 0, 0, 1, 0),
(84, 'remove', '删除节点', 1, 'RoleNode', '权限节点管理', 7, 100, 0, 0, 1, 0),
(85, '', '', 1, 'RoleNav', '后台导航菜单管理', 7, 100, 1, 0, 0, 0),
(86, 'index', '菜单列表', 1, 'RoleNav', '后台导航菜单管理', 7, 100, 0, 1, 0, 0),
(87, 'add', '添加菜单', 1, 'RoleNav', '后台导航菜单管理', 7, 100, 0, 1, 1, 0),
(88, 'update', '更新菜单', 1, 'RoleNav', '后台导航菜单管理', 7, 100, 0, 0, 1, 0),
(89, 'remove', '删除菜单', 1, 'RoleNav', '后台导航菜单管理', 7, 100, 0, 0, 1, 0),
(90, '', '', 1, 'NavCategory', '前台菜单分类管理', 6, 100, 1, 0, 0, 0),
(91, 'index', '分类列表', 1, 'NavCategory', '前台菜单分类管理', 6, 100, 0, 1, 0, 0),
(92, 'add', '添加分类', 1, 'NavCategory', '前台菜单分类管理', 6, 100, 0, 1, 1, 0),
(93, 'update', '更新分类', 1, 'NavCategory', '前台菜单分类管理', 6, 100, 0, 0, 1, 0),
(94, 'remove', '删除分类', 1, 'NavCategory', '前台菜单分类管理', 6, 100, 0, 0, 1, 0),
(95, '', '', 1, 'Nav', '前台菜单管理', 6, 100, 1, 0, 0, 0),
(96, 'index', '菜单列表', 1, 'Nav', '前台菜单管理', 6, 100, 0, 1, 0, 0),
(97, 'add', '添加菜单', 1, 'Nav', '前台菜单管理', 6, 100, 0, 1, 1, 0),
(98, 'update', '更新菜单', 1, 'Nav', '前台菜单管理', 6, 100, 0, 0, 1, 0),
(99, 'remove', '删除菜单', 1, 'Nav', '前台菜单管理', 6, 100, 0, 0, 1, 0),
(100, '', '', 1, 'FriendLink', '友情链接管理', 6, 100, 1, 0, 0, 0),
(101, 'index', '链接列表', 1, 'FriendLink', '友情链接管理', 6, 100, 0, 1, 0, 0),
(102, 'add', '添加链接', 1, 'FriendLink', '友情链接管理', 6, 100, 0, 1, 1, 0),
(103, 'update', '更新链接', 1, 'FriendLink', '友情链接管理', 6, 100, 0, 0, 1, 0),
(104, 'remove', '删除链接', 1, 'FriendLink', '友情链接管理', 6, 100, 0, 0, 1, 0),
(105, '', '', 1, 'AdvPosition', '广告位管理', 6, 100, 1, 0, 0, 0),
(106, 'index', '广告位列表', 1, 'AdvPosition', '广告位管理', 6, 100, 0, 1, 0, 0),
(107, 'add', '添加广告位', 1, 'AdvPosition', '广告位管理', 6, 100, 0, 1, 1, 0),
(108, 'update', '更新广告位', 1, 'AdvPosition', '广告位管理', 6, 100, 0, 0, 1, 0),
(109, 'remove', '删除广告位', 1, 'AdvPosition', '广告位管理', 6, 100, 0, 0, 1, 0),
(110, '', '', 1, 'Adv', '广告管理', 6, 100, 1, 0, 0, 0),
(111, 'index', '广告列表', 1, 'Adv', '广告管理', 6, 100, 0, 1, 0, 0),
(112, 'add', '添加广告', 1, 'Adv', '广告管理', 6, 100, 0, 1, 1, 0),
(113, 'update', '更新广告', 1, 'Adv', '广告管理', 6, 100, 0, 0, 1, 0),
(114, 'remove', '删除广告', 1, 'Adv', '广告管理', 6, 100, 0, 0, 1, 0),
(115, '', '', 1, 'AdvLayout', '广告布局管理', 6, 100, 1, 0, 0, 0),
(116, 'index', '布局列表', 1, 'AdvLayout', '广告布局管理', 6, 100, 0, 1, 0, 0),
(117, 'add', '添加布局', 1, 'AdvLayout', '广告布局管理', 6, 100, 0, 1, 1, 0),
(118, 'update', '更新布局', 1, 'AdvLayout', '广告布局管理', 6, 100, 0, 0, 1, 0),
(119, 'remove', '删除布局', 1, 'AdvLayout', '广告布局管理', 6, 100, 0, 0, 1, 0),
(120, '', '', 1, 'CommissionSetting', '佣金配置', 5, 100, 1, 0, 0, 0),
(121, 'index', '佣金设置', 1, 'CommissionSetting', '佣金配置', 5, 100, 0, 1, 0, 0),
(122, 'update', '更新设置', 1, 'CommissionSetting', '佣金配置', 5, 100, 0, 0, 1, 0),
(123, '', '', 1, 'GoodsOrder', '会员佣金管理', 5, 100, 1, 0, 0, 0),
(124, 'index', '佣金列表', 1, 'GoodsOrder', '会员佣金管理', 5, 100, 0, 1, 0, 0),
(125, 'update', '更新佣金', 1, 'GoodsOrder', '会员佣金管理', 5, 100, 0, 0, 1, 0),
(126, 'remove', '删除佣金', 1, 'GoodsOrder', '会员佣金管理', 5, 100, 0, 0, 1, 0),
(127, '', '', 1, 'TaobaokeReport', '淘宝客报表', 5, 100, 1, 0, 0, 0),
(128, 'index', '报表记录', 1, 'TaobaokeReport', '淘宝客报表', 5, 100, 0, 1, 0, 0),
(129, 'remove', '删除记录', 1, 'TaobaokeReport', '淘宝客报表', 5, 100, 0, 0, 1, 0),
(130, '', '', 1, 'UserSetting', '会员配置管理', 4, 100, 1, 0, 0, 0),
(131, 'index', '设置配置', 1, 'UserSetting', '会员配置管理', 4, 100, 0, 1, 0, 0),
(132, 'update', '更新配置', 1, 'UserSetting', '会员配置管理', 4, 100, 0, 0, 1, 0),
(133, '', '', 1, 'Integrate', '会员整合', 4, 100, 1, 0, 0, 0),
(134, 'index', '会员整合', 1, 'Integrate', '会员整合', 4, 100, 0, 1, 0, 0),
(135, '', '', 1, 'User', '会员管理', 4, 100, 1, 0, 0, 0),
(136, 'index', '会员列表', 1, 'User', '会员管理', 4, 100, 0, 1, 0, 0),
(137, 'add', '添加会员', 1, 'User', '会员管理', 4, 100, 0, 1, 1, 0),
(138, 'update', '更新会员', 1, 'User', '会员管理', 4, 100, 0, 0, 1, 0),
(139, 'remove', '删除会员', 1, 'User', '会员管理', 4, 100, 0, 0, 1, 0),
(140, '', '', 1, 'UserGroup', '会员组管理', 4, 100, 1, 0, 0, 0),
(141, 'index', '会员组列表', 1, 'UserGroup', '会员组管理', 4, 100, 0, 1, 0, 0),
(142, 'add', '添加会员组', 1, 'UserGroup', '会员组管理', 4, 100, 0, 1, 1, 0),
(143, 'update', '更新会员组', 1, 'UserGroup', '会员组管理', 4, 100, 0, 0, 1, 0),
(144, 'remove', '删除会员组', 1, 'UserGroup', '会员组管理', 4, 100, 0, 0, 1, 0),
(145, '', '', 1, 'UserDaren', '达人管理', 4, 100, 1, 0, 0, 0),
(146, 'index', '达人列表', 1, 'UserDaren', '达人管理', 4, 100, 0, 1, 0, 0),
(147, 'add', '添加达人', 1, 'UserDaren', '达人管理', 4, 100, 0, 1, 1, 0),
(148, 'update', '更新达人', 1, 'UserDaren', '达人管理', 4, 100, 0, 0, 1, 0),
(149, 'remove', '删除达人', 1, 'UserDaren', '达人管理', 4, 100, 0, 0, 1, 0),
(150, '', '', 1, 'DarenCate', '达人分类管理', 4, 100, 1, 0, 0, 0),
(151, 'index', '分类列表', 1, 'DarenCate', '达人分类管理', 4, 100, 0, 1, 0, 0),
(152, 'add', '添加分类', 1, 'DarenCate', '达人分类管理', 4, 100, 0, 1, 1, 0),
(153, 'update', '更新分类', 1, 'DarenCate', '达人分类管理', 4, 100, 0, 0, 1, 0),
(154, 'remove', '删除分类', 1, 'DarenCate', '达人分类管理', 4, 100, 0, 0, 1, 0),
(155, '', '', 1, 'UserAuctionLog', '会员提现', 4, 100, 1, 0, 0, 0),
(156, 'index', '提现列表', 1, 'UserAuctionLog', '会员提现', 4, 100, 0, 1, 0, 0),
(157, 'update', '更新提现', 1, 'UserAuctionLog', '会员提现', 4, 100, 0, 0, 1, 0),
(158, 'remove', '删除提现', 1, 'UserAuctionLog', '会员提现', 4, 100, 0, 0, 1, 0),
(159, '', '', 1, 'UserScoreLog', '会员积分日志', 4, 100, 1, 0, 0, 0),
(160, 'index', '日志列表', 1, 'UserScoreLog', '会员积分日志', 4, 100, 0, 1, 0, 0),
(161, 'remove', '删除日志', 1, 'UserScoreLog', '会员积分日志', 4, 100, 0, 0, 1, 0),
(162, '', '', 1, 'Referrals', '会员邀请日志', 4, 100, 1, 0, 0, 0),
(163, 'index', '日志列表', 1, 'Referrals', '会员邀请日志', 4, 100, 0, 1, 0, 0),
(164, 'update', '更新日志', 1, 'Referrals', '会员邀请日志', 4, 100, 0, 0, 1, 0),
(165, 'remove', '删除日志', 1, 'Referrals', '会员邀请日志', 4, 100, 0, 0, 1, 0),
(166, '', '', 1, 'Medal', '会员勋章', 4, 100, 1, 0, 0, 0),
(167, 'index', '勋章列表', 1, 'Medal', '会员勋章', 4, 100, 0, 1, 0, 0),
(168, 'add', '添加勋章', 1, 'Medal', '会员勋章', 4, 100, 0, 1, 1, 0),
(169, 'user', '勋章会员', 1, 'Medal', '会员勋章', 4, 100, 0, 1, 1, 0),
(170, 'check', '勋章审核', 1, 'Medal', '会员勋章', 4, 100, 0, 1, 1, 0),
(171, '', '', 1, 'UserMsg', '会员信件管理', 4, 100, 1, 0, 0, 0),
(172, 'index', '会员信件列表', 1, 'UserMsg', '会员信件管理', 4, 100, 0, 1, 0, 0),
(173, 'groupSend', '发送系统信件', 1, 'UserMsg', '会员信件管理', 4, 100, 0, 1, 1, 0),
(174, 'groupList', '系统信件列表', 1, 'UserMsg', '会员信件管理', 4, 100, 0, 1, 0, 0),
(175, '', '', 1, 'MailRssCategory', '邮件订阅分类管理', 4, 100, 1, 0, 0, 0),
(176, 'index', '分类列表', 1, 'MailRssCategory', '邮件订阅分类管理', 4, 100, 0, 1, 0, 0),
(177, 'add', '添加分类', 1, 'MailRssCategory', '邮件订阅分类管理', 4, 100, 0, 1, 1, 0),
(178, 'update', '更新分类', 1, 'MailRssCategory', '邮件订阅分类管理', 4, 100, 0, 0, 1, 0),
(179, 'remove', '删除分类', 1, 'MailRssCategory', '邮件订阅分类管理', 4, 100, 0, 0, 1, 0),
(180, '', '', 1, 'MailRssContent', '邮件订阅内容管理', 4, 100, 1, 0, 0, 0),
(181, 'index', '内容列表', 1, 'MailRssContent', '邮件订阅内容管理', 4, 100, 0, 1, 0, 0),
(182, 'add', '添加内容', 1, 'MailRssContent', '邮件订阅内容管理', 4, 100, 0, 1, 1, 0),
(183, 'update', '更新内容', 1, 'MailRssContent', '邮件订阅内容管理', 4, 100, 0, 0, 1, 0),
(184, 'remove', '删除内容', 1, 'MailRssContent', '邮件订阅内容管理', 4, 100, 0, 0, 1, 0),
(185, '', '', 1, 'AlbumSetting', '杂志社配置管理', 3, 100, 1, 0, 0, 0),
(186, 'index', '设置配置', 1, 'AlbumSetting', '杂志社配置管理', 3, 100, 0, 1, 0, 0),
(187, 'update', '更新配置', 1, 'AlbumSetting', '杂志社配置管理', 3, 100, 0, 0, 1, 0),
(188, '', '', 1, 'AlbumCategory', '杂志社分类管理', 3, 100, 1, 0, 0, 0),
(189, 'index', '分类列表', 1, 'AlbumCategory', '杂志社分类管理', 3, 100, 0, 1, 0, 0),
(190, 'add', '添加分类', 1, 'AlbumCategory', '杂志社分类管理', 3, 100, 0, 1, 1, 0),
(191, 'update', '更新分类', 1, 'AlbumCategory', '杂志社分类管理', 3, 100, 0, 0, 1, 0),
(192, 'remove', '删除分类', 1, 'AlbumCategory', '杂志社分类管理', 3, 100, 0, 0, 1, 0),
(193, '', '', 1, 'Album', '杂志社管理', 3, 100, 1, 0, 0, 0),
(194, 'index', '杂志社列表', 1, 'Album', '杂志社管理', 3, 100, 0, 1, 0, 0),
(195, 'update', '更新杂志社', 1, 'Album', '杂志社管理', 3, 100, 0, 0, 1, 0),
(196, 'remove', '删除杂志社', 1, 'Album', '杂志社管理', 3, 100, 0, 0, 1, 0),
(197, '', '', 1, 'GroupSetting', '小组设置', 3, 100, 1, 0, 0, 0),
(198, 'index', '小组配置', 1, 'GroupSetting', '小组设置', 3, 100, 0, 1, 0, 0),
(199, 'update', '更新配置', 1, 'GroupSetting', '小组设置', 3, 100, 0, 0, 1, 0),
(200, '', '', 1, 'Forum', '小组管理', 3, 100, 1, 0, 0, 0),
(201, 'index', '小组列表', 1, 'Forum', '小组管理', 3, 100, 0, 1, 0, 0),
(202, 'add', '添加小组', 1, 'Forum', '小组管理', 3, 100, 0, 1, 1, 0),
(203, 'check', '审核小组', 1, 'Forum', '小组管理', 3, 100, 0, 1, 1, 0),
(204, 'showUpdate', '更新列表', 1, 'Forum', '小组管理', 3, 100, 0, 1, 1, 0),
(205, 'update', '更新小组', 1, 'Forum', '小组管理', 3, 100, 0, 0, 1, 0),
(206, 'remove', '删除小组', 1, 'Forum', '小组管理', 3, 100, 0, 0, 1, 0),
(207, '', '', 1, 'ForumCategory', '小组分类管理', 3, 100, 1, 0, 0, 0),
(208, 'index', '分类列表', 1, 'ForumCategory', '小组分类管理', 3, 100, 0, 1, 0, 0),
(209, 'add', '添加分类', 1, 'ForumCategory', '小组分类管理', 3, 100, 0, 1, 1, 0),
(210, 'update', '更新分类', 1, 'ForumCategory', '小组分类管理', 3, 100, 0, 0, 1, 0),
(211, 'remove', '删除分类', 1, 'ForumCategory', '小组分类管理', 3, 100, 0, 0, 1, 0),
(212, '', '', 1, 'ForumThread', '小组主题管理', 3, 100, 1, 0, 0, 0),
(213, 'index', '主题列表', 1, 'ForumThread', '小组主题管理', 3, 100, 0, 1, 0, 0),
(214, 'update', '更新主题', 1, 'ForumThread', '小组主题管理', 3, 100, 0, 0, 1, 0),
(215, 'remove', '删除主题', 1, 'ForumThread', '小组主题管理', 3, 100, 0, 0, 1, 0),
(216, '', '', 1, 'ForumPost', '小组主题回复管理', 3, 100, 1, 0, 0, 0),
(217, 'update', '更新回复', 1, 'ForumPost', '小组主题回复管理', 3, 100, 0, 0, 1, 0),
(218, 'remove', '删除回复', 1, 'ForumPost', '小组主题回复管理', 3, 100, 0, 0, 1, 0),
(219, '', '', 1, 'ExchangeGoods', '试用商品管理', 3, 100, 1, 0, 0, 0),
(220, 'index', '商品列表', 1, 'ExchangeGoods', '试用商品管理', 3, 100, 0, 1, 0, 0),
(221, 'add', '添加商品', 1, 'ExchangeGoods', '试用商品管理', 3, 100, 0, 1, 1, 0),
(222, 'update', '更新商品', 1, 'ExchangeGoods', '试用商品管理', 3, 100, 0, 0, 1, 0),
(223, 'remove', '删除商品', 1, 'ExchangeGoods', '试用商品管理', 3, 100, 0, 0, 1, 0),
(224, '', '', 1, 'Order', '试用申请/订单管理', 3, 100, 1, 0, 0, 0),
(225, 'index', '订单列表', 1, 'Order', '试用申请/订单管理', 3, 100, 0, 1, 0, 0),
(226, 'update', '更新订单', 1, 'Order', '试用申请/订单管理', 3, 100, 0, 0, 1, 0),
(227, 'remove', '删除订单', 1, 'Order', '试用申请/订单管理', 3, 100, 0, 0, 1, 0),
(228, '', '', 1, 'Activity', '活动管理', 3, 100, 1, 0, 0, 0),
(229, 'index', '活动列表', 1, 'Activity', '活动管理', 3, 100, 0, 1, 0, 0),
(230, 'update', '更新活动', 1, 'Activity', '活动管理', 3, 100, 0, 0, 1, 0),
(231, 'remove', '删除活动', 1, 'Activity', '活动管理', 3, 100, 0, 0, 1, 0),
(232, '', '', 1, 'ActivityCate', '活动分类管理', 3, 100, 1, 0, 0, 0),
(233, 'index', '分类列表', 1, 'ActivityCate', '活动分类管理', 3, 100, 0, 1, 0, 0),
(234, 'add', '添加分类', 1, 'ActivityCate', '活动分类管理', 3, 100, 0, 1, 1, 0),
(235, 'update', '更新分类', 1, 'ActivityCate', '活动分类管理', 3, 100, 0, 0, 1, 0),
(236, 'remove', '删除分类', 1, 'ActivityCate', '活动分类管理', 3, 100, 0, 0, 1, 0),
(237, '', '', 1, 'ActivityPost', '活动回复管理', 3, 100, 1, 0, 0, 0),
(238, 'update', '更新回复', 1, 'ActivityPost', '活动回复管理', 3, 100, 0, 0, 1, 0),
(239, 'remove', '删除回复', 1, 'ActivityPost', '活动回复管理', 3, 100, 0, 0, 1, 0),
(240, '', '', 1, 'Vote', '投票管理', 3, 100, 1, 0, 0, 0),
(241, 'index', '投票列表', 1, 'Vote', '投票管理', 3, 100, 0, 1, 0, 0),
(242, 'update', '更新投票', 1, 'Vote', '投票管理', 3, 100, 0, 0, 1, 0),
(243, 'remove', '删除投票', 1, 'Vote', '投票管理', 3, 100, 0, 0, 1, 0),
(244, '', '', 1, 'VotePost', '投票回复管理', 3, 100, 1, 0, 0, 0),
(245, 'update', '更新回复', 1, 'VotePost', '投票回复管理', 3, 100, 0, 0, 1, 0),
(246, 'remove', '删除回复', 1, 'VotePost', '投票回复管理', 3, 100, 0, 0, 1, 0),
(247, '', '', 1, 'Event', '话题管理', 3, 100, 1, 0, 0, 0),
(248, 'index', '话题列表', 1, 'Event', '话题管理', 3, 100, 0, 1, 0, 0),
(249, 'update', '更新话题', 1, 'Event', '话题管理', 3, 100, 0, 0, 1, 0),
(250, 'remove', '删除话题', 1, 'Event', '话题管理', 3, 100, 0, 0, 1, 0),
(251, '', '', 1, 'EventShare', '话题回复管理', 3, 100, 1, 0, 0, 0),
(252, 'index', '话题回复列表', 1, 'EventShare', '话题回复管理', 3, 100, 0, 0, 0, 0),
(253, 'remove', '删除话题回复', 1, 'EventShare', '话题回复管理', 3, 100, 0, 0, 1, 0),
(254, '', '', 1, 'ShareSetting', '分享配置管理', 2, 100, 1, 0, 0, 0),
(255, 'index', '分享配置', 1, 'ShareSetting', '分享配置管理', 2, 100, 0, 1, 0, 0),
(256, 'update', '更新配置', 1, 'ShareSetting', '分享配置管理', 2, 100, 0, 0, 1, 0),
(257, '', '', 1, 'Share', '分享管理', 2, 100, 1, 0, 0, 0),
(258, 'image', '有图分享', 1, 'Share', '分享管理', 2, 100, 0, 1, 0, 0),
(259, 'dapei', '搭配分享', 1, 'Share', '分享管理', 2, 100, 0, 1, 0, 0),
(260, 'look', '晒货分享', 1, 'Share', '分享管理', 2, 100, 0, 1, 0, 0),
(261, 'text', '文字分享', 1, 'Share', '分享管理', 2, 100, 0, 1, 0, 0),
(262, 'check', '待审核新分享', 1, 'Share', '分享管理', 2, 100, 0, 1, 1, 0),
(263, 'cancel', '取消审核分享', 1, 'Share', '分享管理', 2, 100, 0, 1, 1, 0),
(264, 'update', '更新分享', 1, 'Share', '分享管理', 2, 100, 0, 0, 1, 0),
(265, 'remove', '删除分享', 1, 'Share', '分享管理', 2, 100, 0, 0, 1, 0),
(266, '', '', 1, 'ShareComment', '分享评论管理', 2, 100, 1, 1, 0, 0),
(267, 'index', '评论列表', 1, 'ShareComment', '分享评论管理', 2, 100, 0, 1, 0, 0),
(268, 'update', '更新评论', 1, 'ShareComment', '分享评论管理', 2, 100, 0, 0, 1, 0),
(269, 'remove', '删除评论', 1, 'ShareComment', '分享评论管理', 2, 100, 0, 0, 1, 0),
(270, '', '', 1, 'Goods', '商品管理', 2, 100, 1, 0, 0, 0),
(271, 'index', '商品列表', 1, 'Goods', '商品管理', 2, 100, 0, 1, 0, 0),
(272, 'check', '待审核商品', 1, 'Goods', '商品管理', 2, 100, 0, 1, 1, 0),
(273, 'disables', '禁止商品', 1, 'Goods', '商品管理', 2, 100, 0, 1, 1, 0),
(274, 'update', '更新商品', 1, 'Goods', '商品管理', 2, 100, 0, 0, 1, 0),
(275, 'remove', '删除商品', 1, 'Goods', '商品管理', 2, 100, 0, 0, 1, 0),
(276, '', '', 1, 'Shop', '店铺管理', 2, 100, 1, 0, 0, 0),
(277, 'index', '店铺列表', 1, 'Shop', '店铺管理', 2, 100, 0, 1, 0, 0),
(278, 'check', '待审核店铺', 1, 'Shop', '店铺管理', 2, 100, 0, 1, 1, 0),
(279, 'disables', '禁止店铺', 1, 'Shop', '店铺管理', 2, 100, 0, 1, 1, 0),
(280, 'update', '更新店铺', 1, 'Shop', '店铺管理', 2, 100, 0, 0, 1, 0),
(281, 'remove', '删除店铺', 1, 'Shop', '店铺管理', 2, 100, 0, 0, 1, 0),
(282, '', '', 1, 'GoodsCategory', '分享分类管理', 2, 100, 1, 0, 0, 0),
(283, 'index', '分类列表', 1, 'GoodsCategory', '分享分类管理', 2, 100, 0, 1, 0, 0),
(284, 'add', '添加分类', 1, 'GoodsCategory', '分享分类管理', 2, 100, 0, 1, 1, 0),
(285, 'update', '更新分类', 1, 'GoodsCategory', '分享分类管理', 2, 100, 0, 0, 1, 0),
(286, 'remove', '删除分类', 1, 'GoodsCategory', '分享分类管理', 2, 100, 0, 0, 1, 0),
(287, '', '', 1, 'GoodsCategoryTags', '分享分类关联标签管理', 2, 100, 1, 0, 0, 0),
(288, 'index', '标签列表', 1, 'GoodsCategoryTags', '分享分类关联标签管理', 2, 100, 0, 0, 0, 0),
(289, 'setting', '设置标签', 1, 'GoodsCategoryTags', '分享分类关联标签管理', 2, 100, 0, 0, 0, 0),
(290, 'update', '更新分类', 1, 'GoodsCategoryTags', '分享分类关联标签管理', 2, 100, 0, 0, 1, 0),
(291, 'remove', '删除分类', 1, 'GoodsCategoryTags', '分享分类关联标签管理', 2, 100, 0, 0, 1, 0),
(292, '', '', 1, 'GoodsCatesGl', '分享分类关联管理', 2, 100, 1, 0, 0, 0),
(293, 'index', '关联列表', 1, 'GoodsCatesGl', '分享分类关联管理', 2, 100, 0, 0, 0, 0),
(294, 'setting', '设置关联', 1, 'GoodsCatesGl', '分享分类关联管理', 2, 100, 0, 0, 0, 0),
(295, 'insert', '添加关联', 1, 'GoodsCatesGl', '分享分类关联管理', 2, 100, 0, 0, 1, 0),
(296, 'remove', '删除关联', 1, 'GoodsCatesGl', '分享分类关联管理', 2, 100, 0, 0, 1, 0),
(297, '', '', 1, 'GoodsCates', '商品分类管理', 2, 100, 1, 0, 0, 0),
(298, 'index', '分类列表', 1, 'GoodsCates', '商品分类管理', 2, 100, 0, 1, 0, 0),
(299, 'update', '更新分类', 1, 'GoodsCates', '商品分类管理', 2, 100, 0, 0, 1, 0),
(300, 'collect', '采集分类', 1, 'GoodsCates', '商品分类管理', 2, 100, 0, 0, 1, 0),
(301, '', '', 1, 'GoodsColor', '商品颜色管理', 2, 100, 1, 0, 0, 0),
(302, 'index', '颜色列表', 1, 'GoodsColor', '商品颜色管理', 2, 100, 0, 1, 0, 0),
(303, 'add', '添加颜色', 1, 'GoodsColor', '商品颜色管理', 2, 100, 0, 1, 1, 0),
(304, 'update', '更新颜色', 1, 'GoodsColor', '商品颜色管理', 2, 100, 0, 0, 1, 0),
(305, 'remove', '删除颜色', 1, 'GoodsColor', '商品颜色管理', 2, 100, 0, 0, 1, 0),
(306, '', '', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 1, 0, 0, 0),
(307, 'index', '词库列表', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 0, 1, 0, 0),
(308, 'add', '添加同义词', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 0, 1, 1, 0),
(309, 'update', '更新同义词', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 0, 0, 1, 0),
(310, 'remove', '删除同义词', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 0, 0, 1, 0),
(311, 'import', '导入词库', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 0, 0, 1, 0),
(312, 'export', '导出词库', 1, 'GoodsDictionary', '商品同义词库管理', 2, 100, 0, 0, 1, 0),
(313, '', '', 1, 'ShopCateRelated', '店铺分类关联管理', 2, 100, 1, 0, 0, 0),
(314, 'index', '关联列表', 1, 'ShopCateRelated', '店铺分类关联管理', 2, 100, 0, 0, 0, 0),
(315, 'setting', '设置关联', 1, 'ShopCateRelated', '店铺分类关联管理', 2, 100, 0, 0, 0, 0),
(316, 'insert', '添加关联', 1, 'ShopCateRelated', '店铺分类关联管理', 2, 100, 0, 0, 1, 0),
(317, 'remove', '删除关联', 1, 'ShopCateRelated', '店铺分类关联管理', 2, 100, 0, 0, 1, 0),
(318, '', '', 1, 'IndexCateShare', '分类首页分享管理', 2, 100, 1, 0, 0, 0),
(319, 'index', '分享列表', 1, 'IndexCateShare', '分类首页分享管理', 2, 100, 0, 0, 0, 0),
(320, 'add', '添加分享', 1, 'IndexCateShare', '分类首页分享管理', 2, 100, 0, 0, 1, 0),
(321, 'update', '更新分享', 1, 'IndexCateShare', '分类首页分享管理', 2, 100, 0, 0, 1, 0),
(322, 'remove', '删除分享', 1, 'IndexCateShare', '分类首页分享管理', 2, 100, 0, 0, 1, 0),
(323, '', '', 1, 'IndexCateGroup', '首页分类分组管理', 7, 100, 1, 0, 0, 0),
(324, 'index', '分组列表', 1, 'IndexCateGroup', '首页分类分组管理', 7, 100, 0, 0, 0, 0),
(325, 'add', '添加分组', 1, 'IndexCateGroup', '首页分类分组管理', 7, 100, 0, 0, 1, 0),
(326, 'update', '更新分组', 1, 'IndexCateGroup', '首页分类分组管理', 7, 100, 0, 0, 1, 0),
(327, 'remove', '删除分组', 1, 'IndexCateGroup', '首页分类分组管理', 7, 100, 0, 0, 1, 0),
(328, '', '', 1, 'GoodsTags', '分享分类标签管理', 2, 100, 1, 0, 0, 0),
(329, 'index', '标签列表', 1, 'GoodsTags', '分享分类标签管理', 2, 100, 0, 1, 0, 0),
(330, 'add', '添加标签', 1, 'GoodsTags', '分享分类标签管理', 2, 100, 0, 1, 1, 0),
(331, 'update', '更新标签', 1, 'GoodsTags', '分享分类标签管理', 2, 100, 0, 0, 1, 0),
(332, 'remove', '删除标签', 1, 'GoodsTags', '分享分类标签管理', 2, 100, 0, 0, 1, 0),
(333, '', '', 1, 'ShopCategory', '店铺分类管理', 2, 100, 1, 0, 0, 0),
(334, 'index', '分类列表', 1, 'ShopCategory', '店铺分类管理', 2, 100, 0, 1, 0, 0),
(335, 'add', '添加分类', 1, 'ShopCategory', '店铺分类管理', 2, 100, 0, 1, 1, 0),
(336, 'update', '更新分类', 1, 'ShopCategory', '店铺分类管理', 2, 100, 0, 0, 1, 0),
(337, 'remove', '删除分类', 1, 'ShopCategory', '店铺分类管理', 2, 100, 0, 0, 1, 0),
(338, '', '', 1, 'TaobaoCollect', '淘宝采集管理', 2, 100, 1, 0, 0, 0),
(339, 'setting', '采集设置', 1, 'TaobaoCollect', '淘宝采集管理', 2, 100, 0, 1, 0, 0),
(340, 'index', '采集商品管理', 1, 'TaobaoCollect', '淘宝采集管理', 2, 100, 0, 1, 0, 0),
(341, 'collect', '采集进程', 1, 'TaobaoCollect', '淘宝采集管理', 2, 100, 0, 0, 1, 0),
(342, 'remove', '删除采集商品', 1, 'TaobaoCollect', '淘宝采集管理', 2, 100, 0, 0, 1, 0),
(343, '', '', 1, 'MConfig', '手机端管理', 0, 100, 1, 0, 0, 0),
(344, 'index', '手机端配置', 1, 'MConfig', '手机端管理', 10, 100, 0, 1, 0, 0),
(345, 'update', '更新配置', 1, 'MConfig', '手机端管理', 10, 100, 0, 0, 1, 0),
(346, '', '', 1, 'MAdv', '手机端广告管理', 0, 100, 1, 0, 0, 0),
(347, 'index', '广告列表', 1, 'MAdv', '手机端广告管理', 10, 100, 0, 1, 0, 0),
(348, 'add', '添加广告', 1, 'MAdv', '手机端广告管理', 10, 100, 0, 1, 1, 0),
(349, 'update', '更新广告', 1, 'MAdv', '手机端广告管理', 10, 100, 0, 0, 1, 0),
(350, 'remove', '删除广告', 1, 'MAdv', '手机端广告管理', 10, 100, 0, 0, 1, 0),
(351, '', '', 1, 'MIndex', '手机端首页菜单管理', 0, 100, 1, 0, 0, 0),
(352, 'index', '菜单列表', 1, 'MIndex', '手机端首页菜单管理', 10, 100, 0, 1, 0, 0),
(353, 'add', '添加菜单', 1, 'MIndex', '手机端首页菜单管理', 10, 100, 0, 1, 1, 0),
(354, 'update', '更新菜单', 1, 'MIndex', '手机端首页菜单管理', 10, 100, 0, 0, 1, 0),
(355, 'remove', '删除菜单', 1, 'MIndex', '手机端首页菜单管理', 10, 100, 0, 0, 1, 0),
(356, '', '', 1, 'MSearchcate', '手机端搜索页配置', 0, 100, 1, 0, 0, 0),
(357, 'index', '分类列表', 1, 'MSearchcate', '手机端搜索页配置', 10, 100, 0, 1, 0, 0),
(358, 'add', '添加分类', 1, 'MSearchcate', '手机端搜索页配置', 10, 100, 0, 1, 1, 0),
(359, 'update', '更新分类', 1, 'MSearchcate', '手机端搜索页配置', 10, 100, 0, 0, 1, 0),
(360, 'remove', '删除分类', 1, 'MSearchcate', '手机端搜索页配置', 10, 100, 0, 0, 1, 0),
(361, '', '', 1, 'MApns', '信息推送', 0, 100, 1, 0, 0, 0),
(362, 'index', '发送记录', 1, 'MApns', '信息推送', 10, 100, 0, 1, 0, 0),
(363, 'add', '添加信息', 1, 'MApns', '信息推送', 10, 100, 0, 1, 1, 0),
(364, 'send', '发送信息', 1, 'MApns', '信息推送', 10, 100, 0, 0, 1, 0),
(365, 'remove', '删除记录', 1, 'MApns', '信息推送', 10, 100, 0, 0, 1, 0),
(366, 'clear', '清除记录', 1, 'MApns', '信息推送', 10, 100, 0, 0, 1, 0);

INSERT INTO `%DB_PREFIX%role_access` (`role_id`, `node_id`) VALUES
(1, 1),
(1, 3),
(1, 6),
(1, 9),
(1, 12),
(1, 16),
(1, 19),
(1, 23),
(1, 30),
(1, 35),
(1, 38),
(1, 41),
(1, 45),
(1, 50),
(1, 55),
(1, 62),
(1, 67),
(1, 70),
(1, 75),
(1, 80),
(1, 85),
(1, 90),
(1, 95),
(1, 100),
(1, 105),
(1, 110),
(1, 115),
(1, 120),
(1, 123),
(1, 127),
(1, 130),
(1, 133),
(1, 135),
(1, 140),
(1, 145),
(1, 150),
(1, 155),
(1, 159),
(1, 162),
(1, 166),
(1, 171),
(1, 175),
(1, 180),
(1, 185),
(1, 188),
(1, 193),
(1, 197),
(1, 200),
(1, 207),
(1, 212),
(1, 216),
(1, 219),
(1, 224),
(1, 228),
(1, 232),
(1, 237),
(1, 240),
(1, 244),
(1, 247),
(1, 251),
(1, 254),
(1, 257),
(1, 266),
(1, 270),
(1, 276),
(1, 282),
(1, 287),
(1, 292),
(1, 297),
(1, 301),
(1, 306),
(1, 313),
(1, 318),
(1, 323),
(1, 328),
(1, 333),
(1, 338),
(1, 343),
(1, 346),
(1, 351),
(1, 356),
(1, 361);

INSERT INTO `%DB_PREFIX%login_module` VALUES (null, 'renren', '人人网', '人人', '', '', '0', '10', '申请地址:http://app.renren.com/developers/newapp', '1');
INSERT INTO `%DB_PREFIX%login_module` VALUES (null, 'douban', '豆瓣', '豆瓣', '', '', '0', '10', '申请地址:http://developers.douban.com/apikey/apply', '1');
INSERT INTO `%DB_PREFIX%login_module` VALUES (null, 'kaixin', '开心网', '开心网', '', '', '0', '10', '申请地址:http://open.kaixin001.com/app/app_overview.php', '1');

UPDATE `%DB_PREFIX%sys_conf` SET `val` = '3.0' WHERE `name` = 'SYS_VERSION';