<?php

use Workerman\Worker;
use Workerman\Connection\AsyncTcpConnection;


// function error(){
//     throw new Exception("error");
// }
// set_error_handler('error');
$path = dirname(dirname(dirname(__DIR__)));
require_once __DIR__ . '/Autoloader.php';

class Data
{
    public static $pongTime = null;
    public static $pingTime = null;
    public static $config = [
    ];
    public static $redis = null;
    public $worker = null;

    public function __construct(){



        $this->worker = new Worker();
        // self::$redis = new redis();
        // self::$redis->connect('127.0.0.1',6379);
        $this->onWorkerStart();
    }

    public function onWorkerStart(){

        $this->worker->onWorkerStart = function($worker) {

            $c = new AsyncTcpConnection("ws://150.109.60.183:8686");
            $c->onConnect = function ($con){
                
            };
            $c->onMessage = function ($con, $msg){
                $data = json_decode($msg,1);
                $newProduct = $data['body'];

                $bat = '';
                switch ($newProduct['StockCode']) {
                    case 'NECLA0'://美原油
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert necla0 ".$c;
                        echo 'y';
                        exec($bat);
                        break;
                    case 'CMGCA0'://美黄金
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert cmgca0 ".$c;
                        echo 'j';
                        exec($bat);
                        break;
                    case 'CEDAXA0'://德指
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert cedaxa0 ".$c;
                        echo 'd';
                        exec($bat);
                        break;
                    case 'HIHSIF'://恒指
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert hihsif ".$c;
                        echo 'h';
                        exec($bat);
                        
                        break;
                    case 'CENQA0'://小纳指
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert yb ".$c;
                        echo 'n';
                        exec($bat);
                        break;
                    case 'CEYMA0'://小道指
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert ay ".$c;
                        echo 'z';
                        exec($bat);
                        break;

                    default:
                        # code...
                        break;
                }
                /*if($bat){
                    exec($bat);
                }*/
                
                
                /*if($newProduct['StockCode'] == 'NECLA0'){
                        $data = [
                            'price' => $newProduct['Price'],
                            'open' => $newProduct['Open'],
                            'high' => $newProduct['High'],
                            'low' => $newProduct['Low'],
                            'close' => $newProduct['LastClose'],
                            'diff' => $newProduct['Diff'],
                            'diff_rate' => $newProduct['DiffRate'],
                            'time' => $newProduct['LastTime']//date('Y-m-d H:i:s',$newProduct['LastTime'])
                        ];
                        $v = [];
                        foreach ($data as $key => $value) {
                            $v[] = $value;
                        }
                        $c = implode(',', $v);
                        
                        $bat = "php D:\www\qihuo1\yii init/insert necla0 ".$c;
                       

                       exec($bat);
                        
                        echo '.';

                }
*/
                
                
            };
            $c->onError = function($con,$err){
                
            };
            $c->onClose = function($con){
                
            };
            $c->connect();
        };
            
       $this->onConnect();
    }

    public function onMessage(){
        $this->worker->onMessage =  function($connection, $data)
        {
            $connection->send('receive success');
        };
    }
    public function onConnect(){
        $this->worker->onConnect = function($connection)
        {

        };
    }
    public function close($connection){
        $connection->close("Error");
    }
    public function toAll($data){
        // 遍历当前进程所有的客户端连接，发送
        foreach($this->worker->connections as $connection)
        {
            $connection->send(json_encode($data));
        }
    }
}
new Data();
Worker::runAll();