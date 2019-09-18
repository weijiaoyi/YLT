<?php
header("Content-Type: text/html;charset=utf-8");
require_once("shunfoo/class.shunfoo.php");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>支付收银台</title>
<link rel="stylesheet" type="text/css" href="style/shunfoo.css">
<script language="javascript" src="js/jquery.js"></script>
<script language="javascript" src="js/pay.js"></script>
</head>
<body style="display:none">
<center>

<?php
$html	 = '<form method="post" action="pay_go.php"  name="pay" id="pay">';
$html	.= '<div class="pay_base_info">';
$html	.= '<table class="form">';
$html	.= '<tbody>';
$html	.= '<tr class="title">';
$html	.= '	<td colspan="2"><img src="images/jk_logo.png" /></td>';
$html	.= '</tr>';
$html	.= '<tr class="label">';
$html	.= '	<td colspan="2"></td>';
$html	.= '</tr>';
$html	.= '<tr>';
$html	.= '	<td class="label">充值账户:</td>';
$html	.= '	<td class="content">';
$html	.= '		<input type="text" name="account" id="account" value="'.$_GET['uid'].'"/>';
$html	.= '	</td>';
$html	.= '</tr>';

$html	.= '<tr>';
$html	.= '	<td class="label">支付金额:</td>';
$html	.= '	<td class="content">';
$html	.= '		<input type="text" name="amount" id="amount"  value="'.$_GET['money'].'"/>'.
  '<input type="hidden" name="account_confirm" value="'.$_GET['uid'].'"/>
  <input type="hidden" name="orderId" value="'.$_GET['tradeno'].'"/>
  <input type="hidden" name="payType" value="bank">';
$html	.= '	</td>';
$html	.= '</tr>';

$html	.= '<tr>';
$html	.= '	<td class="label">支付方式:</td>';
$html	.= '	<td class="content">';
$html	.= '	</td>';
$html	.= '</tr>';


//网银类型
$html	.= '<tr class="payTypeBank">';
$html	.= '	<td colspan="2">';
$html	.= '	<div class="bankTypeDiv">';
foreach($shunfoo_banktype as $bank){
	$bankTypeRadioId	= 'bankType_' . $bank['code'];
	$html	.= '<span class="bankType">';
	$html	.= '<input type="radio"  class="bankType" name="bankType" id="'.$bankTypeRadioId.'" value="'.$bank['code'].'">';
	$html	.= '<label for="'. $bankTypeRadioId .'">'.$bank['name'].'</label>';
	$html	.= '</span>';
}
$html	.= '	<div>';
$html	.= '	</td>';
$html	.= '</tr>';

$html	.= '<tr class="foot">';
$html	.= '	<td colspan="2"><input type="submit" value="确认支付 >>" id="submit" name="submit" /></td>';
$html	.= '</tr>';
$html	.= '</tbody>';
$html	.= '</table>';
$html	.= '</form>';
echo($html);
?>
</center>
  <script>
  	$(function(){
    	$('#submit').click();
    })
  </script>
</body>
</html>
