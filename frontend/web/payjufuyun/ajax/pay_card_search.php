<?php
error_reporting(0);
header('Content-Type:text/html;charset=GB2312');
include_once("../config/pay_config.php");
include_once("../shunfoo/class.shunfoo.php");
$shunfoo = new shunfoo();
$shunfoo->parter 		= $shunfoo_merchant_id;		//�̼�Id
$shunfoo->key 			= $shunfoo_merchant_key;	//�̼���Կ

$result	= $shunfoo->search($_POST['order_id']);

$data = '{"success": "'.$result.'","message": "'. $shunfoo->message .'"}';
die($data);
?>