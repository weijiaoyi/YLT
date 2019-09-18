<?php

namespace console\controllers;

use common\helpers\System;
use console\models\Gather;
use console\models\GatherHuobi;
use console\models\GatherSina;
use console\models\GatherSinaStock;
use console\models\GatherJctytech;
use console\models\GatherXinfu;
use console\models\GatherYiyuan;


class InitController extends \common\components\ConsoleController {
	public function actionUser() {
		echo 'Input User Info' . "\n";

		$username = $this->prompt('Input Username:');
		$password = $this->prompt('Input password:');

		$user = new \frontend\models\User;

		$user->username = $username;
		$user->password = $password;
		$user->setPassword();

		if (!$user->save()) {
			foreach ($user->getErrors() as $field => $errors) {
				array_walk($errors, function ($error) {
					echo "$error\n";
				});
			}
		}
	}

	public function actionHq() {
		// echo "string";
      // $cnt=0;
        $path = System::isWindowsOs() ? '' : './';
        while (true) {
        	echo ".";
			// $cnt++;
            exec('php /www/wwwroot/qihuo/yii init/gatherpingcang');
			// echo exec('D:\phpStudy\php55\php E:\phproot\qihuo1\yii init/gather7');
            sleep(2);
			// if($cnt>60)break;
        }
      
	}
	public function actionInsert($name,$data){
/*		echo '11';
		var_dump($name);
		echo '----------------------------------';
		var_dump($data);*/

		$resault  =  explode(',',$data);//($data,1);
		$data = [
                            'price' => $resault['0'],
                            'open' => $resault['1'],
                            'high' => $resault['2'],
                            'low' => $resault['3'],
                            'close' => $resault['4'],
                            'diff' => $resault['5'],
                            'diff_rate' => $resault['6'],
                            'time' => date('Y-m-d H:i:s',$resault['7'])
                        ];
		$gather = new Gather();
		$gather->insert($name,$data);
		//$gather->listen();

	}

	public function actionGather() {
		$gather = new GatherSina;
		$gather->run();
	}
 	public function actionGatherpingcang() {
		$gather = new GatherSina;
		$gather->pingcang();
	}

	public function actionGather2() {
		$gather = new GatherXinfu;
		$gather->run();
	}

	public function actionGather3() {
		$gather = new GatherSinaStock;
		$gather->run();
	}

	public function actionGather4() {
		$gather = new GatherYiyuan;
		$gather->run();
	}

	public function actionGather6() {

		$gather = new GatherHuobi;
		$gather->run();
	}
   public function actionGather7() {

		$gather = new GatherJctytech;
		$gather->run();
	}
}
