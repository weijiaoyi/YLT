<?php
		$money = $_REQUEST['money'];
		$tradeno = $_REQUEST['tradeno'];

        $payType = "alipay";//支付宝固定为alipay

        $shopNo = 'A537900019';//店铺编号，必填，非常重要，店铺编号错误，就不能收到对应的账上了，车大大的编号是1710121070
        $totalAmount = $money;//收款金额，必填
        $outTradeNo = $tradeno;// 外部订单编号,非必填，如果不填，由服务器端产生并返回。自己填写，要确保outTradeNo不重复
        $subject = '';//交易标题，非必填，不填则默认店铺名称
        $remark = '';//交易备注，非必填
        $operator = '';//收款人，非必填

 	$payHost="https://www.darlingpage.com";//固定

    $payUrl = $payHost. "/payapi/qrcode2/createQrCode.do"; //二维码产生接口地址,固定
    $post_data = array(
        "payType" => $payType,
        "shopNo" => $shopNo,
        "totalAmount" =>$totalAmount,
        "outTradeNo" =>$outTradeNo,
        "subject" =>'',
        "remark" => '',
        "operator" => '');
$payurlget =  $payUrl.'?payType='.$payType.'&shopNo='.$shopNo.'&totalAmount='.$totalAmount.'&outTradeNo='.$outTradeNo.'&subject='.$subject.'&remark='.$remark.'&operator='.$operator;
$res = file_get_contents($payurlget);
$data = json_decode($res,true);
if($data['msgcode']=='100'){
  if($data['msg']['totalAmount'] == $money){
  	$code= $data['msg']['qrCode'];
    header('location:'.$code);
  }else{
  	exit('金额错误！');
  }
}else{
	exit('下单失败！');
}

exit();

?>