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
            // var_dump($tableName);
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

            $newUrl = 'http://47.98.243.197:8080/HelloQuoteWebServer/quoteList?_='.time();
            // var_dump ($url);
        
            $result = $this->getHtml($url);
            $newResult = $this->getHtml($newUrl);
            $jsonResult = json_decode($newResult);
            // var_dump($jsonResult);

            //[{"symbol":"GLNC","name":"美黄金","dateTime":"2018-12-21 14:20:13","bid1Price":1262.2,"bid1Volume":7,"ask1Price":1262.3,"ask1Volume":27,"open":1263.5,"high":1266.2,"low":1261.9,"close":1262.2,"change":-5.7000000000000455,"changeRate":"-0.45%","pClose":1267.9,"pSettlementPrice":1267.9,"volume":23548,"turnover ":323550},
            //{"symbol":"MGLNC","name":"Mini黄金","dateTime":"2018-12-21 14:20:13","bid1Price":1262.2,"bid1Volume":7,"ask1Price":1262.3,"ask1Volume":27,"open":1263.5,"high":1266.2,"low":1261.9,"close":1262.2,"change":-5.7000000000000455,"changeRate":"-0.45%","pClose":1267.9,"pSettlementPrice":1267.9,"volume":23548,"turnover ":323550},
            //{"symbol":"CONC","name":"美原油","dateTime":"2018-12-21 14:20:13","bid1Price":46.19,"bid1Volume":7,"ask1Price":46.2,"ask1Volume":16,"open":46.25,"high":46.77,"low":46.13,"close":46.19,"change":0.30999999999999517,"changeRate":"0.68%","pClose":45.88,"pSettlementPrice":45.88,"volume":40940,"turnover ":413278},
            //{"symbol":"MCONC","name":"Mini原油","dateTime":"2018-12-21 14:20:13","bid1Price":46.19,"bid1Volume":7,"ask1Price":46.2,"ask1Volume":16,"open":46.25,"high":46.77,"low":46.13,"close":46.19,"change":0.30999999999999517,"changeRate":"0.68%","pClose":45.88,"pSettlementPrice":45.88,"volume":40940,"turnover ":413278},
            //{"symbol":"HZH1","name":"恒指","dateTime":"2018-12-21 14:20:14","bid1Price":25567,"bid1Volume":7,"ask1Price":25569,"ask1Volume":3,"open":25469,"high":25640,"low":25307,"close":25568,"change":28,"changeRate":"0.11%","pClose":25540,"pSettlementPrice":25540,"volume":6.49059737E9,"turnover ":109404},
            //{"symbol":"MHK1","name":"Mini恒指","dateTime":"2018-12-21 14:20:13","bid1Price":25568,"bid1Volume":2,"ask1Price":25570,"ask1Volume":6,"open":25500,"high":25636,"low":25306,"close":25568,"change":56,"changeRate":"0.22%","pClose":25512,"pSettlementPrice":25512,"volume":2.749015275E9,"turnover ":10503},
            //{"symbol":"YMCC","name":"Mini道指","dateTime":"2018-12-21 14:20:07","bid1Price":22973,"bid1Volume":3,"ask1Price":22975,"ask1Volume":2,"open":23040,"high":23072,"low":22935,"close":22974,"change":-23,"changeRate":"-0.10%","pClose":22997,"pSettlementPrice":22997,"volume":0,"turnover ":0},
            //{"symbol":"NQE0","name":"Mini纳指","dateTime":"2018-12-21 14:20:12","bid1Price":6301,"bid1Volume":3,"ask1Price":6301.5,"ask1Volume":3,"open":6325,"high":6333.5,"low":6288,"close":6301,"change":-24.25,"changeRate":"-0.38%","pClose":6325.25,"pSettlementPrice":6325.25,"volume":0,"turnover ":0},
            //{"symbol":"DAXC","name":"Mini德指","dateTime":"2018-12-21 14:20:00","bid1Price":10547.5,"bid1Volume":1,"ask1Price":10550.5,"ask1Volume":2,"open":10543.5,"high":10598,"low":10525.5,"close":10553,"change":9.5,"changeRate":"0.09%","pClose":10543.5,"pSettlementPrice":10543.5,"volume":0,"turnover ":0}]


            if(in_array($info['code'], array('GLNC','MGLNC','CONC','MCONC','HZH1','MHK1','YMCC','NQE0','DAXC'))){
                // echo "石油——————————————————————————————————————\n";
                if($jsonResult){
                    for($j = 0;$j<sizeof($jsonResult);$j++){
                        if($jsonResult[$j]->symbol ==  $info['code']){
                            $newProduct = $jsonResult[$j];
                            break;
                        }
                    }
                    var_dump($newProduct);
                    // if($newProduct){
                        echo "newProduct--------------------------\n";
                        $data = [
                            'price' => $newProduct->close,
                            'open' => $newProduct->open,
                            'high' => $newProduct->high,
                            'low' => $newProduct->low,
                            'close' => $newProduct->pClose,
                            'diff' => $newProduct->change,
                            'diff_rate' => $newProduct->changeRate,
                            'time' => $newProduct->dateTime
                        ];
                        var_dump($data);
                        $this->insert($info['table_name'], $data);

                    // }
                    
                }
                // continue;
            }
            // echo "string";
            // break;

            else if ($result) {
                $resultarr = explode(',', $result);
                // print_r($resultarr);
                if(sizeof($resultarr) < 3) {
                    continue;
                }    
                // if(in_array($info['code'], array('hf_CL','hf_NG','hf_HG', 'hf_GC', 'hf_HSI','hf_CAD','hf_XAG','hf_CHA50CFD'))) {
                if(in_array($info['code'], array('hf_NG','hf_HG', 'hf_GC', 'hf_HSI','hf_CAD','hf_XAG','hf_CHA50CFD'))) {
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
