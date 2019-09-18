<?php

namespace admin\controllers;

use admin\models\UserCard;
use admin\models\BankCard;
use frontend\models\OfflinePayment;
use Yii;
use admin\models\User;
use admin\models\Order;
use admin\models\Product;
use admin\models\AdminUser;
use admin\models\UserCoupon;
use admin\models\UserCharge;
use admin\models\UserRebate;
use admin\models\UserWithdraw;
use admin\models\UserExtend;
use admin\models\Retail;
use common\helpers\Hui;
use common\helpers\Html;
use yii\base\Object;

class UserController extends \admin\components\Controller
{

    /**
     * @authname 会员列表
     */
    public function actionList()
    {

        $query = (new User)->listQuery()->manager();

        $html = $query->getTable([
            u()->power < AdminUser::POWER_ADMIN?'':['type' => 'checkbox'],
            'id',
            'nickname' => ['type' => 'text'],
            'mobile',
            'pid' => ['header' => '推荐人id'],
            'admin.username' => ['header' => '代理商账号'],
            'admin.pid' => ['header' => '综会账号', 'value' => function ($row) {
                return $row->getLeaderName($row->admin_id);
            }],
            'account',
          	'blocked_account',
            'profit_account',
            'loss_account'=>['header'=>'总贡献'],
            'all_fee'=>['header'=>'总手续费'],
            'created_at',
            //'login_time',
            'state' => ['search' => 'select'],
            ['header' => '操作', 'width' => '240px', 'value' => function ($row) {
                if ($row['state'] == User::STATE_VALID) {
                    $deleteBtn = Hui::dangerBtn('冻结', ['deleteUser', 'id' => $row->id], ['class' => 'deleteBtn']);
                } else {
                    $deleteBtn = Hui::successBtn('恢复', ['deleteUser', 'id' => $row->id], ['class' => 'deleteBtn']);
                }


                if ($row['bank_status'] =='1') {
                    $examineBtn = Hui::dangerBtn('待审核', ['userDataToExamine', 'id' => $row->id], ['class' => 'userDataToExamine']);
                } elseif($row['bank_status'] =='2') {
                    $examineBtn = Hui::successBtn('已经通过', ['userDataToExamine', 'id' => $row->id], ['class' => 'userDataToExamine']);
                }elseif($row['bank_status'] =='-1') {
                    $examineBtn = Hui::dangerSpan('已经否决');
                }


                return implode(str_repeat('&nbsp;', 4), [
                    Hui::primaryBtn('修改密码', ['editUserPass', 'id' => $row->id], ['class' => 'editBtn']),
                    Hui::primaryBtn('修改代理商', ['moveUser', 'id' => $row->id], ['class' => 'moveBtn']),
                    Hui::primaryBtn('冲正', ['chongzhengUser', 'id' => $row->id], ['class' => 'chongzhengBtn']),
//                 	Hui::primaryBtn('审核资料', ['userDataToExamine', 'id' => $row->id], ['class' => 'userDataToExamine']),
                    $deleteBtn,
                    $examineBtn
                ]);
            }]
        ], [
            'searchColumns' => [
                'id',
//                'bank_status',
                'nickname',
                'mobile',
                'pid' => ['header' => '推荐人id'],
                'admin.username' => ['header' => '代理商账号'],
                'leader' => ['header' => '综会账号'],
                'start_time' => ['type' => 'datepicker'],
                'bank_status',
            ]

        ]);
//        $commandQuery = clone $query;
//        echo $commandQuery->createCommand()->getRawSql();
        // 会员总数，总手数，总余额,总盈利，总亏损
        $count = User::find()->manager()->count();
        $hand = Order::find()->joinWith(['user'])->manager()->select('SUM(hand) hand')->one()->hand ?: 0;
//
        $amount = User::find()->manager()->select('SUM(account) account')->one()->account ?: 0;
//         $profit_account = User::find()->manager()->select('SUM(account) account')->one()->profit_account ?: 0;
//         $loss_account = User::find()->manager()->select('SUM(account) account')->one()->loss_account ?: 0;
        return $this->render('list', compact('html', 'count', 'hand', 'amount', 'profit_account', 'loss_account','user_fee'));
    }

    /**
     * @authname 用户信息导出
     */

    public function actionUserExcel()
    {
        ini_set("memory_limit", "10000M");
        set_time_limit(0);
        require Yii::getAlias('@vendor/PHPExcel/Classes/PHPExcel.php');
        //获取数据
        // $query = (new User)->listQuery()->manager()->andWhere('user.id > 102200');
        $query = (new User)->listQuery()->manager();
        $count = (new User)->listQuery()->manager()->count();
        $data = $query->all();
        $n = 3;
        //加载PHPExcel插件
        $Excel = new \PHPExcel();
        $Excel->setActiveSheetIndex(0);
        //编辑表格    标题
        $Excel->setActiveSheetIndex(0)->mergeCells('A1:J1');
        $Excel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $Excel->setActiveSheetIndex(0)->getStyle('A1')->getFont()->setSize(20);
        $Excel->setActiveSheetIndex(0)->getStyle('A1')->getFont()->setName('黑体');
        $Excel->getActiveSheet()->setCellValue('A1',config('web_name').'-用户信息统计表');
        //表头
        $Excel->getActiveSheet()->getStyle('I')->getNumberFormat()->setFormatCode(\PHPExcel_Style_NumberFormat::FORMAT_NUMBER_00);
        $Excel->setActiveSheetIndex(0)->getStyle('A2:D2')->getFont()->setBold(true);
        $Excel->setActiveSheetIndex(0)->setCellValue('A2','用户的ID');
        $Excel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $Excel->setActiveSheetIndex(0)->setCellValue('B2','昵称');
        $Excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('C2','手机号');
        $Excel->getActiveSheet()->getColumnDimension('C')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('D2','余额');
        $Excel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('E2','推荐ID');
        $Excel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('F2','冻结金额');
        $Excel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('G2','总盈利');
        $Excel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('H2','总贡献');
        $Excel->getActiveSheet()->getColumnDimension('H')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('I2','注册时间');
        $Excel->getActiveSheet()->getColumnDimension('I')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('J2','总手续费');
        $Excel->getActiveSheet()->getColumnDimension('J')->setWidth(25);
        //内容
        foreach ($data as $val) {
            $Excel->setActiveSheetIndex(0)->setCellValue('A'.$n, $val->id);
            if (strpos($val->nickname, '=') === 0){
                $val->nickname = "nanqe" . $val->nickname;
            }
            $Excel->setActiveSheetIndex(0)->setCellValue('B'.$n, $val->nickname); // 真实姓名
            $Excel->setActiveSheetIndex(0)->setCellValue('C'.$n, $val->mobile); // 联系电话
            $Excel->setActiveSheetIndex(0)->setCellValue('D'.$n, $val->account);  // 余额
            $Excel->setActiveSheetIndex(0)->setCellValue('E'.$n, $val->pid);  // 推荐人ID
            $Excel->setActiveSheetIndex(0)->setCellValue('F'.$n, $val->blocked_account);//  冻结金额
            $Excel->setActiveSheetIndex(0)->setCellValue('G'.$n, $val->profit_account); //  总盈利
            $Excel->setActiveSheetIndex(0)->setCellValue('H'.$n, $val->loss_account);
            $Excel->setActiveSheetIndex(0)->setCellValue('I'.$n, $val->created_at);
            $Excel->setActiveSheetIndex(0)->setCellValue('J'.$n, $val->all_fee);
            $n++;
            $Excel->getActiveSheet()->getRowDimension($n+1)->setRowHeight(18);
        }
        //统计
        $Excel->setActiveSheetIndex(0)->mergeCells('A'.$n.':J'.$n);
        $Excel->getActiveSheet()->setCellValue('A'.$n,'统计'.$count.'人');
        $Excel->setActiveSheetIndex(0)->getStyle('A'.$n)->getFont()->setBold(true);
        //格式
        $Excel->getActiveSheet()->getStyle('A2:J'.$n)->getBorders()->getAllBorders()->setBorderStyle(\PHPExcel_Style_Border::BORDER_THIN);
        //导出表格
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition:attachment;filename="'.config('web_name').'-用户信息统计表.xls');
        header('Cache-Control: max-age=0');
        $objWriter= \PHPExcel_IOFactory::createWriter($Excel,'Excel5');
        $objWriter->save('php://output');
    }

    /**
     * @authname 修改会员密码
     */
    public function actionEditUserPass() 
    {
        $user = User::findModel(get('id'));
        $user->password = md5(post('password'));
        if($user->update(false))
        {
            return success();
        }
        else
        {
            return error($user);
        }



        // if ($user->validate()) {
        //     $user->hashPassword()->update(false);
        //     return success();
        // } else {
        //     return error($user);
        // }
    }
   public function actionChongzhengUser() 
    {
     
         if(u()->power < AdminUser::POWER_ADMIN){
            return error('无权限！');
         }
        $user = User::findModel(get('id'));
        $user->account =  $user->account + post('money');
    	$user->blocked_account =  $user->blocked_account + post('money');

        if($user->update(false))
        {
            return success();
        }
        else
        {
            return error($user);
        }
    }
    /**
     * @authname 修改会员代理商
     */
    public function actionMoveUser() 
    {
        $user = User::findModel(get('id'));
        $user->admin_id = post('admin_id');
        $admin=AdminUser::find()->where(['id'=>post('admin_id'),'power'=>9997])->one();
        if(!empty($admin))
        {
            if ($user->update(false)) {
            return success();
         } else {
            return error($user);
         }
        }
        else
        {
            return error('代理不存在');
        }
        
    }

    /**
     * @authname 冻结/恢复用户
     */
    public function actionDeleteUser() 
    {
        $user = User::find()->where(['id' => get('id')])->one();

        if ($user->toggle('state')) {
            return success('冻结成功！');
        } else {
            return success('账号恢复成功！');
        }
    }
    public function actionDeleteAll() 
    {
        $ids = post('list');
        foreach ($ids as $key => $value) {
            $model = User::findOne($value);
            $model->delete();          
        }
        return success('删除成功！');
        
    }

    /**
     * @authname 赠送优惠券
     */
    public function actionSendCoupon()
    {
        $ids = post('ids');

        // 送给所有人
        if (!$ids) {
            $ids = User::find()->map('id', 'id');
        }
        UserCoupon::sendCoupon($ids, post('coupon_id'), post('number') ?: 1);
        return success('赠送成功');
    }

    /**
     * @authname 会员持仓列表
     */
    public function actionPositionList()
    {
        $query = (new User)->listQuery()->andWhere(['user.state' => User::STATE_VALID])->manager();

        $order = [];
        $html = $query->getTable([
            'id',
            'nickname' => ['type' => 'text'],
            'mobile',
            ['header' => '盈亏', 'value' => function ($row) use (&$order) {
                $order = Order::find()->where(['user_id' => $row['id'], 'order_state' => Order::ORDER_POSITION])->select(['SUM(hand) hand', 'SUM(profit) profit'])->one();
                if ($order->profit == null) {
                    return '无持仓';
                } elseif ($order->profit >= 0) {
                    return Html::redSpan($order->profit);
                } else {
                    return Html::greenSpan($order->profit);
                }
            }],
            ['header' => '持仓手数', 'value' => function ($row) use (&$order) {
                if ($order->hand == null) {
                    return '无持仓';
                } else {
                    return $order->hand;
                }
            }],
            'account',
            'state'
        ], [
            'searchColumns' => [
              'id',
                'nickname',
                'mobile',
                'created_at' => ['type' => 'date']
            ]
        ]);

        return $this->render('positionList', compact('html'));
    }

    /**
     * @authname 会员赠金
     */
    public function actionGiveList()
    {
        if (req()->isPost) {
            $user = User::findModel(get('id'));
			$type = get('type');
          	$parm = post('amount');
          	$parmArr = explode("|",$parm);
          if(count($parmArr)!=2){
          	return ;
          }
          $addmoney = $parmArr[0];
			if($type == 1){
				$user->account +=  $addmoney ;
				$user->update();
				return success();
			}
            $user->account += $addmoney ;
            if ($user->update()) {
				$amount =  $addmoney ;
				$id = get('id');
				$tradeno = $id.time().rand(111,999);

				//保存充值记录
				$userCharge = new UserCharge();
				$userCharge->user_id = $id;
				$userCharge->trade_no = $tradeno;
				$userCharge->amount = $amount;
				//1支付宝2微信3银行卡
				$userCharge->charge_type = 3;
              	$userCharge->remark= $parmArr[1];
				//充值状态：1待付款，2成功，-1失败
				$userCharge->charge_state = 2;
				if (!$userCharge->save()) {
					return false;
				}
		
                return success();
            } else {
                return error($user);
            }
        }

        $query = (new User)->listQuery()->andWhere(['user.state' => User::STATE_VALID]);

        $html = $query->getTable([
            'id',
            'nickname',
            'mobile',
            
            'account' => ['header' => '资金'],
            ['header' => '操作', 'width' => '40px', 'value' => function ($row) {
                return Hui::primaryBtn('赠金', ['', 'id' => $row['id']], ['class' => 'giveBtn']);
            }],
            ['header' => '资金修改', 'width' => '40px', 'value' => function ($row) {
                return Hui::primaryBtn('修正', ['', 'id' => $row['id'],'type' => 1], ['class' => 'giveBtn']);
            }]			
        ], [
            'searchColumns' => [
              'id',
                'nickname',
                'mobile'
            ]
        ]);

        return $this->render('giveList', compact('html'));
    }

    /**
     * @authname 会员出金管理
     */
    public function actionWithdrawList()
    {
//        $query = (new UserCharge)->listQuery()->joinWith(['user.parent', 'user.admin'])->manager()->orderBy('userCharge.id DESC');
        $query = (new UserWithdraw)->listQuery()->joinWith(['user.parent', 'user.admin'])->orderBy('userWithdraw.created_at DESC');
//        $countQuery = (new UserCharge)->listQuery()->joinWith(['user.admin'])->manager();
        $countQuery = (new UserWithdraw)->listQuery()->joinWith(['user.admin'])->andWhere(['op_state' => UserWithdraw::OP_STATE_PASS]);
        $count = $countQuery->select('SUM(amount) amount')->one()->amount ?: 0;

        $html = $query->getTable([
            'user.id',
            'user.nickname',
            'user.mobile',
            'user.account',
            'amount' => '出金金额',
            'amount_summation'=>'累计提现',
            'amount_recharge'=>'累计贡献',
            'created_at',
            'op_state' => ['search' => 'select'],
            ['header' => '操作', 'width' => '70px', 'value' => function ($row) {
                if ($row['op_state'] == UserWithdraw::OP_STATE_WAIT) {
                    return Hui::primaryBtn('会员出金', ['user/verifyWithdraw', 'id' => $row['id']], ['class' => 'layer.iframe']);
                } else {
                    return Html::successSpan('已审核');
                }
            }]
        ], [
            'searchColumns' => [
                'user.id',
                'user.pid',
                'user.nickname',
                'user.mobile',
                'admin.username' => ['header' => '代理商账号'],
                'time' => ['header' => '审核时间', 'type' => 'dateRange']
            ],
            'ajaxReturn' => [
                'count' => $count
            ]
        ]);
        

        return $this->render('withdrawList', compact('html', 'count'));
    }

    /**
     * @authname 用户出金信息导出
     */
    public function actionWithdrawExcel()
    {
        ini_set("memory_limit", "10000M");
        set_time_limit(0);
        require Yii::getAlias('@vendor/PHPExcel/Classes/PHPExcel.php');
        //获取数据
        //        $query = (new UserCharge)->listQuery()->joinWith(['user.parent', 'user.admin'])->manager()->orderBy('userCharge.id DESC');
        $query = (new UserWithdraw)->listQuery()->joinWith(['user.parent', 'user.admin'])->orderBy('userWithdraw.created_at DESC');
//        $countQuery = (new UserCharge)->listQuery()->joinWith(['user.admin'])->manager();
        $countQuery = (new UserWithdraw)->listQuery()->joinWith(['user.admin'])->andWhere(['op_state' => UserWithdraw::OP_STATE_PASS]);
        $count = $countQuery->select('SUM(amount) amount')->one()->amount ?: 0;
        $data = $query->all();

        $n = 3;
        //加载PHPExcel插件
        $Excel = new \PHPExcel();
        $Excel->setActiveSheetIndex(0);
        //编辑表格    标题
        $Excel->setActiveSheetIndex(0)->mergeCells('A1:G1');
        $Excel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $Excel->setActiveSheetIndex(0)->getStyle('A1')->getFont()->setSize(20);
        $Excel->setActiveSheetIndex(0)->getStyle('A1')->getFont()->setName('黑体');
        $Excel->getActiveSheet()->setCellValue('A1',config('web_name').'-出金信息统计表');
        //表头
        $Excel->getActiveSheet()->getStyle('E')->getNumberFormat()->setFormatCode(\PHPExcel_Style_NumberFormat::FORMAT_NUMBER_00);
        $Excel->setActiveSheetIndex(0)->getStyle('A2:D2')->getFont()->setBold(true);
        $Excel->setActiveSheetIndex(0)->setCellValue('A2','用户的ID');
        $Excel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $Excel->setActiveSheetIndex(0)->setCellValue('B2','昵称');
        $Excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('C2','手机号');
        $Excel->getActiveSheet()->getColumnDimension('C')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('D2','出金金额');
        $Excel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('E2','申请时间');
        $Excel->getActiveSheet()->getColumnDimension('E')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('F2','审核状态');
        $Excel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
        $opState = UserWithdraw::getOpStateMap();
        //内容
        foreach ($data as $val) {
            $Excel->setActiveSheetIndex(0)->setCellValue('A'.$n, $val->user->id);
            if (strpos($val->user->nickname, '=') === 0){
                $val->user->nickname = "nanqe" . $val->user->nickname;
            }

            $Excel->setActiveSheetIndex(0)->setCellValue('B'.$n, $val->user->nickname);
            $Excel->setActiveSheetIndex(0)->setCellValue('C'.$n, $val->user->mobile);
            $Excel->setActiveSheetIndex(0)->setCellValue('D'.$n, $val->amount);
            $Excel->setActiveSheetIndex(0)->setCellValue('E'.$n, $val->created_at);
            $Excel->setActiveSheetIndex(0)->setCellValue('F'.$n, $opState[$val->op_state]);
            $n=$n+1;
            $Excel->getActiveSheet()->getRowDimension($n)->setRowHeight(18);
        }
//            dump($n);
        //统计
        $Excel->setActiveSheetIndex(0)->mergeCells('A'.$n.':F'.$n);
        $Excel->getActiveSheet()->setCellValue('A'.$n,'总出金额度'.$count.'元');
        $Excel->setActiveSheetIndex(0)->getStyle('A'.$n)->getFont()->setBold(true);
        //格式
        $Excel->getActiveSheet()->getStyle('A2:F'.$n)->getBorders()->getAllBorders()->setBorderStyle(\PHPExcel_Style_Border::BORDER_THIN);
        //导出表格
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition:attachment;filename="'.config('web_name').'-出金信息统计表.xls');
        header('Cache-Control: max-age=0');
        $objWriter= \PHPExcel_IOFactory::createWriter($Excel,'Excel5');
        $objWriter->save('php://output');
    }

    /**
     * @authname 会员出金操作
     */
    public function actionVerifyWithdraw($id)
    {
        $model = UserWithdraw::find()->with('user.userAccount')->where(['id' => $id])->one();
        // var_dump($model);
        // exit();
        if (req()->isPost) {
            // echo "0";
            // exit();
            $model->op_state = post('state');
            if ($model->op_state == UserWithdraw::OP_STATE_PASS){
                $amount=$model->amount;
                $uid=$model->user_id;
                // 查询提现记录
                $model_arr = UserWithdraw::find()->with('user.userAccount')->where(['user_id' => $uid,'op_state'=>2])->asArray()->orderBy('id DESC')->all();
                if ($model_arr[0]['amount_summation']==null){
                    $amount_summation_all=0;
                    foreach ($model_arr as $key => $value){
                        if ($value['op_state']==2){  //提现成功 的全部累加
                            $amount_summation_all+=$value['amount'];
                        }
                    }
                }else{
                    $amount_summation_all=$model_arr[0]['amount_summation'];
                }

                $amount_summation_all+=$amount;

                $model->amount_summation=$amount_summation_all;
            }

            if ($model->update()) {
                if ($model->op_state == UserWithdraw::OP_STATE_DENY) {
                    $model->user->account += $model->amount;

                    $model->user->update();    
                }elseif($model->op_state == UserWithdraw::OP_STATE_PASS){

                    $id = $model->user_id;   //用户平台id
                    $accname =  $model->user->userAccount->bank_user; //持卡人姓名
                    $bankcode = $model->user->userAccount->bank_name; //银行代码   
                    $bank_card = $model->user->userAccount->bank_card; //银行卡号
                    $money = $model->amount;   //提现金额
				//$model  = $model->user->userAccount->bank_user;   //json_encode($model);

                    // $url = "http://www.zhongxink.cn/ownc/notify.php?id =$id&username=$accname&bank=$bankcode&bankno=$bank_card&money=$money";
                    // file_get_contents($url);
                }
                return success();
            } else {
                return error($model);
            }
        }
        return $this->render('verifyWithdraw', compact('model'));
    }

    /**
     * @authname 会员出金总计
     */

    /**
     * @authname 会员充值记录
     */
    public function actionChargeRecordList()
    {
        $query = (new UserCharge)->listQuery()->joinWith(['user.parent', 'user.admin'])->manager()->orderBy('userCharge.id DESC');
        $countQuery = (new UserCharge)->listQuery()->joinWith(['user.admin'])->manager();
        $count = $countQuery->select('SUM(amount) amount')->one()->amount ?: 0;

        $html = $query->getTable([
            'user.id',
            'user.nickname' => '充值人',
            'user.mobile',
            'amount',
            'after_recharge'=>['header' => '充值后账户余额'],
            'user.pid'=>['header' => '推荐人ID'],
            'admin.username' => ['header' => '代理商账号'],
//            'admin.pid' => ['header' => '综会账号', 'value' => function ($row) {
//                //return $row->user->getLeaderName($row->user->admin_id);
//            }],
            'user.account'=>['header'=>'账户实时余额'],
            'charge_type',
          'remark' => ['header' => '备注'],
            'created_at',
            ['header' => '充值状态','value'=>function($row){
                if ($row['charge_type']!=6){
                    if ($row['charge_state']=='1'){
                        $examineBtn = Hui::primarySpan('待付款');
                    }elseif($row['charge_state']=='2'){
                        $examineBtn = Hui::primarySpan('成功');
                    }else{
                        $examineBtn = Hui::primarySpan('失效');
                    }
                }else {
                    if ($row['charge_state'] == '1' && $row['charge_type'] == 6) {
                        $examineBtn = Hui::dangerBtn('待审核', ['UserChargeExamine','orderid' => $row->trade_no], ['class' => 'UserChargeExamine']);
                    } elseif ($row['charge_state'] == '2' && $row['charge_type'] == 6) {
                        $examineBtn = Hui::primarySpan('成功');
                    } else {
                        $examineBtn = Hui::primarySpan('失效');
                    }
                }
                return implode(str_repeat('&nbsp;', 4), [
                    $examineBtn
                ]);
            }],
        ], [
            'searchColumns' => [
                'user.id',
                'user.nickname',
                'user.mobile',
                'user.pid',
                'admin.username' => ['header' => '代理商账号'],
                'leader' => ['header' => '综会账号'],
                'time' => ['header' => '充值时间', 'type' => 'dateRange'],
              'charge_state'=>['header' => '1待付款，2成功，-1失败'],
            ],
            'ajaxReturn' => [
                'count' => $count
            ]
        ]);

        return $this->render('chargeRecordList', compact('html', 'count'));
    }

    /**
     * @authname 用户充值信息导出
     */
    public function actionChargeExcel()
    {
        ini_set("memory_limit", "10000M");
        set_time_limit(0);
        require Yii::getAlias('@vendor/PHPExcel/Classes/PHPExcel.php');
        //获取数据
//        $query = (new UserCharge)->listQuery()->joinWith(['user.parent'])->manager()->orderBy('userCharge.id DESC');
        $query = (new UserCharge)->listQuery()->joinWith(['user.parent', 'user.admin'])->manager()->orderBy('userCharge.id DESC');
//        $countQuery = (new UserCharge)->listQuery()->joinWith(['user'])->manager();
        $countQuery = (new UserCharge)->listQuery()->joinWith(['user.admin'])->manager();
//        $count = $countQuery->select('SUM(amount) amount')->one()->amount ?: 0;
        $count = $countQuery->select('SUM(amount) amount')->one()->amount ?: 0;
        $data = $query->all();

        $n = 3;
        //加载PHPExcel插件
        $Excel = new \PHPExcel();
        $Excel->setActiveSheetIndex(0);
        //编辑表格    标题
        $Excel->setActiveSheetIndex(0)->mergeCells('A1:I1');
        $Excel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $Excel->setActiveSheetIndex(0)->getStyle('A1')->getFont()->setSize(20);
        $Excel->setActiveSheetIndex(0)->getStyle('A1')->getFont()->setName('黑体');
        $Excel->getActiveSheet()->setCellValue('A1',config('web_name').'-出金信息统计表');
        //表头
        $Excel->getActiveSheet()->getStyle('E')->getNumberFormat()->setFormatCode(\PHPExcel_Style_NumberFormat::FORMAT_NUMBER_00);
        $Excel->setActiveSheetIndex(0)->getStyle('A2:G2')->getFont()->setBold(true);
        $Excel->setActiveSheetIndex(0)->setCellValue('A2','用户的ID');
        $Excel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $Excel->setActiveSheetIndex(0)->setCellValue('B2','昵称');
        $Excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('C2','手机号');
        $Excel->getActiveSheet()->getColumnDimension('C')->setWidth(25);
        $Excel->setActiveSheetIndex(0)->setCellValue('D2','充值金额');
        $Excel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $Excel->setActiveSheetIndex(0)->setCellValue('E2','充值方式');
        $Excel->getActiveSheet()->getColumnDimension('E')->setWidth(10);
        $Excel->setActiveSheetIndex(0)->setCellValue('F2','充值时间');
        $Excel->getActiveSheet()->getColumnDimension('F')->setWidth(20);
        $Excel->setActiveSheetIndex(0)->setCellValue('G2','充值状态');
        $Excel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
        $Excel->setActiveSheetIndex(0)->setCellValue('H2','推荐人ID');
        $Excel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
        $Excel->setActiveSheetIndex(0)->setCellValue('I2','代理商账号');
        $Excel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
        $chargeType = UserCharge::getChargeTypeMap();
        //内容
        foreach ($data as $val) {
            $Excel->setActiveSheetIndex(0)->setCellValue('A'.$n, $val->user->id);
            if (strpos($val->user->nickname, '=') === 0){
                $val->user->nickname = "nanqe" . $val->user->nickname;
            }
            if ($val->charge_state == 2){
                $val->charge_state = '充值成功';
            }else{
                $val->charge_state='待付款';
            }
            $Excel->setActiveSheetIndex(0)->setCellValue('B'.$n, $val->user->nickname);
            $Excel->setActiveSheetIndex(0)->setCellValue('C'.$n, $val->user->mobile);
            $Excel->setActiveSheetIndex(0)->setCellValue('D'.$n, $val->amount);
            $Excel->setActiveSheetIndex(0)->setCellValue('E'.$n, $chargeType[$val->charge_type]);
            $Excel->setActiveSheetIndex(0)->setCellValue('F'.$n, $val->created_at);
            $Excel->setActiveSheetIndex(0)->setCellValue('G'.$n, $val->charge_state);
            $Excel->setActiveSheetIndex(0)->setCellValue('H'.$n,  $val->user->pid);
            $Excel->setActiveSheetIndex(0)->setCellValue('I'.$n, $val->user->admin->username);
            $n++;
            $Excel->getActiveSheet()->getRowDimension($n+1)->setRowHeight(18);
        }
        //统计
        $Excel->setActiveSheetIndex(0)->mergeCells('A'.$n.':I'.$n);
        $Excel->getActiveSheet()->setCellValue('A'.$n,'总共充值了'.$count.'元');
        $Excel->setActiveSheetIndex(0)->getStyle('A'.$n)->getFont()->setBold(true);
        //格式
        $Excel->getActiveSheet()->getStyle('A2:I'.$n)->getBorders()->getAllBorders()->setBorderStyle(\PHPExcel_Style_Border::BORDER_THIN);
        //导出表格
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition:attachment;filename="'.config('web_name').'-用户充值信息统计表.xls');
        header('Cache-Control: max-age=0');
        $objWriter= \PHPExcel_IOFactory::createWriter($Excel,'Excel5');
        $objWriter->save('php://output');
    }

    /**
     * @authname 审核经纪人
     */
    public function actionVerifyManager()
    {
        if (req()->isPost) {
            $model = User::findModel(get('id'));
            $model->apply_state = get('apply_state');
            if ($model->apply_state == User::APPLY_STATE_PASS) {
                $model->is_manager = User::IS_MANAGER_YES;
                $userExtend = UserExtend::findOne($model->id);
            }
            if ($model->update()) {
                return success();
            } else {
                return error($model);
            }
        }

        $query = (new User)->listQuery()->joinWith(['userAccount', 'userExtend'])->manager()->andWhere(['user.apply_state' => User::APPLY_STATE_WAIT, 'user.state' => User::STATE_VALID]);

        $html = $query->getTable([
            'id',
            'userExtend.realname' => ['header' => '申请真实姓名'],
            'userExtend.mobile' => ['header' => '申请手机号'],
            'userExtend.created_at' => ['header' => '申请时间'],
            'nickname',
            'mobile' => ['header' => '注册手机号'],

            'admin.username' => ['header' => '代理商账户'],
            'admin.pid' => ['header' => '综会账号', 'value' => function ($row) {
                return $row->getLeaderName($row->admin_id);
            }],
            'created_at',
            ['type' => [], 'value' => function ($row) {
                return implode(str_repeat('&nbsp;', 2), [
                    Hui::primaryBtn('审核通过', ['', 'id' => $row->id, 'apply_state' => User::APPLY_STATE_PASS], ['class' => 'verifyBtn']),
                    Hui::dangerBtn('不通过', ['', 'id' => $row->id, 'apply_state' => User::APPLY_STATE_DENY], ['class' => 'verifyBtn'])
                ]);
            }]
        ], [
            'searchColumns' => [
                'id',
                'nickname',
                'mobile',
                'admin.username' => ['header' => '代理商账户'],
                'leader' => ['header' => '综会账号'],
            ]
        ]);

        return $this->render('verifyManager', compact('html'));
    }

    /**
     * @authname 返点记录列表
     */
    public function actionRebateList()
    {
        $query = (new UserRebate)->listQuery()->orderBy('userRebate.created_at DESC')->manager();
        $count = $query->sum('amount') ?: 0;

        $html = $query->getTable([
            'id',
            'pid' => ['header' => '获得返点经纪人用户', 'value' => function ($row) {
                if (isset($row->parent)) {
                    return '经纪人：' . $row->parent->nickname . "({$row->parent->mobile})";
                } else {
                    return '管理员：' . $row->admin->username;
                }
            }],
            'user.nickname' => ['header' => '会员昵称（手机号）', 'value' => function ($row) {
                return Html::a($row->user->nickname . "({$row->user->mobile})", ['', 'search[user.id]' => $row->user->id], ['class' => 'parentLink']);
            }],
            'amount',
            'point' => function ($row) {
                return $row->point . '%';
            },
            'created_at' => '返点时间'
        ], [
            'searchColumns' => [
                // 'admin.username' => ['header' => '代理商账户'],
                'parent.mobile' => ['header' => '经纪人手机号'],
                'user.id' => ['header' => '会员ID'],
                'user.mobile' => ['header' => '会员手机'],
                'time' => 'timeRange'
            ],
            'ajaxReturn' => [
                'count' => $count
            ]
        ]);

        return $this->render('rebateList', compact('html', 'count'));
    }

    /**
     * @authname 用户资料审核
     */
    public function actionUserDataToExamine()
    {
        $userId=$_GET['id'];
        $status=$_GET['status'];
        $name=$_GET['name'];
        if ($status==null){//   不带审核参数的时候 直接跳转 审核页面
            $userCardData=UserCard::find()->where(['user_id'=>$userId])->orderBy('id DESC')->one();
            $userUserAccount=BankCard::find()->where(['user_id'=>$userId])->orderBy('id DESC')->one();
            $bank_name=$userUserAccount->bank_name;  // 银行名称
            $bank_card=$userUserAccount->bank_card;  // 银行卡号
            $bank_user=$userUserAccount->bank_user;  //  持卡人姓名
            $bank_mobile=$userUserAccount->bank_mobile; //  预留手机号
            $id_card=$userUserAccount->id_card;  //  身份证号
            $id_card_address=preg_replace('# #','',$userCardData->id_card_address);
            $bank_card_address=preg_replace('# #','',$userCardData->bank_card_address);
            $back_idcard_address=preg_replace('# #','',$userCardData->back_idcard_address);
//            dump($userCardParameter);
            $default_img='/test/default_img.png';
            return $this->render('usercard', [
                'idcard' =>empty($id_card_address)?$default_img:$id_card_address,
                'backidcard' =>empty($back_idcard_address)?$default_img:$back_idcard_address,
                'userid'=>$userId,
                'bankcard'=>empty($bank_card_address)?$default_img:$bank_card_address,
                'status'=>$userCardData->status,
                'bank_name'=>$bank_name,
                'bank_card'=>$bank_card,
                'bank_user'=>$bank_user,
                'bank_mobile'=>$bank_mobile,
                'id_card'=>$id_card,
            ]);
        }elseif($status=='-1'){//  审核通不过的 时候 修改状态 和 审核时间
            $userCardData=UserCard::find()->where(['user_id'=>$userId])->orderBy('id DESC')->one();
            $userCardData->status='-1';
            $userCardData->update_time=date('Y-m-d H:i:s');
            $userCardData->save(false);
            $UserData=User::find()->where(['id'=>$userId])->one();
            $UserData->bank_status=-1;
            $UserData->save(false);
            return $this->actionList();
        }elseif ($status=='2'){  //  审核通过的 时候 修改状态 和 审核时间
            $userCardData=UserCard::find()->where(['user_id'=>$userId])->orderBy('id DESC')->one();
            $userCardData->status='2';
            $userCardData->update_time=date('Y-m-d H:i:s');
            $userCardData->save(false);
            $UserData=User::find()->where(['id'=>$userId])->one();
            $UserData->bank_status=2;
            $UserData->nickname=$name;
            $UserData->save(false);
            return $this->actionList();
        }
        return $this->actionList();
    }

    /**
     * @authname 用户转账充值审核
     */
    public function actionUserChargeExamine(){

        $getData=get();
        $status=$getData['status'];
        if ($status==null){
            $orderId=$getData['orderid'];
            $OfflinePayment=OfflinePayment::find()->where(['order_id'=>$orderId])->Asarray()->one();
            if(!empty($OfflinePayment)){  // 用户点击了已完成支付
                $id=u()->id; // 当前登录的ID
                $operator='操作ID：'.u()->id.'··操作名字：'.u()->username;
                $operatorJson=json_encode($operator,256);  //  记录当前操作者的ID 和名字 转json  待用
//            dump($OfflinePayment);
                $user_id=$OfflinePayment['user_id']; //  用户ID编号
                $order_id=$OfflinePayment['order_id']; //  用户充值订单号
                $pay_name=$OfflinePayment['pay_name']; //  用户账户名称
                $pay_info=$OfflinePayment['pay_info']; //  用户支付备注信息
                $shop_name=$OfflinePayment['shop_name']; //  收款名称
                $shop_num=$OfflinePayment['shop_num']; //  收款账户
                $order_status=$OfflinePayment['order_status'];
                return $this->render('userrecharge', [
                    'user_id' =>$user_id,
                    'order_id'=>$order_id,
                    'pay_name'=>$pay_name,
                    'pay_info'=>$pay_info,
                    'shop_name'=>$shop_name,
                    'shop_num'=>$shop_num,
                    'order_status'=>$order_status,
                ]);

            }else{ //  用户未点击已完成支付
                echo '用户未支付完成，如用户已经充值，未点击支付完成，且退出了充值完成页面，请让用户重新充值一笔，点击充值完成后，审核';
            }
        }else{
            $status=$getData['status'];
            $orderid = isset($getData['order_id']) ? $getData['order_id'] : 0;// 取出订单号
            if ($status=='2'){
                $id=u()->id; // 当前登录的ID
                $operator='操作ID：'.u()->id.'··操作名字：'.u()->username;
                $operatorJson=json_encode($operator,256);  //  记录当前操作者的ID 和名字 转json  待用
                $trade_no=$orderid;
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
                            $userCharge->remark=$operator;
                            $userCharge->after_recharge =  $user->account;

                            $this->actionIndex6($user->id,$userCharge->amount);
                        }
                    }
                    //更新充值记录表
                    $resultUserCharge=$userCharge->update();
                    if ($resultUserCharge){
                        $OfflinePayment=OfflinePayment::find()->where(['order_id'=>$orderid])->one();
                        $OfflinePayment->order_status=2;
                        $OfflinePayment->updatetime=date('Y-m-d H:i:s');
                        $OfflinePayment->updateid=$operatorJson;
                        $OfflinePayment->update();

                    }
                }
            }elseif ($status=='-1'){
                $id=u()->id; // 当前登录的ID
                $operator='操作ID：'.u()->id.'··操作名字：'.u()->username;
                $operatorJson=json_encode($operator,256);  //  记录当前操作者的ID 和名字 转json  待用
                $trade_no=$orderid;
                $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $trade_no])->one();
                //更新充值状态---成功
                $userCharge->charge_state = -1;
                //更新充值记录表
                $resultUserCharge=$userCharge->update();
                if ($resultUserCharge){
                    $OfflinePayment=OfflinePayment::find()->where(['order_id'=>$orderid])->one();
                    $OfflinePayment->order_status=-1;
                    $OfflinePayment->updatetime=date('Y-m-d H:i:s');
                    $OfflinePayment->updateid=$operatorJson;
                    $OfflinePayment->update();
                }
            }

            return $this->actionChargeRecordList();

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
}
