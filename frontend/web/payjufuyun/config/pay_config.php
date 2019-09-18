<?php
//=======================卡类支付和网银支付公用配置==================
//趣付云商户ID
$shunfoo_merchant_id		= '1833';

//趣付云通信密钥
$shunfoo_merchant_key		= '6d7a758835814fc3b12c7b4029b93527';	//hc6NOTDETVQe9Lgr


//==========================卡类支付配置=============================
//==========================卡类支付配置=============================
//支付的区域 0代表全国通用	
$shunfoo_restrict			= '0';

//接收趣付云下行数据的地址, 该地址必须是可以再互联网上访问的网址
$shunfoo_callback_url		= "http://ylt.advancee.cn/site/qfynotify";   
//网银支付跳转回的页面地址
$shunfoo_bank_hrefbackurl	= "http://ylt.advancee.cn/user/index";  


?>