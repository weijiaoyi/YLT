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
        
         // echo(json_encode($products));

         // exit();

        $this->productList = array_merge($this->productList, $products);
     // var_dump($this->productList);
        $tableSize = sizeof($this->productList);
        echo "$tableSize";
        // foreach ($this->productList as $tableName => $info) {
        for ($i = 0;$i<$tableSize;$i++) {
            $tableName = $i;
            $info = $this->productList[$i];
            echo "-----------------------------------------";
            var_dump($tableName);
            var_dump($info);
            // exit();
               

            $start = strtotime(date('Y-m-d 00:00:00', time()));
            if ($info['trade_time'] && $info['code'] != 'fx_sgbpusd') {
                $timeArr = unserialize($info['trade_time']);
                $start = strtotime(date('Y-m-d ' . $timeArr[0]['start'] . ':00'));
                $time = end($timeArr);
                $end = strtotime(date('Y-m-d ' . $time['end'] . ':00'));
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
            $url = 'http://hq.sinajs.cn/?_='.time().'1000&list='.$info['code'];
            // var_dump ($url);
        
            $result = $this->getHtml($url);
            var_dump($result);

            if ($result) {
                $resultarr = explode(',', $result);
                print_r($resultarr);
                if(sizeof($resultarr) < 3) {
                    continue;
                }    
                if(in_array($info['code'], array('hf_CL','hf_NG','hf_HG', 'hf_GC', 'hf_HSI','hf_CAD','hf_XAG','hf_CHA50CFD'))) {
                    $price = explode('"', $resultarr[0])[1];
                    $diff = $price - $resultarr[7];
                    if($diff == 0) {
                        $diff_rate = 0.00;
                    } else {
                        $diff_rate = $resultarr[1];
                    }
                    if($info['code']=="hf_CL"){
                        $price = $price + 0.3;
                    }
                    $data = [
                        'price' => $price,
                        'open' => $resultarr[8],
                        'high' => $resultarr[4],
                        'low' => $resultarr[5],
                        'close' => $resultarr[7],
                        'diff' => $diff,
                        'diff_rate' => $diff_rate,
                        'time' => $resultarr[12]." " .$resultarr[6]
                    ];

                } elseif($info['code'] == 'rt_hkHSI') {
                    $price = $resultarr[6];
                    $diff = $resultarr[7];
                    $diff_rate = $resultarr[8];
                    $dtime = strtotime($resultarr[sizeof($resultarr) - 2] ." " .explode('"', $resultarr[sizeof($resultarr) - 1])[0]);
                    $data = [
                        'price' => $price,
                        'open' => $resultarr[2],
                        'high' => $resultarr[4],
                        'low' => $resultarr[5],
                        'close' => $resultarr[3],
                        'diff' => $diff,
                        'diff_rate' => $diff_rate,
                        'time' => date('Y-m-d H:i:s', $dtime)
                    ];
                } elseif($info['code'] == 'hkHSI') {
                    $price = $resultarr[6];
                    $diff = $resultarr[7];
                    $diff_rate = $resultarr[8];
                    $dtime = strtotime($resultarr[sizeof($resultarr) - 2] ." " .explode('"', $resultarr[sizeof($resultarr) - 1])[0]);
                    $data = [
                        'price' => $price,
                        'open' => $resultarr[2],
                        'high' => $resultarr[4],
                        'low' => $resultarr[5],
                        'close' => $resultarr[3],
                        'diff' => $diff,
                        'diff_rate' => $diff_rate,
                        'time' => date('Y-m-d H:i:s', $dtime)
                    ];
                } elseif(in_array($info['code'], array('fx_seurusd', 'fx_sgbpusd', 'fx_saudusd', 'fx_scadusd'))) {
                    $price = $resultarr[1];
                    $diff = $price - $resultarr[3];
                    if($diff == 0) {
                        $diff_rate = 0.00;
                    } else {
                        $diff_rate = number_format($diff / $resultarr[3] * 100, 2, ".", "");
                    }
                    $dtime = strtotime(explode('"', $resultarr[sizeof($resultarr) - 1])[0]." " .explode('"', $resultarr[0])[1]);
                    $data = [
                        'price' => $price,
                        'open' => $resultarr[5],
                        'high' => $resultarr[6],
                        'low' => $resultarr[8],
                        'close' => $resultarr[3],
                        'diff' => $diff,
                        'diff_rate' => $diff_rate,
                        'time' => date('Y-m-d H:i:s', $dtime)
                    ];
                } elseif(in_array($info['code'], array('DINIW'))) {
                    $price = $resultarr[1];
                    $diff = $price - $resultarr[3];
                    if($diff == 0) {
                        $diff_rate = 0.00;
                    } else {
                        $diff_rate = number_format($diff / $resultarr[3] * 100, 2, ".", "");
                    }
                    $dtime = strtotime(explode('"', $resultarr[sizeof($resultarr) - 1])[0]." " .explode('"', $resultarr[0])[1]);
                    $data = [
                        'price' => $price,
                        'open' => $resultarr[5],
                        'high' => $resultarr[6],
                        'low' => $resultarr[8],
                        'close' => $resultarr[3],
                        'diff' => $diff,
                        'diff_rate' => $diff_rate,
                        'time' => date('Y-m-d H:i:s', $dtime)
                    ];
                }

                var_dump($data);
                
                $this->insert($info['table_name'], $data);
            }
                
            
        }
        // 监听是否有人应该平仓
        $this->listen();
    }

    protected function getHtml($url, $options = null)
    {
        $options[CURLOPT_HTTPHEADER] = ['Referer: http://hq.sinajs.cn'];
        return Curl::get($url, $options);
    }
}
