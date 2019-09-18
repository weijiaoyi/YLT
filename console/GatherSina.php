<?php

namespace console\models;

use Yii;
use common\models\Order;
use common\models\Product;
use common\models\DataAll;
use common\models\ProductParam;
use common\helpers\StringHelper;
use common\helpers\Curl;

class GatherSina extends Gather
{
    public $urlPrefix = 'http://hq.sinajs.cn/list=';
    // 交易产品列表，格式为["表名" => "抓取链接参数名"]
    public $productList = [
    // 'btc'=>'btc_btcbitstamp',
    ];

    public function run(){
        $this->switchMap = option('risk_product') ?: [];

        $products = Product::find()->where(['state' => 1, 'on_sale' => 1, 'source' => 1])->select('table_name, code, trade_time, id')->asArray()->all();
        

        $this->productList = array_merge($this->productList, $products);
		//var_dump($this->productList);
        $tableSize = sizeof($this->productList);
        //echo "$tableSize";

        for ($i = 0;$i<$tableSize;$i++) {

            $info = $this->productList[$i];  

            $start = strtotime(date('Y-m-d 00:00:00', time()));
            if ($info['trade_time']) {
                //echo "coming!!!\n";
                $timeArr = unserialize($info['trade_time']);
                $start = strtotime(date('Y-m-d ' . $timeArr[0]['start'] . ':00'));
                $time = end($timeArr);
                $end = strtotime(date('Y-m-d ' . $time['end'] . ':00'));
                //var_dump($timeArr);
                if ($start > $end) {
                    if ($start > time() && $end < time()) {
                        continue;
                    } 
                } else {
                    if ($start > time() || $end < time()) {
                        continue;
                    } 
                }
            }
			
			
			$md5sign=md5("u=18723138074&p=wangyang521&stamp=".time());
			$market = substr($info['code'],0,2);
			$symbol = $info['code'];
			$url = "http://dt.cnshuhai.com/stock.php?u=18723138074&market=".$market."&type=stock&symbol=".$symbol;
			$req = $this->sendRequest($url, [], 'GET', []);
			$data = $req['ret'] ? $req['msg'] : '';
			$data = gzdecode($data);
			
            $result = json_decode($data,true);
          	if($info['code'] == 'SH000905'){
            	echo $url;
              	var_dump($result);
            }
            

            if ($result) {
				$result = $result[0];
				//var_dump($result);
				$price = $result['NewPrice'];
				$close = $result['LastClose'];
				$diff = $price - $close;
				if($diff == 0) {
					$diff_rate = 0.00;
				} else {
					$diff_rate = number_format($diff / $close * 100, 2, ".", "");
				}
				$data = [
					'price' => $result['NewPrice'],
					'open' => $result['Open'],
					'high' => $result['High'],
					'low' => $result['Low'],
					'close' => $close,
					'diff' => $diff,
					'diff_rate' => $diff_rate,
					'time' => date('Y-m-d H:i:s', $result['Date'])
				];
				//var_dump($data);
                $this->insert($info['table_name'], $data);
            }
                
            
        }
        $this->listen();
    }


/**
 * CURL发送Request请求,含POST和REQUEST
 * @param string $url 请求的链接
 * @param mixed $params 传递的参数
 * @param string $method 请求的方法
 * @param mixed $options CURL的参数
 * @return array
 */
protected function sendRequest($url, $params = [], $method = 'POST', $options = [])
{
	$method = strtoupper($method);
	$protocol = substr($url, 0, 5);
	$query_string = is_array($params) ? http_build_query($params) : $params;

	$ch = curl_init();
	$defaults = [];
	if ('GET' == $method)
	{
		$geturl = $query_string ? $url . (stripos($url, "?") !== FALSE ? "&" : "?") . $query_string : $url;
		$defaults[CURLOPT_URL] = $geturl;
	}
	else
	{
		$defaults[CURLOPT_URL] = $url;
		if ($method == 'POST')
		{
			$defaults[CURLOPT_POST] = 1;
		}
		else
		{
			$defaults[CURLOPT_CUSTOMREQUEST] = $method;
		}
		$defaults[CURLOPT_POSTFIELDS] = $query_string;
	}

	$defaults[CURLOPT_HEADER] = FALSE;
	$defaults[CURLOPT_USERAGENT] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.98 Safari/537.36";
	$defaults[CURLOPT_FOLLOWLOCATION] = TRUE;
	$defaults[CURLOPT_RETURNTRANSFER] = TRUE;
	$defaults[CURLOPT_CONNECTTIMEOUT] = 10;
	$defaults[CURLOPT_TIMEOUT] = 10;

	// disable 100-continue
	curl_setopt($ch, CURLOPT_HTTPHEADER, array('Expect:'));

	if ('https' == $protocol)
	{
		$defaults[CURLOPT_SSL_VERIFYPEER] = FALSE;
		$defaults[CURLOPT_SSL_VERIFYHOST] = FALSE;
	}

	curl_setopt_array($ch, (array) $options + $defaults);

	$ret = curl_exec($ch);
	$err = curl_error($ch);

	if (FALSE === $ret || !empty($err))
	{
		$errno = curl_errno($ch);
		$info = curl_getinfo($ch);
		curl_close($ch);
		return [
			'ret'   => FALSE,
			'errno' => $errno,
			'msg'   => $err,
			'info'  => $info,
		];
	}
	curl_close($ch);
	return [
		'ret' => TRUE,
		'msg' => $ret,
	];
}
}
