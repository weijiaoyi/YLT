<?php
/**
 * Created by PhpStorm.
 * User: 10
 * Date: 2019/8/23
 * Time: 10:58
 */

namespace frontend\models;


use yii\db\ActiveRecord;

class OfflinePayment extends ActiveRecord
{
    public $start_time;
    public $end_time;


    public function listQuery()
    {
        return $this->search()
            //->andWhere(['charge_state' => UserCharge::CHARGE_STATE_PASS])
            ->andFilterWhere(['>=', 'userCharge.created_at', $this->start_time])
            ->andFilterWhere(['<=', 'userCharge.created_at', $this->end_time]);
    }
}