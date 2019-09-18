<?php

namespace frontend\controllers;
header('Content-type:text/html; Charset=utf-8');

use admin\models\UserWithdraw;
use frontend\models\Alipay;
use frontend\models\AlipayService;
use frontend\models\BankCard;
use frontend\models\FileCache;
use frontend\models\OfflinePayment;
use frontend\models\Wxpay;
use frontend\models\WxpayService;
use Yii;
use common\helpers\Curl;
use frontend\models\User;
use frontend\models\UserCoupon;
use frontend\models\Product;
use frontend\models\Order;
use frontend\models\ProductPrice;
use frontend\models\DataAll;
use frontend\models\UserCharge;
use common\helpers\FileHelper;
use common\helpers\Json;


class PayController extends \frontend\components\Controller
{

    public $enableCsrfValidation = false;
    //支付界面
    public function actionIndex()
    {
        $this->view->title = '充值';
        $amount = 1;

        //保存充值记录
        $userCharge = new UserCharge();
        $userCharge->user_id = u()->id;
        $userCharge->trade_no = u()->id . date("YmdHis") . rand(1000, 9999);
        $userCharge->amount = $amount;
        //1支付宝2微信3银行卡
        $userCharge->charge_type = 2;
        //充值状态：1待付款，2成功，-1失败
        $userCharge->charge_state = 1;
        if (!$userCharge->save()) {
            return false;
        }

        return $this->render('pay', compact('amount'));
    } 

    //异步支付回调地址
    public function actionNotify()
    {
        //测试订单号
        $trade_no = 1; 
        $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $trade_no])->one();
        //有这笔订单
        if (!empty($userCharge)) {
            //充值状态：1待付款，2成功，-1失败
            if ($userCharge->charge_state == 1) {
                //找到这个用户
                $user = User::findOne($userCharge->user_id);
                //给用户加钱
                $user->account += $userCharge->amount;
                if ($user->save()) {
                    //更新充值状态---成功
                    $userCharge->charge_state = 2;
                }
            }
            //更新充值记录表
            $userCharge->update();
        }
    }
    /**
    * get 调用 支付宝H5支付
    * tradeno  订单号
    * money 金额
    * */
    public function actionIndex2()
    {

        $getData=get();
//        dump($getData);
        $orderId=$getData['tradeno'];
        $Id=$getData['uid'];
//        dump($orderId);
        $num=$getData['money'];
//        $num='0.01';
        /*** 请填写以下配置信息 ***/
        $appid = '2019042264270283';  //https://open.alipay.com 账户中心->密钥管理->开放平台密钥，填写添加了电脑网站支付的应用的APPID
        $returnUrl = 'http://120.79.2.144/pay/index3';     //付款成功后的同步回调地址
        $notifyUrl = 'http://120.79.2.144/pay/index3';     //付款成功后的异步回调地址
        $outTradeNo = $orderId;     //你自己的商品订单号
        $orderId=substr($orderId,-8,8);  // 订单截取后八位
        $payAmount = $num;          //付款金额，单位:元
        $orderName = '订单消费金额ID'.$Id;    //订单标题
        $signType = 'RSA2';			//签名算法类型，支持RSA2和RSA，推荐使用RSA2
        $rsaPrivateKey='MIIEowIBAAKCAQEAvlfJO84H1k/+Yp70JEFKu1vdC3qVOKdd8J1cFsWUcoE1Pw/if8H4Mzl8QCQtQYqKYCfzYboXnhqG7kYWmepz3KOcOZCmbHMFk9PW5/7fu1jCe8ajLZFuTKPUZqw4ElsSwoHWW0nlJk3kksJJQCV1DvTKb345QxkuIAfQjVS7TF/9tXpLmqBboOjslEgrMu2Cqr86x9V69weQM3z/+Kr3RuUWb11iCX5hlsHONgIzfFXOwF0T4Wx9ePV+yUmV2OJqFfLPMRuTeDyesZe9+j1O0dmwz9RPs5gmSjea57I7cbPBqFpi13rl9f5vvw9D537pE+HzntIrvVgcIwjYR4tI9wIDAQABAoIBAQCo88sPZqXWOVMXvvf+ZmYrQDNIyRpDG2xq84KWQ/KsYLweqb7moAnrjg8X8ASrtIl3KH8EM+Za1DkIrvXI0S7enetBvX+7q607tkF/0+BLr1GSBJM7E2fQZ2tVZ3Ct+mEAfbcDeOgJxAIrsoDKi3UIPYiixmuVf3hNviIEET3fX5skO8Hne8TIOFaiOGkPYcGaGh3gPKs90TZxVyUQtoNRfVkM5luZR7rHo+Ofmg0e9W62w28KlCjkt0K5Cm9jfNwKFnwMcsetlqrNJPTGBuRnlXowP80oKWcOxD2w2waEuBXR1puC15zCslduJfU5vDcyEagYaRi11VFLGnLqbHFBAoGBAPSj9etjb3Ew9h70whe9IVXuJdmQvugwKBD72eKlCUFviDk7bnjZVo+26p8GNa1qcOQyjV2FxBYSoFXlsc41cIE2OeoMfu+QaarxibdUR7UibzbIfY8YUn7uYUwrhW1fhOLk7f+3/uifj02KQuyZSsnOf/AcjiEIa1midOv77h0pAoGBAMcuZAwhKZL8XMc0U2r3Jj6svXdHaZvd3ErEUCilYbkvkXxb6YWuG5Xi38cexPyIj+v2GXp7QjiSbWtJPrT4iWBiltdvW/dlE5IpAThdESNmY/kvV3fIgB3cdxLPSefKQ3RYTrPhCGkFvv0q3TCZEAywmUuMeGNcKWfl3c+4ztkfAoGAbGIzsnyUQ/aoI+DWGMRO/44JsNEi8yVaquOZjYMGjboHBSwibmIDqpokah3LLDBLIZ6P6M45qHnKFSQ1WSFt3aETmXC90A8P8Y8fL1ykhEhkM0Yx8nKZIekkrCVf8Kvv6MH5+2AeDBuc1oKZ0c68Rpo5LjzIbzQWs1h5Ko+r17kCgYAopYDpMMNJKZLNXBJB29nEJIAtnTciBa5024b4JHfC0MBBvofzLcqXVcsQ2WidmEi2gGxGoGytGsSVhkbzq1xtfPEHWcRMwiWySAfltqhOrxBrw4t3+ESc02bBQef1E0OctICrGJscw31sMJke1718uXUvA6V1sVMJztDrGO2tRQKBgCx0QV5xlJ9y0KB8Q2LlcXzlISDELRV+lpGuLhJdisYWrT5tI10hRNVP2q2Q7k1QOBgFamh56j4o1JZIuTWZbEatN59+V0/OAEuBdxMOA6ZUJAzO9VsLK0D6L0h7O/EuRnmxKrSVVRxGCQU1XZ+fWSuhGYKEzoregvYvVMR1ejgO';		//商户私钥，填写对应签名算法类型的私钥，如何生成密钥参考：https://docs.open.alipay.com/291/105971和https://docs.open.alipay.com/200/105310
        /*** 配置结束 ***/
        $aliPay = new AlipayService();
        $aliPay->setAppid($appid);
        $aliPay->setReturnUrl($returnUrl);
        $aliPay->setNotifyUrl($notifyUrl);
        $aliPay->setRsaPrivateKey($rsaPrivateKey);
        $aliPay->setTotalFee($payAmount);
        $aliPay->setOutTradeNo($outTradeNo);
        $aliPay->setOrderName($orderName);
        $sHtml = $aliPay->doPay();
        echo $sHtml;
    }

    /**
     *支付宝回调函数
     */
    public function actionIndex3()
    {

        $Cache=new FileCache();
        $get_data=get();
        $post_data=post();
        //支付宝公钥，账户中心->密钥管理->开放平台密钥，找到添加了支付功能的应用，根据你的加密类型，查看支付宝公钥
        $alipayPublicKey='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjqQJj7iDlClrhK5wgG+YXlNd1d8XqSokMel27IOPVOaZAiVt0QQKkllyAboId7YtBffWh5Ikk7MDnnQXxf2dHZhJtcY/ItO5HWnkuDaOqoS/DzslOM7VpmXWbfhroEMQ593unXawbaBFfzCmIFHLPnSWbDUuSMvNwg2LmoofqWfFFD1segi/m4O6/legCqAeYb2ikXDbywQBixibIjyVluYzp0dvO5ZIUQ7P/KdVznaedLjuMBy6AHFTPi0xPzJF3vPzE6XIrXjFVeEXDgNQEqwS+OA+PYz+eZ5GJEgpJrjtlzFVqBcYUXztHIYTxHUZRaBtuoqLGpGHESYRfTl5hQIDAQAB';

        $aliPay = new Alipay($alipayPublicKey);
//验证签名
        $result = $aliPay->rsaCheck($_POST,$_POST['sign_type']);
        if($result===true){
            //处理你的逻辑，例如获取订单号$_POST['out_trade_no']，订单金额$_POST['total_amount']等
            if (req()->isPost) {
                $trade_no = $post_data['out_trade_no'];
            }else{
                $trade_no = $get_data['out_trade_no'];
            }
            $Cache->Dir('./Alipay_cache/');
            $Cache->Write("$trade_no.txt", $get_data);
            $Cache->Dir('./Alipay_cache/post/');
            $Cache->Write("$trade_no.txt", $post_data);
            $userCharge = UserCharge::find()->where('trade_no = :trade_no and charge_state = :charge_state', [':trade_no' => $trade_no,':charge_state'=>1])->one();
            //有这笔订单
            if (!empty($userCharge)) {
                //充值状态：1待付款，2成功，-1失败
                if ($userCharge->charge_state == 1) {
                    //找到这个用户
                    $user = User::findOne($userCharge->user_id);
                    //给用户加钱
                    $user->account += $userCharge->amount;
                    if ($user->save()) {
                        //更新充值状态---成功
                        $userCharge->charge_state = 2;
                        $userCharge->after_recharge =  $user->account;
                        $this->actionIndex6($user->id,$userCharge->amount);
                    }
                }
                //更新充值记录表
                $userCharge->update();
                echo 'success ';
                return $this->redirect(['site/index']);
            }
            //程序执行完后必须打印输出“success”（不包含引号）。如果商户反馈给支付宝的字符不是success这7个字符，支付宝服务器会不断重发通知，直到超过24小时22分钟。一般情况下，25小时以内完成8次通知（通知的间隔频率一般是：4m,10m,10m,1h,2h,6h,15h）；
            echo 'success'; return $this->redirect(['site/index']);
        }
        echo 'error'; return $this->redirect(['site/index']);


    }

    /**
    * get 方式调用微信h5支付
    *  tradeno 订单号
    *  money  金额
    */
    public function actionIndex4()
    {



        $getData=get();
//        dump($getData);
        $orderId=$getData['tradeno'];
        $Id=$getData['uid'];
//        dump($orderId);
        $num=$getData['money'];
//        $num='0.01';


        $mchid = '1532228361';          //微信支付商户号 PartnerID 通过微信支付商户资料审核后邮件发送
        $appid = 'wx087f2d1d65e47613';  //微信支付申请对应的公众号的APPID
        $appKey = 'nanjingchiyingdianzishang2019040';   //微信支付申请对应的公众号的APP Key
        $apiKey = 'nanjingchiyingdianzishang2019040';   //https://pay.weixin.qq.com 帐户设置-安全设置-API安全-API密钥-设置API密钥
        $outTradeNo = $orderId;     //你自己的商品订单号
        $orderId=substr($orderId,-8,8);  // 订单截取后八位
        $payAmount = $num;          //付款金额，单位:元
        $orderName = '购买金额'.$Id;    //订单标题
        $notifyUrl = 'http://ylt.qkxxx.com/pay/index5';     //付款成功后的回调地址(不要有问号)
        $returnUrl = 'http://ylt.qkxxx.com';     //付款成功后，页面跳转的地址
        $wapUrl = 'www.xxx.com';   //WAP网站URL地址
        $wapName = 'H5支付';       //WAP 网站名
        /** 配置结束 */
        $wxPay = new WxpayService($mchid,$appid,$apiKey);
        $wxPay->setTotalFee($payAmount);
        $wxPay->setOutTradeNo($outTradeNo);
        $wxPay->setOrderName($orderName);
        $wxPay->setNotifyUrl($notifyUrl);
        $wxPay->setReturnUrl($returnUrl);
        $wxPay->setWapUrl($wapUrl);
        $wxPay->setWapName($wapName);
        $mwebUrl= $wxPay->createJsBizPackage($payAmount,$outTradeNo,$orderName,$notifyUrl);
        
        echo "<h1><a href='{$mwebUrl}'>点击跳转至支付页面</a></h1>";
        exit();







        $mchid = '1532228361';          //微信支付商户号 PartnerID 通过微信支付商户资料审核后邮件发送
        $appid = 'wx087f2d1d65e47613';  //公众号APPID 通过微信支付商户资料审核后邮件发送
        $apiKey = 'nanjingchiyingdianzishang2019040';   //https://pay.weixin.qq.com 帐户设置-安全设置-API安全-API密钥-设置API密钥
        $wxPay = new WxpayService($mchid,$appid,$apiKey);
        $outTradeNo = $orderId;     //你自己的商品订单号
        $payAmount = $num;          //付款金额，单位:元
        $orderName = '支付测试';    //订单标题
        $notifyUrl = 'http://ylt.qkxxx.com/pay/index5';     //付款成功后的回调地址(不要有问号)
        $payTime = time();      //付款时间
        $arr = $wxPay->createJsBizPackage($payAmount,$outTradeNo,$orderName,$notifyUrl,$payTime);
//        dump($arr);
//生成二维码
        $url = 'https://www.kuaizhan.com/common/encode-png?large=true&data='.$arr['code_url'];
        echo "<img src='{$url}' style='width:700px;margin: 200px;'><br>";
//        echo '二维码内容：'.$arr['code_url'];
    }

    /**
     * 微信回调函数
     * */
    public function actionIndex5()
    {
//    $this->enableCsrfValidation=false;
        $Cache=new FileCache();
//        $get_data=get();
//        $post_data=post();
        $mchid = '1532228361';          //微信支付商户号 PartnerID 通过微信支付商户资料审核后邮件发送
        $appid = 'wx087f2d1d65e47613';  //公众号APPID 通过微信支付商户资料审核后邮件发送
        $apiKey = 'nanjingchiyingdianzishang2019040';   //https://pay.weixin.qq.com 帐户设置-安全设置-API安全-API密钥-设置API密钥

        $wxPay = new Wxpay($mchid,$appid,$apiKey);
        $result = $wxPay->notify();
        if($result){
            //完成你的逻辑
            //例如连接数据库，获取付款金额$result['cash_fee']，获取订单号$result['out_trade_no']，修改数据库中的订单状态等;
            $post = file_get_contents("php://input");
            if ($post == null) {
                $post = isset($GLOBALS['HTTP_RAW_POST_DATA']) ? $GLOBALS['HTTP_RAW_POST_DATA'] : '';
            }

            if (empty($post) || $post == null || $post == '') {
                //阻止微信接口反复回调接口  文档地址 https://pay.weixin.qq.com/wiki/doc/api/H5.php?chapter=9_7&index=7，下面这句非常重要!!!
                $str='<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>';
                echo $str;
                exit('Notify 非法回调');
            }

            libxml_disable_entity_loader(true); //禁止引用外部xml实体

            $xml = simplexml_load_string($post, 'SimpleXMLElement', LIBXML_NOCDATA);//XML转数组

            $post_data = (array)$xml;

            $out_trade_no = isset($post_data['out_trade_no']) && !empty($post_data['out_trade_no']) ? $post_data['out_trade_no'] : 0;
            $result_code = isset($post_data['result_code']) && !empty($post_data['result_code']) ? $post_data['result_code'] : false;
            if ($result_code != 'SUCCESS'){
                return error('参数错误');
            }
            $trade_no = $out_trade_no;
            $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $trade_no])->one();


            //有这笔订单
            if (!empty($userCharge)) {
                //充值状态：1待付款，2成功，-1失败
                if ($userCharge->charge_state == 1) {
                    //找到这个用户
                    $user = User::findOne($userCharge->user_id);
                    //给用户加钱
                    $user->account += $userCharge->amount;
                    if ($user->save()) {
                        //更新充值状态---成功
                        $userCharge->charge_state = 2;
                        $userCharge->after_recharge =  $user->account;
                        $this->actionIndex6($user->id,$userCharge->amount);
                    }
                }
                //更新充值记录表
                $userCharge->update();
                return $this->redirect(['pay/index4']);
            }
        }else{
            echo 'pay error';
        }

    }

    public function actionIndex6($uid=100368,$account=0 )
    {
        $resultArr=UserWithdraw::find()->where(['user_id' => $uid])->asArray()->orderBy('amount_recharge DESC')->all();
        $amount_recharge=0;
        if ($resultArr[0]['amount_recharge']==null){
           $UserChargeArry= UserCharge::find()->where('user_id = :user_id AND charge_state = :charge_state AND charge_type != :charge_type', [':user_id' => $uid,':charge_state'=>2,':charge_type'=>3])->asArray()->all();
           foreach ($UserChargeArry as $key =>$value ){

                $amount_recharge+=$value['amount'];
            }
        }else{
            $amount_recharge=$resultArr[0]['amount_recharge'];
        }

        $amount_recharge_all=$amount_recharge+$account;

        $resu=UserWithdraw::updateAll(['amount_recharge'=>$amount_recharge_all],['user_id'=>$uid]);
        return $resu;
    }


    /**
     *  公司自用支付回调处理
     *
     * */
    public function actionIndex7(){
        if(Yii::$app->request->isPost) {
            $Cache = new FileCache();
            $post_data = post();
            $baseOrderData = $post_data['data'];
            $jsonOrderData = base64_decode($baseOrderData);
            $ArrayOrderData = json_decode($jsonOrderData, 1);
            // 取出订单号
            $trade_no = isset($ArrayOrderData['result']['order_id']) ? $ArrayOrderData['result']['order_id'] : 0;
            //  取出金额
            $amount = isset($ArrayOrderData['result']['amount']) ? $ArrayOrderData['result']['amount'] : 0;
            //  取出时间
            $time = isset($ArrayOrderData['result']['time']) ? $ArrayOrderData['result']['time'] : 0;
            $key_id = '07C667D33A53AF'; //  商户秘钥   找支付提供方 获取
            $array = [
                'amount' => $amount,
                'out_trade_no' => $trade_no,
                'time'=>$time,
            ];
            $sig = $this->actionSign($key_id, $array);  //  调用 签名算法计算
            if ($sig == $ArrayOrderData['result']['sign']) {  // 签名对比
                $Cache->Dir('./Self_support/post/');
                $Cache->Write("$trade_no.txt", $post_data);
                $userCharge = UserCharge::find()->where('trade_no = :trade_no and charge_state = :charge_state', [':trade_no' => $trade_no,':charge_state'=>1])->one();
                //有这笔订单
                if (!empty($userCharge)) {
                    //充值状态：1待付款，2成功，-1失败
                    if ($userCharge->charge_state == 1) {
                        //找到这个用户
                        $user = User::findOne($userCharge->user_id);
                        //给用户加钱
                        $user->account += $userCharge->amount;
                        if ($user->save()) {
                            //更新充值状态---成功
                            $userCharge->charge_state = 2;
                            $userCharge->after_recharge =  $user->account;
                            $this->actionIndex6($user->id,$userCharge->amount);
                        }
                    }
                    //更新充值记录表
                    $userCharge->update();
                    $resultData=[
                        'status'=>'success',
                        'code'=>'200',
                        'msg'=>'回调成功',
                    ];
                    $resultJson=json_encode($resultData,256);
                    return $resultJson;
                }else{
                    $userCharge = UserCharge::find()->where('trade_no = :trade_no and charge_state = :charge_state', [':trade_no' => $trade_no,':charge_state'=>2])->one();
                    if(!empty($userCharge)){
                        $resultData=[
                            'status'=>'success',
                            'code'=>'200',
                            'msg'=>'订单已经完成，不要再次回调',
                        ];
                        $resultJson=json_encode($resultData,256);
                        return $resultJson;
                    }
                    $resultData=[
                        'status'=>'fail',
                        'code'=>'0',
                        'msg'=>'订单信息有误',
                    ];
                    $resultJson=json_encode($resultData,256);
                    return $resultJson;
                }
            }else{
                $resultData=[
                    'status'=>'fail',
                    'code'=>'0',
                    'msg'=>'签名错误'.$sig.'amount'.$amount.'out_trade_no'.$trade_no.'time'.$time,
                ];
                $resultJson=json_encode($resultData,256);
                return $resultJson;
            }
        }else{
            echo   "谢绝访问";
        }
    }
    /**
     *  公司自用支付，发起请求
     *
     **/
    public function actionIndex8()
    {
//        $PayOrder= new PayOrder();
//        $payData= $_POST;
        $getData=get();
//        $orderId=isset($payData['order_id'])?$payData['order_id']:0;
        $orderId=isset($getData['tradeno'])?$getData['tradeno']:0;
        $amount=isset($getData['money'])?$getData['money']:0;

//        if ($userId!=0 && $orderId!=0){ // 当参数都有，查询之前发起请求后保存 的数据是否正确
//            $list = $PayOrder->where(['order_id'=>$orderId,'user_id'=>$userId])->find();
//            $orderId=isset($list['order_id'])?$list['order_id']:0;
        if ($orderId!=0){  // 查询到该订单   取值 发起支付
            $key_id='07C667D33A53AF'; //  商户秘钥   找支付提供方 获取
            $account_id='10602';
            $array = array('amount'=>$amount,'out_trade_no'=>$orderId);
            //计算签名
            $sig=$this->actionSign($key_id,$array);
            $callback_url='http://ylt.qkxxx.com/pay/index7';
            echo "<form style='display:none;' id='form1' name='form1' method='post' action='http://pay.fchb1.com/index/bankCard/index.do'>
              <input name='account_id' type='text' value='{$account_id}' />
              <input name='order_id' type='text' value='{$orderId}'/>
              <input name='amount' type='text' value='{$amount}'/>
              <input name='sign' type='text' value='{$sig}'/>
              <input name='callback_url' type='text' value='{$callback_url}'/>
            </form>
            <script type='text/javascript'>function load_submit(){document.form1.submit()}load_submit();</script>";
        }
//        }
    }
//sign算法
//$key_id 商户KEY
//$array = array('amount'=>'1.00','out_trade_no'=>'2018123645787452');
    static public function actionSign($key_id, $array)
    {
        $data = md5(sprintf("%.2f", $array['amount']) . $array['out_trade_no'].$array['time']);
        $cipher = '';
        $key[] = "";
        $box[] = "";
        $pwd_length = strlen($key_id);
        $data_length = strlen($data);
        for ($i = 0; $i < 256; $i++) {
            $key[$i] = ord($key_id[$i % $pwd_length]);
            $box[$i] = $i;
        }
        for ($j = $i = 0; $i < 256; $i++) {
            $j = ($j + $box[$i] + $key[$i]) % 256;
            $tmp = $box[$i];
            $box[$i] = $box[$j];
            $box[$j] = $tmp;
        }
        for ($a = $j = $i = 0; $i < $data_length; $i++) {
            $a = ($a + 1) % 256;
            $j = ($j + $box[$a]) % 256;

            $tmp = $box[$a];
            $box[$a] = $box[$j];
            $box[$j] = $tmp;

            $k = $box[(($box[$a] + $box[$j]) % 256)];
            $cipher .= chr(ord($data[$i]) ^ $k);
        }

        return md5($cipher);
    }


//    /**
//     * 云码 支付
//     * 文档地址 http://www.ymepay.com/Index/Home/api.html
//     **/
//    public function actionIndex9()
//    {
//        $getData=get();
//        $orderId=isset($getData['tradeno'])?$getData['tradeno']:0; // 订单号
//        $amount=isset($getData['money'])?$getData['money']:0;  //  支付金额
//        $shopID='2019142';  //  商户号
//        $address='';  //  异步通知地址
//        $url='';  // 支付后跳转的地址
//        $ip=$this->actionGetIp();
//        $key='oIzWTeDuvZlfoXSPVjvUuSLZdBNUMNdu';
//        $array=[
//            'shopID'=>$shopID,
//            'orderID'=>$orderId,
//            'num'=>$amount,
//            'address'=>$address,
//            'key'=>$key,
//        ];
//        // 得到算出的签名
//        $resultSig=$this->actionYunmaSig($array);
//
//        echo "<form id='Form1' name='Form1' method='post' action='http://localhost:8001/Pay'>
//    <input type='hidden' name='fxid' value='{$shopID}'/>
//    <input type='hidden' name='fxddh' value='{$orderId}'/>
//    <input type='hidden' name='fxdesc' value='会员套餐'/>
//    <input type='hidden' name='fxfee' value='{$amount}'/>
//    <input type='hidden' name='fxattch' value='mytest'/>
//    <input type='hidden' name='fxnotifyurl' value='{$address}'/>
//    <input type='hidden' name='fxbackurl' value='{$url}'/>
//    <input type='hidden' name='fxpay' value='wxsm'/>
//    <input type='hidden' name='fxip' value='{$ip}'/>
//    <input type='hidden' name='fxsign' value='{$resultSig}'/>
//</form>";
//    }
//    /*云码支付签名*/
//    public function actionYunmaSig($array=[])
//    {
////        签名【md5(商务号+商户订单号+支付金额+异步通知地址+商户秘钥)】
//        $result=md5($array['shopID'].$array['orderID'].$array['num'].$array['address'].$array['key']);
//        return $result;
//    }
    /**
     * 获取用户真实iP
     *  */
    public function actionGetIp()
    {
        if (!empty($_SERVER["HTTP_CLIENT_IP"])) {
            $cip = $_SERVER["HTTP_CLIENT_IP"];
        } else if (!empty($_SERVER["HTTP_X_FORWARDED_FOR"])) {
            $cip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        } else if (!empty($_SERVER["REMOTE_ADDR"])) {
            $cip = $_SERVER["REMOTE_ADDR"];
        } else {
            $cip = '';
        }
        preg_match("/[\d\.]{7,15}/", $cip, $cips);
        $cip = isset($cips[0]) ? $cips[0] : 'unknown';
        unset($cips);
        return $cip;
    }

    /**
     *  转账支付
     *  获取订单号 支付金额
     **/
    public function actionIndex9()
    {
        if (empty(u()->id)){
            $this->redirect(['/site/login']);
        }

        if(Yii::$app->request->isPost) {// 判断是否是post提交
            $postData=$_POST;  // 接收数据
            $doStringArr=[];
            // 处理一遍 传来的参数，全部过滤符号
            foreach ($postData as $key =>$val){
                $doStringArr[$key]=$this->actionDoString($val);
            }
            $userId=u()->id;  // 当前用户ID
            $orderId=$doStringArr['tradeno'];  // 订单号
            $pay_name=$doStringArr['user_pay_name']; //  支付账号姓名
            $pay_info=$doStringArr['user_pay_info']; //  支付备注信息
            $shop_name=$doStringArr['my_pay_name']; //  收款姓名
            $shop_num=$doStringArr['user_pay_num']; //  收款号

            // 根据订单和用户id 去查询充值单
            $resultData=OfflinePayment::find()->where(['user_id'=>$userId,'order_id'=>$orderId])->Asarray()->one();

            if (!$resultData){
                $OfflinePayment = new OfflinePayment;
                $OfflinePayment->user_id=$userId;
                $OfflinePayment->order_id=$orderId;
                $OfflinePayment->pay_name=$pay_name;
                $OfflinePayment->pay_info=$pay_info;
                $OfflinePayment->shop_name=$shop_name;
                $OfflinePayment->shop_num=$shop_num;
                $OfflinePayment->create_time=date('Y-m-d H:i:s',time()); // 创建时间
                $OfflinePayment->order_status='1';   //  待审核
                if ($OfflinePayment->save(false)){
                    $this->redirect(['/site/index']);
                }

            }

        }else{

            $uid=$_GET['uid'];
            $UserArrayData=User::find()->where(['id'=>$uid])->Asarray()->one();
            if ($UserArrayData['bank_status']=='2'){
                $bankCard = BankCard::find()->where(['user_id' =>$uid])->Asarray()->one();
                $username=$bankCard['bank_user'];

            }else{
                $username=$UserArrayData['nickname'];
            }
            $money=$_GET['money'];
            $tradeno=$_GET['tradeno'];
            return $this->render('infoConfirm',compact('uid','money','tradeno','username'));
        }
    }

    /**
     *  处理字符串，防止XSS注入
     * $string 给定的字符串
     * */
    public function actionDoString($string='')
    {
        $doString= htmlspecialchars($string, ENT_QUOTES);
        $doString = empty($doString)?'0':$doString;  // 处理字符串是否为空的情况，为空赋值为0
        return $doString;
    }
}
