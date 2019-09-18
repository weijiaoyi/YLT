<?php

namespace admin\controllers;

use admin\models\UserInvitationCode;
use Yii;
use admin\models\User;
use admin\models\AdminUser;
use admin\models\UserExtend;
use admin\models\Retail;
use admin\models\UserRebate;
use common\helpers\Hui;
use common\helpers\Html;

class SaleController extends \admin\components\Controller
{
    /**
     * @authname 经纪人列表
     */
    public function actionManagerList()
    {
        $query = (new User)->managerQuery()->joinWith(['userAccount', 'userExtend', 'admin'])->orderBy('total_fee DESC')->manager();

        $html = $query->getTable([
            'id' => ['search' => true],
            'userExtend.realname' => ['search' => true, 'header' => '真实姓名'],
            'nickname' => ['search' => true],
            'userExtend.mobile' => ['search' => true, 'header' => '经纪人手机号'],
            // 'mobile' => ['search' => true, 'header' => '注册手机号'],
            // 'pid' => ['header' => '推荐人', 'value' => function ($row) {
            //     return $row->getParentLink();
            // }],
            'admin.username' => ['header' => '代理商账户'],
            'admin.pid' => ['header' => '综会账号', 'value' => function ($row) {
                return $row->getLeaderName($row->admin_id);
            }],
            'total_fee',
            'userExtend.point' => ['header' => '返点(%)'],
            'account',
            'created_at',
            ['type' => ['delete'], 'width' => '250px', 'value' => function ($row) {
                return implode(str_repeat('&nbsp;', 2), [
                    Hui::primaryBtn('创建邀请码', ['invitationCode', 'id' => $row->id], ['class' => 'invitationCode']),
                    Hui::primaryBtn('修改返点', ['editPoint', 'id' => $row->id], ['class' => 'editBtn'])
                ]);
            }]

        ],
		[
            'searchColumns' => [
                'admin.username' => ['header' => '代理商账户'],
                'leader' => ['header' => '综会账号'],
            ],
			'addBtn' => u()->power < AdminUser::POWER_ADMIN?'':['saveManager' => '添加经纪人']
        ]);

        return $this->render('managerList', compact('html'));
    }

    /**
     * @authname 修改经纪人返点%
     */
    public function actionEditPoint() 
    {
        $userExtend = UserExtend::findModel(get('id'));
        $retail = Retail::find()->where(['account' => u()->username])->one();
//        dump(u()->usernamew1);
        if (empty($retail)) {
            $retail = Retail::find()->joinWith(['adminUser'])->where(['adminUser.id' => $userExtend->coding])->one();
        }
        $userExtend->point = post('point');
        if ($userExtend->point > $retail->point || is_int($userExtend->point) || $userExtend->point < 0) {
            return error('经纪人的返点不能大于上级代理商的返点'.$retail->point.'(设置返点为正整数)');
        }
        if ($userExtend->validate()) {
            $userExtend->update(false);
            return success();
        } else {
            return error($user);
        }
    }

    /**
     * @authname 代理商返点统计
     */
    public function actionManagerRebateList()
    {
        $query = (new UserRebate)->managerListQuery()->orderBy('userRebate.created_at DESC')->manager();
        $count = $query->sum('amount') ?: 0;

        $html = $query->getTable([
            'id',
            'admin.username' => ['header' => '管理员账号'],
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
                'admin.username' => ['header' => '管理员账号'],
                'user.id' => ['header' => '会员ID'],
                'user.mobile' => ['header' => '会员手机'],
                'time' => 'timeRange'
            ],
            'ajaxReturn' => [
                'count' => $count
            ]
        ]);

        return $this->render('managerRebateList', compact('html', 'count'));
    }

    /**
     * @authname 添加/编辑经纪人单位
     */
    public function actionSaveManager()
    {
		/*$id = Retail::getAdminAccount();
		print_r($id);
		exit;
		*/
        $user = User::findModel();

        if ($user->load()) {
            if ($user->validate()) {
				$temp = $user->password;
				$user->password = md5($user->password);
				$user->pid = 100260;
				//$manager = (new User) -> id; 
				//$user->admin_id = $manager;
				$user->is_manager = 1;
                $user->save(false);
				$extend = UserExtend::findModel();
				$extend->user_id = $user->id;
				$extend->realname = $user->nickname;
				$extend->mobile = $user->mobile;
				$extend->point = 0;
				$extend->coding = 46;
				$extend->state = 1;
				$extend->save(false);
				
				
                return success();
            } else {
                return error($user);
            }
        }

        return $this->render('saveManager', compact('user'));
    }
    /**
     * @authname 创建注册码
     */
    public function actionInvitationCode (){
        $userExtend = UserExtend::findModel(get('id'));
        $id=get('id');
        $jsUpCode=post('upcode');
        $interceptId=substr($jsUpCode,0,6);
        if ($id == $interceptId){
            $md5Code =md5($jsUpCode);
            $code=substr($md5Code,0,9);
           $userInvitationCode = new UserInvitationCode();
            $userInvitationCode->pid=$interceptId;
            $userInvitationCode->code=$code;
            $userInvitationCode->status=1;
            $time=time();
            $userInvitationCode->created_time=date("Y-m-d H:i:s",$time) ;
            $saveresu=$userInvitationCode->save(false);
          if ($saveresu){
              return success($interceptId.'邀请码为：'.$code);
          }
            return error('生成失败，刷新后请重新生成');
        }else{
            return error('生成失败，刷新后请重新生成');
        }

    }

}
