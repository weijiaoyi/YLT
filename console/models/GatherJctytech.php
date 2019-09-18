<?php

namespace console\models;

use admin\models\Order;
use common\models\Product;
use frontend\models\User;

class GatherJctytech extends Gather {
	public $urlPrefix = 'http://dt.jctytech.com/stock.php?u=1095555059&type=stock';
	public $productList = [
		// 'hihsif' => 'HIHSIF', //大恒指
		// 'himhif' => 'HIMHIF', //小恒指
		// 'necla0' => 'NECLA0', //美原油
		// 'necli0' => 'NECLI0', //小原油
		//'nenga0' => 'NENGA0', //天然气
		//'cmgca0' => 'CMGCA0', //美黄金
		// 'cmhga0' => 'CMHGA0', //美精铜
		//'cmsia0' => 'CMSIA0', //美白银
		// 'cmgci0' => 'CMGCI0', //小黄金
		// 'cmsii0' => 'CMSII0', //小白银
		// 'wicmjya0' => 'WICMJYA0', //日元
		// 'wicmeca0' => 'WICMECA0', //欧元
		// 'wicmbpa0' => 'WICMBPA0', //英镑
		// 'cenqa0' => 'CENQA0', //迷你纳指
		// 'cedaxa0' => 'CEDAXA0', //小德指   毫无作用。。。。。。
	];

	public function run() {

        User::find()->asArray()->all();

	    $userid=0;

        $user_fee=Order::find()->joinWith(['user'])->where(['user_id'=>$userid])->manager()->select('SUM(fee) fee')->one()->fee ?: null;

//        $user_fee=Order::find()->joinWith(['user'])->manager()->select('SUM(fee) fee')->one()->fee ?: null;
	}

}
