<?php

/**
 * For the brave souls who get this far:
 * When I wrote this, only God and I understood what I was doing
 * Now, God only knows. You are the chosen ones,
 * the valiant knights of programming who toil away, without rest,
 * fixing our most awful code. To you, true saviors, kings of men,
 * I say this: never gonna give you up, never gonna let you down,
 * never gonna run around and desert you. Never gonna make you cry,
 * never gonna say goodbye. Never gonna tell a lie and hurt you.
 * 致终于来到这里的勇敢的人：
 * 写这段代码的时候，只有上帝和我知道它是干嘛的，现在，只有上帝知道。
 * 你是被上帝选中的人，是英勇的、不敌辛苦的、不眠不休的来修改我们这最棘手的代码的编程骑士。
 * 你，我们的救世主，人中之龙，我要对你说：永远不要放弃，永远不要对自己失望，永远不要逃走，辜负了自己，
 * 永远不要哭啼，永远不要说再见，永远不要说谎来伤害自己。
 */


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

    // 交易产品列表，格式为["表名" => "抓取链接参数名"]
    public $productList = [];

    public function run(){

        $products = Product::find()
            ->where(['state' => 1, 'on_sale' => 1, 'source' => 1])
            ->select('table_name, code, trade_time, id')
            ->asArray()
            ->all();
        $this->productList=$products;
        foreach ($products as $p){
            $newProducts[$p['code']]=$p;
        }
        $Table=$newProducts;


        //新接
        $url='http://hq89.sumbrisk.com:9910/r.aspx?u=19062403&symbol=HSIML|MHIML|FDAXML|CNA50ML|IFML|GCML|CLML|RBML|SRML|SCML';
        $req=file_get_contents($url);
        $resultArr = json_decode($req,true);//$this->getHtml($url);
        foreach ($resultArr as $new){
            switch ($new['n']){
                case 'HSIML':
                    $key='HIHSIF'; //恒指
                    break;
                case 'MHIML':
                    $key='HIMHIF';  // 小恒指
                    break;
                case 'FDAXML':
                    $key='CEDAXA0';  // 德指
                    break;
                case 'CNA50ML':
                    $key='WGCNA0';   //富时
                    break;
                case 'IFML':
                    $key='SFIF0001'; // 沪深300
                    break;
                case 'GCML':
                    $key='CMGCA0';  // 美黄金
                    break;
                case 'CLML':
                    $key='NECLA0';   // 美原油
                    break;
                case 'RBML':
                    $key='SCrb0001'; // 螺纹钢
                    break;
                case 'SRML':
                    $key='ZCSR0001'; // 白糖
                    break;
                case 'SCML':
                    $key='SEsc0001';  //  原油
                    break;
                default:
                    continue;
            }

            if($Table[$key]['trade_time']){
                $timeSet=unserialize($Table[$key]['trade_time']);
                $do=false;
                foreach ($timeSet as $t){
                    $time=date('H:i',$new['t']);
                    if($t['start']>$t['end']){
                        if($time<$t['end'] || $time>$t['start'])   $do=true;
                    }else{
                        if($time<$t['end'] && $time>$t['start'])   $do=true;
                    }
                }
                if($do) {
                    $diff_rate = ($new['p'] - $new['c']) ? number_format(($new['p'] - $new['c']) / $new['c'] * 100, 2, ".", "") : 0.00;
                    $data = [
                        'price' => $new['p'],
                        'open' => $new['o'],
                        'high' => $new['h'],
                        'low' => $new['l'],
                        'close' => $new['c'],
                        'diff' => $new['p'] - $new['c'],
                        'diff_rate' => $diff_rate,
                        'time' => date('Y-m-d H:i:s', $new['t'])
                    ];
                    $this->insert($Table[$key]['table_name'], $data);
                }
            }
        }

        //$this->listen();
    }
  public function pingcang(){
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
