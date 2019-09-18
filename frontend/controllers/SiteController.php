<?php

namespace frontend\controllers;

use admin\models\UserInvitationCode;
use frontend\models\OfflinePayment;
use Yii;
use common\helpers\Curl;
use frontend\models\User;
use frontend\models\UserCoupon;
use frontend\models\Product;
use frontend\models\Order;
use frontend\models\ProductPrice;
use frontend\models\DataAll;
use frontend\models\UserCharge;
use common\helpers\FileHelper;
use common\helpers\Json;

class SiteController extends \frontend\components\Controller
{
    public $newuser;
    public function beforeAction($action)
    {
        //var_dump(user()->isGuest);
        //exit;

      
       
        
         //        var_dump(user()->isGuest);
         //        var_dump(!in_array($this->action->id, $actions));
         //        exit;
      
         //shouyetiaozhuan 
        
        //    $actions = ['ajax-update-status', 'wxtoken', 'wxcode', 'test', 'rule', 'captcha','notify', 'hx-weixin', 'zynotify', 'update-user', 'update', 'tynotify','login','reg','verify-code','ajax-reg','ajax-forget','pass-for-get','jinzhifunotify'];
        //    if(user()->isGuest && !in_array($this->action->id, $actions))
        //    {  
        //        $this->redirect(['/site/login']);
        //        return false;
        //    }
        //    else{
               return true;
        //    }
     


        // $userData['openid'] = 'oRACTxCE4omrKiRiqIrbodzhePzE';
        // session('wechat_userinfo',$userData,999);
        
     


        //session['wechat_userinfo']['openid']='oRACTxCE4omrKiRiqIrbodzhePzE';
    /* if (!parent::beforeAction($action)) 
        {
            return false;
        } 
        else 
        {
            $actions = ['ajax-update-status', 'wxtoken', 'wxcode', 'test', 'rule', 'captcha','notify', 'hx-weixin', 'zynotify', 'update-user', 'update', 'tynotify'];
            if (user()->isGuest && !in_array($this->action->id, $actions)) {
                $wx = session('wechat_userinfo');
                if (!empty($wx)) {
                    $code = get('code');
                    $uid = get('uid');
                    $user = User::find()->where(['open_id' => $wx['openid']])->one();
                    if(empty($user)) {
                        // var_dump('addUser');
                        // exit();
                        User::addUser($uid);
                        $this->newuser = 1;
                    } else {
                        $user->login(false);
                    }
                    
                } else {
                    $code = get('code');
                    $uid = get('uid');
                    if (empty($code)) {
                        if(!empty($uid)) { 
                            $this->redirect(['/wechart.php?uid='.$uid]);
                        } else {
                            $this->redirect(['/wechart.php']);
                        }                       
                        return false;
                    } else {                        
                        User::registerUser($code, $uid);
                        $this->newuser = 1;
                    }
                }
            }
            return true;
        }*/
    }
    //商城首页
    public function actionShop()
    {
        //所有在售商品ON_SALE_YES
        // exit;
        $productArr = Product::getProductAllArray();
       
        foreach ($productArr as $key => $value) {
            $jsonArr[] = $value['table_name'];
           
        }
        $json = json_encode($jsonArr);
        reset($productArr);  // 重置指针
        $pid = get('pid', key($productArr));  // 返回键名
       //print_r($pid);exit;
        //这条期货信息
        $product = Product::find()->andWhere(['id' => $pid])->with('dataAll')->one();
        //最新的这条期货数据集
        $newData = DataAll::newProductPrice($product->table_name);
        return $this->renderPartial('index', compact('product', 'newData', 'productArr')); // yii2 内置方法 compact 传数据到前端模板
    }
    //商城--商品详情1
    public function actionOne()
    {
        $this->view->title = '商品详情';
        return $this->render('shopDetail1');  //  跳转到页面shopDetail1
    }
    //商城--商品详情2
    public function actionTwo()
    {
        $this->view->title = '商品详情';
        return $this->render('shopDetail2');
    }
    //商城--商品详情3
//    public function actionThree()
//    {
//        $this->view->title = '商品详情';
//        return $this->render('shopDetail3');
//    }
    public function actionRule()
    {
        $this->view->title = '规则';
        $img = '/images/rule.png';
        return $this->render('rules', compact('img'));
        // return $this->render('rule');
    }
    public function actionTip()
    {
        $this->view->title = '提示消息';
        return $this->render('tip');
    }
    public function actionIndex()
    {
        if(empty(u()->id)){
            echo"未登录不能进行操作";
            $this->redirect(['/site/login']);

        }
        //所有在售商品ON_SALE_YES
        // exit;
        $productArr = Product::getProductAllArray();
       
        foreach ($productArr as $key => $value) {
            $jsonArr[] = $value['table_name'];
           
        }
        $json = json_encode($jsonArr);
        reset($productArr);
        $pid = get('pid', key($productArr));
       //print_r($pid);exit;
        //这条期货信息
        $product = Product::find()->andWhere(['id' => $pid])->with('dataAll')->one();
        //最新的这条期货数据集
        $newData = DataAll::newProductPrice($product->table_name);
//        dump($product);
        return $this->renderPartial('index', compact('product', 'newData', 'productArr'));
        //return $this->render('index22', compact('product', 'newData', 'productArr'));
    }
    public function actionList()
    {
        if(empty(u()->id)){
            echo"未登录不能进行操作";
            $this->redirect(['/site/login']);

        }
        //所有在售商品ON_SALE_YES
        // exit;
        $productArr = Product::getProductAllArray();
        foreach ($productArr as $key => $value) {
            $jsonArr[] = $value['table_name'];
        }
        $json = json_encode($jsonArr);
        reset($productArr);
        $pid = get('pid', key($productArr));
       //print_r($pid);exit;
        //这条期货信息
        $product = Product::find()->andWhere(['id' => $pid])->with('dataAll')->one();
        //最新的这条期货数据集
        $newData = DataAll::newProductPrice($product->table_name);
        return $this->renderPartial('list', compact('product', 'newData', 'productArr'));
        //return $this->render('index22', compact('product', 'newData', 'productArr'));
    }
    public function actionWx()
    {   $data['qq']=config('qq');
      
        return $this->renderPartial('wx',compact('data'));
    }
    public function actionDownapp(){
        return $this->renderPartial('downapp');
    }
    public function actionNews(){
        return $this->renderPartial('news');
    }
    public function actionBuyMiddle()
    {   
 
        if(empty(u()->id)){
          echo"未登录不能进行操作";
          $this->redirect(['/site/login']);
         
         }
        session('buyurl',get('url')."&state=".get('state'),999);
        return $this->renderPartial('buy-middle');
    }
    public function actionDetail()
    {
        if(!get('type')=='sim')
        {
            session('sim_type',null);//清除模拟盘标记
        }
        else
        {
            session('sim_type','sim');
        }
        $user=u();
        $user->id=u()->id;
        $user->account=u()->account;
        $user->blocked_account=u()->blocked_account;
        $type="";
        
        //如果是模拟盘，就赋值虚拟账户金额和模拟盘标志
        if(session('sim_type')!=null&&session('sim_type')=='sim')
        {
            $user->account=u()->sim_account;
            $user->blocked_account=u()->sim_blocked_account;
            $type='moni';
        }

        
         $productArr = Product::getProductAllArray();
        foreach ($productArr as $key => $value) {
            $jsonArr[] = $value['table_name'];
        }
        $json = json_encode($jsonArr);
        reset($productArr);
        $pid = get('pid', key($productArr));

        //这条期货信息
        $product = Product::find()->andWhere(['id' => $pid])->with('dataAll')->one();

        //最新的这条期货数据集
        $newData = DataAll::newProductPrice($product->table_name);
  
        return $this->renderPartial('newDetail', compact('product', 'newData',  'productArr', 'user','type'));
        //return $this->render('index22', compact('product', 'newData', 'count', 'productArr', 'orders', 'time', 'json','user'));
    }

    //期货的最新价格数据集
    public function actionAjaxNewProductPrice()
    {
        

        $product = Product::findModel(post('pid'));
        //周末休市 特殊产品不休市
        if ((date('w') == 0 && $product->source == Product::SOURCE_TRUE) || (date('G') > 3 && $product->source == Product::SOURCE_TRUE && date('w') == 6)) {
            return error();
        }
        $idArr = Order::find()->where(['order_state' => Order::ORDER_POSITION, 'user_id' => u()->id, 'product_id' => $product->id])->map('id', 'id');
        if (empty($idArr)) {
            $idArr = [];
        }
        return success($idArr);
    }
  /*********************************************k线数据接口**********************/
    public function actionGetLine()//分时线接口，9小时累进;全日线，当天24小时；
    {
        $id=get('pid');

        if(empty(get('time')))
        {
            $end=date("Y-m-d H:i:s",time()+60*60*4);
           // $end=date("2017-12-02 09:52:44");
            $start=date("Y-m-d H:i:s",strtotime($end)-60*60*7);
        }
        else
        {
            $start=date("Y-m-d H:i:s",get('time')/1000);
            $end=date("Y-m-d H:i:s",get('time')/1000+10800);
        }
        if(get('isAllDay')=='true')
        {
            $end=date("Y-m-d 23:23:59");
            //$end=date("2017-12-02 23:23:59");
            $start=date("Y-m-d H:i:s",strtotime($end)-60*60*24);

        }    
        $model = Product::findModel($id);
        $name = $model->table_name;
        $format='%Y-%m-%d %H:%i';

        
        $data = self::db("SELECT
                 cu.price indices, UNIX_TIMESTAMP(DATE_FORMAT(time,'".$format."')) * 1000 time
        FROM
            (
                SELECT
                    
                    max(d1.id) id
                FROM
                    data_" . $name . " d1
                where time >'".$start."' and time <'".$end."'
                group by
                    DATE_FORMAT(time,'".$format."')
            ) sub,
            data_" . $name . " cu
        WHERE
            cu.id = sub.id")->queryAll();
        //$response->send();
        $da=null;
       if(!empty($data))
       {
        for($i=0;$i<count($data);$i++)
        {
            $da[$i]['time']=(float)$data[$i]['time'];
            $da[$i]['indices']=(float)$data[$i]['indices'];

        }
       }
      
      $jsonarr['msg']="请求成功！";
      $jsonarr['success']=true;
      $jsonarr['totalCount']=0;
      $jsonarr['resultObject']['startTime']=strtotime($start)*1000;
      $jsonarr['resultObject']['endTime']=strtotime($end)*1000;
      $jsonarr['resultList']=$da;
      echo json_encode($jsonarr);

    }
    public function actionGetLineLight()//闪电线接口，5分钟累进
    {

            $id=get('pid');
            $end=date("Y-m-d H:i:s");
            //$end=date("2017-12-02 09:52:48");
            $start=date("Y-m-d H:i:s",strtotime($end)-600);
      
        $model = Product::findModel($id);
        $name = $model->table_name;
        $format='%Y-%m-%d %H:%i:%s';
        $data = self::db("SELECT
                 cu.price indices, UNIX_TIMESTAMP(DATE_FORMAT(time,'".$format."')) * 1000 time
        FROM
            (
                SELECT
                    
                    max(d1.id) id
                FROM
                    data_" . $name . " d1
                where time >'".$start."' and time <'".$end."'
                group by
                    DATE_FORMAT(time,'".$format."')
            ) sub,
            data_" . $name . " cu
        WHERE
            cu.id = sub.id")->queryAll();
        //$response->send();
       
        $da=null;
       if(!empty($data))
       {
        for($i=0;$i<count($data);$i++)
        {
            $da[$i]['time']=(float)$data[$i]['time'];
            $da[$i]['indices']=(float)$data[$i]['indices'];

        }
       }
      
      $jsonarr['msg']="请求成功！";
      $jsonarr['success']=true;
      $jsonarr['totalCount']=0;
      $jsonarr['resultObject']=null;
      $jsonarr['resultList']=$da;

     
      echo json_encode($jsonarr);

    }
    public function actionGetLineDay()//日线接口，60天累进
    {

            $id=get('pid');
            $end=date("Y-m-d H:i:s");
            //$end=date("2017-12-02 09:08:59");
            $start=date("Y-m-d H:i:s",strtotime($end)-60*60*24*60);
      
        $model = Product::findModel($id);
        $name = $model->table_name;
        $format='%Y-%m-%d';
        $data = self::db("SELECT
                sub.*, cu.price indices, UNIX_TIMESTAMP(DATE_FORMAT(time,'".$format."')) * 1000 time
        FROM
            (
                SELECT
                    min(d1.price) low,
                    max(d1.price) high,
                    substring_index(group_concat(d1.price order by `id` desc),',',1) open,
                    substring_index(group_concat(d1.price order by `id` desc),',',-4) close,
                    max(d1.id) id
                FROM
                    data_" . $name . " d1
                where time >'".$start."' and time <'".$end."'
                group by
                    DATE_FORMAT(time,'".$format."')
            ) sub,
            data_" . $name . " cu
        WHERE
            cu.id = sub.id")->queryAll();
        //$response->send();
      
        $da=null;
       if(!empty($data))
       {
        for($i=0;$i<count($data);$i++)
        {
            $da[$i]['dateTime']=(float)$data[$i]['time'];
            $da[$i]['indices']=(float)$data[$i]['indices'];
            $da[$i]['low']=(float)$data[$i]['low'];
            $da[$i]['high']=(float)$data[$i]['high'];
            $da[$i]['open']=(float)$data[$i]['open'];
            $str = $data[$i]['close'];
            if((float)strstr($str, ',', true)) {
                $da[$i]['close'] = (float)strstr($str, ',', true);
            }else{
                $da[$i]['close'] = (float)$data[$i]['close'];
            }
//            if($id == 8 || $id == 13|| $id == 2){
//              $da[$i]['close']=(float)$data[$i]['close']*10;
//            }else{
//              $da[$i]['close']=(float)$data[$i]['close'];
//            }

            $da[$i]['vol']=(float)mt_rand(500,5000);


        }
       }
      
      $jsonarr['msg']="请求成功！";
      $jsonarr['success']=true;
      $jsonarr['totalCount']=0;
      $jsonarr['resultObject']=null;
      $jsonarr['resultList']=$da;

     
      echo json_encode($jsonarr);

    }
    public function actionGetLineMin()//分钟线接口，8小时累进
    {

            $id=get('pid');
            $end=date("Y-m-d H:i:s");
            //$end=date("2017-12-02 09:08:59");
            $start=date("Y-m-d H:i:s",strtotime($end)-60*60*96);
      
        $model = Product::findModel($id);
        $name = $model->table_name;
        $format='%Y-%m-%d %H:%i';
        $data = self::db("SELECT
                sub.*, cu.price indices, UNIX_TIMESTAMP(DATE_FORMAT(time,'".$format."')) * 1000 time
        FROM
            (
                SELECT
                    min(d1.price) low,
                    max(d1.price) high,
                    substring_index(group_concat(d1.price order by `id` desc),',',1) open,
                    substring_index(group_concat(d1.price order by `id` desc),',',-1) close,
                    max(d1.id) id
                FROM
                    data_" . $name . " d1
                where time >'".$start."' and time <'".$end."'
                group by
                    DATE_FORMAT(time,'".$format."')
            ) sub,
            data_" . $name . " cu
        WHERE
            cu.id = sub.id")->queryAll();
        //$response->send();
      
        $da=null;
       if(!empty($data))
       {
        for($i=0;$i<count($data);$i++)
        {
            $da[$i]['dateTime']=(float)$data[$i]['time'];
            $da[$i]['indices']=(float)$data[$i]['indices'];
            $da[$i]['low']=(float)$data[$i]['low'];
            $da[$i]['high']=(float)$data[$i]['high'];
            $da[$i]['open']=(float)$data[$i]['open'];
            $da[$i]['close']=(float)$data[$i]['close'];
            $da[$i]['vol']=(float)mt_rand(50,500);


        }
       }
      
      $jsonarr['msg']="请求成功！";
      $jsonarr['success']=true;
      $jsonarr['totalCount']=0;
      $jsonarr['resultObject']=null;
      $jsonarr['resultList']=$da;

     
      echo json_encode($jsonarr);

    }
    /*********************************k线数据接口结束**************************************/
    public function actionGetHq()//获取盘面最新信息
    {
         $pid=get('pid');
        
        $rise = Order::find()->Where(['product_id'=>$pid,'order_state'=>1,'rise_fall'=>1])->orderBy('id DESC')->one();//买涨的手数
        $fall = Order::find()->Where(['product_id'=>$pid,'order_state'=>1,'rise_fall'=>2])->orderBy('id DESC')->one();//买跌的手数
//        if(!empty($rise))
//        {$buyhand=$rise->hand;}
//        else
//        {
//            Product::isTradeTime($pid)?$buyhand=mt_rand(1,10):$buyhand=0;
        $buyhand=Product::isTradeTime($pid)?mt_rand(1,10):$buyhand=0;
//        }
//        if(!empty($fall))
//        {$sellhand=$fall->hand;}
//        else{
//            Product::isTradeTime($pid)?$sellhand=mt_rand(1,10):$sellhand=0;
        $sellhand=Product::isTradeTime($pid)?mt_rand(1,10):$sellhand=0;
//        }
        
        $product= Product::find()->Where(['id'=>$pid])->with('dataAll')->one();
        
            
        $model['indices']=(float)$product->dataAll->price;
        $model['open']=(float)$product->dataAll->open;
        $model['high']=(float)$product->dataAll->high;
        $model['low']=(float)$product->dataAll->low;
        $model['change']=(float)$product->dataAll->diff_rate;
        $model['changeValue']=(float)$product->dataAll->diff;
        $model['swing']=(float)0;
        $model['limitUpPrice']=(float)0;
        $model['limitDownPrice']=(float)0;
        $model['tradeVol']=(float)rand(2100,3000);
        $model['buy']=round((float)$product->dataAll->price+$product->unit,3);
        // $model['buy']=20.33;
        $model['sell']=round((float)$product->dataAll->price-$product->unit,3);
        // $model['sell']=60.33;
        $model['buyVol']=$buyhand;
        $model['sellVol']=$sellhand;
        $model['totalQty']=(float)rand(21000,28740);
        $model['volume']=(float)rand(4100,5000);
        $model['closingPrice']=
        $model['close']=(float)$product->dataAll->close;
        $model['preClose']=(float)$product->dataAll->close;
        $model['preClosingPrice']=(float)$product->dataAll->close;
        $model['prePositionQty']=(float)0;
        $model['time']=$product->dataAll->time;
        $model['date']=$product->dataAll->time;
        $model['dateTime']=strtotime($product->dataAll->time)*1000;//date("Y-m-d H:i:s")
        $model['name']=$product->name;
        $model['proNo']=$product->table_name;
        $model['product_id']=$product->id;
        $jsonarr['msg']='请求成功!';
        $jsonarr['success']=true;
        $jsonarr['resultList']=null;
        $jsonarr['resultObject']['nextTime']='已休市,下次交易时间';
        $jsonarr['resultObject']['isOpen']=Product::isTradeTime($pid);
        $jsonarr['totalCount']=0;
        $jsonarr['resultObject']['model']=$model;
            

         if(!Product::isTradeTime($pid)){

            $jsonarr['msg']="当前合约已暂停交易，请选择其他合约!";
           

         }   
         //{"msg":"当前合约已暂停交易，请选择其他合约!","success":false,"resultList":null,"resultObject":null,"totalCount":0}

        


        echo json_encode($jsonarr);
 
    }
    public function actionProCloseList()//ajax获得商品列表闭市价格
    {
        $proList=get('proNo');
        $proListArr=explode(',', $proList);
        $product = dataAll::find()->Where(['in','name',$proListArr])->all();
        //$arr[];
        foreach ($product as $value) {
            //休市产品将闭市价修改为0
            Product::isTradeTime(Product::getProductId($value->name))?$arr[$value->name]=$value->close:$arr[$value->name]=0;

            
        }
        return success('success',$arr);
    }
    public function actionProPriceList()//ajax获得商品列表最新价格
    {
        $proList=get('proNo');
        $proListArr=explode(',', $proList);
       //var_dump($proListArr);
        //$product = dataAll::find()->Where(['in','name',$proListArr])->with('Product')->all();
        $productinfo=Product::find()->Where(['in','table_name',$proListArr])->with('dataAll')->all();
        $productinfoArr=Product::find()->Where(['in','table_name',$proListArr])->with('dataAll')->asArray()->all();
//        dump($productinfoArr);
        //$arr[];
        //$arr=explode((str)$product->0->unit,".");
        for($i=0;$i<count($productinfo);$i++)
        {
            $unit=explode(".",(string)(float)$productinfo[$i]->unit);
            if(count($unit)>1)
            {$len=strlen($unit[1]);}
            else
            {
                $len=0;
            }
            $name=$productinfo[$i]->table_name;
        
            //$arr[$name]=$len;
            $arr[$name]=number_format($productinfo[$i]->dataAll->price,4,".","");
        }

//        根据当前这只期货的销售/休市状态 设置 传到前端的值 是否为 null
       foreach ($productinfoArr as $key => $value){
                if ($value['closed_market']=='2'){
                    $arr["{$value['table_name']}"]=null;
                }

       }
        return success('success',$arr);
    }
    public function actionStockInfo()//ajax获得商品最新信息
    {//
        
        $pid=get('pid');
        
        $rise = Order::find()->Where(['product_id'=>$pid,'order_state'=>1,'rise_fall'=>1])->orderBy('id DESC')->one();//买涨的手数
        $fall = Order::find()->Where(['product_id'=>$pid,'order_state'=>1,'rise_fall'=>2])->orderBy('id DESC')->one();//买跌的手数
       
       if(!empty($rise))
        {$buyhand=$rise->hand;}
        else
        {
            Product::isTradeTime($pid)?$buyhand=mt_rand(1,10):$buyhand=0;
        }
        if(!empty($fall))
        {$sellhand=$fall->hand;}
        else{Product::isTradeTime($pid)?$sellhand=mt_rand(1,10):$sellhand=0;}
        
        $product= Product::find()->Where(['id'=>$pid])->with('dataAll')->one();
        if (!empty($product))
        {
         $arr['product_id']=$product->id;
         $arr['productName']=$product->name;
         $arr['proNo']=$product->table_name;
         $arr['price']=(double)$product->dataAll->price;
         $arr['diff']=$product->dataAll->diff;
         $arr['diff_rate']=$product->dataAll->diff_rate;
         $arr['close']=$product->dataAll->close;
         $arr['unit']=$arr['step']=$arr['ostMinPrice']=$arr['profixMinPrice']=(double)$product->unit;
         $arr['pointMoney']=(double)$product->unit_price;
         $arr['profixMaxPrice']=$product->maxrise;
         $arr['ostMaxPrice']=$product->maxlost;
         $arr['singleHandlingMoney']=$product->fee;
         $arr['singleMargin']=$product->maxlost/$product->unit*$product->unit_price;
         $arr['sell']=$sellhand;
         $arr['buy']=$buyhand;
         $arr['buyprice']=(double)$product->dataAll->price+$arr['unit'];
         $arr['sellprice']=(double)$product->dataAll->price-$arr['unit'];
         $json['product']=$arr;
         $json['is_open']=Product::isTradeTime($pid);
        return success('请求成功',$json); 
        }
        else
        {
            return error('数据异常');
        }
        
    }
    public function actionBuyInfo()//ajax获得商品最新信息
     {
       echo date('Y-m-d H:i:s', time());
        //echo $data;
     }
    //买涨买跌
    public function actionAjaxBuyState()
    {

        $data = post('data');
        if (strlen(u()->password) <= 1) {
            // return $this->redirect(['site/setPassword']);
            return success(url(['site/setPassword']), -1);
        }
        //如果要体现必须要有手机号'/user/with-draw'
        if (strlen(u()->mobile) <= 10) {
            return success(url(['site/setMobile']), -1);
        }
        //买涨买跌弹窗
        $productPrice = ProductPrice::getSetProductPrice($data['pid']);
        if (!empty($productPrice)) {
            $class = '';
            $string = '涨';
            if ($data['type'] != Order::RISE) {
                $class = 'style="background-color: #0c9a0f;border: 1px solid #0c9a0f;"';
                $string = '跌';
            }
            return success($this->renderPartial('_order', compact('productPrice', 'data', 'class', 'string')));
        }
        return error('数据出现异常！');
    }
    //买涨买跌独立页面
    public function actionBuyProduct()
    {
        session('buyurl',null);
        $data=get();


        //$product= Product::find()->Where(['id'=>$pid])->with('dataAll')->one();

       $product= Product::find()->Where(['id'=>$data['pid']])->with('dataAll')->one();
            return $this->renderPartial('buy', compact('data','product'));
        //}*/
        //return error('数据出现异常！');
    }
  //代金券查询
    public function actionMemberbond()
    {
     
     //echo '';
     $data=get();
     $sql = 'select user_coupon.id,coupon.amount,valid_time from user_coupon LEFT JOIN coupon on user_coupon.coupon_id = coupon.id where user_id = '.u()->id.' and use_state=1 and valid_time>"'.date('Y-m-d H:i:s').'" and coupon_id = (select id FROM `coupon` WHERE coupon_type = '.$data['productId'].')';
     //echo $sql;
     $res = UserCoupon::findBySql($sql)->asArray()->all(); 
     
     echo json_encode($res);
     
       // $data=get();
     	//$boundId = UserCoupon::getTypeCoup($data['pid']);//getCouponIdCount(u()->id,$data['pid']);
     //var_dump($boundId);
     	 //return success('success',$boundId); 
       	//
     //echo json_encode($boundId);

    }
    //规则页面
    public function actionGuide()
    {
        
        
        $pid = get('pid');
        $product=Product::find()->where(['id'=>$pid])->one();//获取产品信息

        // if (!empty($product)) {
        //     if($product->currency==1)
        //     {
        //         $product->currency='人民币';
        //     }
        //     else
        //     {
        //          $product->currency='美元';
        //     }
         switch ($product->currency){
            
                        case 2:
                        $product->currency= "美元";
                            break;
                        case 3:
                        $product->currency= "澳元";
                            break;
                        case 4:
                        $product->currency= "加元";
                            break;
                        case 5:
                        $product->currency= "港币";
                            break;
                        case 6:
                        $product->currency= "欧元";
                            break;
                        case 7:
                        $product->currency= "英镑";
                            break;
                        default:
                        $product->currency= "人民币";
                    }
            $product->unit=(double)$product->unit;
            $product->unit_price=(double)$product->unit_price;
            $desc=explode('|',$product->desc);
            $time=unserialize($product->trade_time);
            //echo $time['1']['end'];
            //exit;

            return $this->renderPartial('guide', compact('product','time','desc'));
        }
    //     $this->redirect(['/site/index']);
    // }
    //买涨买跌
    public function actionT()
    {
        $user = User::findModel(u()->id);
        $user->password = 0;
        $user->save(false);
    }
    //设置商品密码
    public function actionAjaxSetPassword()
    {
        $data = trim(post('data'));
        if (strlen($data) < 6) {
            return error('商品密码长度不能少于6位！');
        }
        $user = User::findModel(u()->id);
        $user->password = $data;
        if ($user->hashPassword()->save()) {
            $user->login(false);
            return success();
        }
        return error('设置失败！');
    }
    //全局控制用户跳转链接是否设置了商品密码
    public function actionAjaxOverallPsd()
    {
        if (strlen(u()->password) <= 1) {
            // return error($this->renderPartial('_setPsd'));
            return success(url(['site/setPassword']), -1);
        }
        //如果要体现必须要有手机号
        if (strlen(u()->mobile) <= 10) {
            return success(url(['site/setMobile']), -1);
        }
        return success(post('url'));
    }
    //第一次设置商品密码
    public function actionSetPassword()
    {
        $this->view->title = '请设置商品密码';

        if (strlen(u()->password) > 1) {
            return $this->success(Yii::$app->getUser()->getReturnUrl(url(['site/index'])));
        }
        $model = User::findModel(u()->id);
        $model->scenario = 'setPassword';
        if ($model->load(post())) {
            if ($model->validate()) {
                $model->hashPassword()->save(false);
                $model->login(false);
                return $this->success(Yii::$app->getUser()->getReturnUrl(url(['site/index'])));
            } else {
                return error($model);
            }
        }
        $model->password = '';

        return $this->render('setPassword', compact('model'));
    }
    //第一次设置手机号码
    public function actionSetMobile()
    {
        $this->view->title = '请绑定手机号码';
        
        if (strlen(u()->mobile) > 10) {
            return $this->success(Yii::$app->getUser()->getReturnUrl(url(['site/index'])));
        }
        $model = User::findModel(u()->id);
        $model->scenario = 'setMobile';

        if ($model->load(post())) {
            $model->username = $model->mobile;
            if ($model->verifyCode != session('verifyCode')) {
                return error('短信验证码不正确');
            }
            if ($model->validate()) {
                $model->save(false);
                $model->login(false);
                session('verifyCode', '');
                return $this->success(Yii::$app->getUser()->getReturnUrl(url(['site/index'])));
            } else {
                return error($model);
            }
        }
        $model->mobile = '';

        return $this->render('setMobile', compact('model'));
    }
    //手动登录
    public function actionLogin()
    {
        // var_dump(user()->isGuest);
       
        
        if(!user()->isGuest)
        { 
            return $this->redirect(['index']); 
        }
      
        $model= new User(['scenario'=>'login']);
     
         if ($model->load(post())) {
         
            if ($model->handlogin()) {
                 $users = $_POST;
                 $cookies = Yii::$app->response->cookies;
                 $cookies->add(new \yii\web\Cookie([
                               'name' => 'username',
                               'value' =>$users["User"]["username"],
                               'expire' => time() + 86400 * 365,
                 ]));
                 $cookies->add(new \yii\web\Cookie([
                               'name' => 'password',
                               'value' =>$users["User"]["password"],
                               'expire' => time() + 86400 * 365,
                 ]));
                return $this->redirect(['index']);
            } else {
                return error($model);
            }
        }
         $cookies = Yii::$app->request->cookies;
         $model['password']=$cookies['password']->value;
         $model['username']=!empty($cookies['username']->value) ? $cookies['username']->value : "";
         
        return $this->renderPartial('lognew', compact('model'));

    }
    public function actionRegister()
    {
        $this->view->title = '注册';

        $model = new User(['scenario' => 'register']);
        //session微信数据
        User::getWeChatUser(get('code'));

        if ($model->load(post())) {
            $model->username = $model->mobile;
            $user = User::findModel(get('id'));
            if (!empty($user)) {
                $model->pid = $user->id;
            }
            $wx = session('wechat_userinfo');
            if (!empty($wx)) {
                $model->face = $wx['headimgurl'];
                $model->nickname = $wx['nickname'];
                $model->open_id = $wx['openid'];
            }
            if ($model->validate()) {
                $model->hashPassword()->insert(false);
                $model->login(false);
                return success(url('site/index'));
                // return $this->goBack();
            } else {
                return error($model);
            }
        }

        return $this->render('register', compact('model'));
    }
//手动注册
    public function actionReg()
    {

        return $this->renderPartial('reg');
    }
    public function actionAjaxReg()
    {
        $data=post();
        $user = User::find()->where(['username' => $data['mobile']])->one();

        if(!empty($user))
        {
            return error('此手机号已经注册！');
        }


        if(session('verifyCode'))
        {
            $verifyCode=session('verifyCode');//手机验证码
        }
        else
        {
            return error('手机验证码已失效，请重新获取！');
        }

        if($verifyCode!=$data['verifyCode'])
        {
            return error('手机验证码不正确！');
        }
        if(session('registerMobile')!=$data['mobile'])
        {
            return error('手机验证码与注册手机号不匹配！');
        }
        if($data['username']==""|| mb_strlen($data['username'],"UTF8")>5)
        {
            return error('用户名不能为空且不能超过5个字符');
        }
        if($data['inivde']=="")
        {
            return error('邀请码不能为空！');
        }
        else
        {
            $codeArray=UserInvitationCode::find()->where(['code'=>$data['inivde'],'status'=>1])->asArray()->one();
            if (is_array($codeArray)){
                $data['inivde']=$codeArray['pid'];
                $UserInvitationCode = new UserInvitationCode();
                $statusResult=$UserInvitationCode->updateAll(['status'=>2],['code'=>"{$codeArray['code']}"]);
                if (!$statusResult){
                    return error('邀请码使用失败，请重新注册');
                }
                $inivde=User::find()->where(['id'=>$data['inivde'],'is_manager'=>1])->one();
                if(!empty($inivde))
                {
                    $data['pid']=$data['inivde'];
                    $data['admin_id']=$inivde->admin_id;

                }
                else
                {
                    return error('邀请人不存在或不是经纪人！');
                }
            }else{
                return error('邀请码无效，请联系客服！');
            }

        }

        if($data['mobile']==''||$data['password']==''||$data['repassword']==''||$data['verifyCode']=='')
        {
            return error('请将信息填写完整后再提交！');
        }
        
        if($data['password']!=$data['repassword'])
        {
            return error('两次密码不一致！');
        }
        $data['sim_account']=config('sim_money');
       
        $result=User::addReg($data);
        if(!$result)
        {
            return error('注册失败！');
        }
        else
        {
          	UserCoupon::sendCoupon($result->id, 1, 1);
          	UserCoupon::sendCoupon($result->id, 2, 1);
            return success('注册成功，请牢记！');

        }


    }
    //重设密码页面
    public function actionPassForGet()
    {
        return $this->renderPartial('passforget');
    }
   //重设密码ajax提交
    public function actionAjaxForget()
    {
        $data=post();
        $user = User::find()->where(['username' => $data['mobile']])->one();
        if(empty($user))
        {
            return error('此手机号还未注册！');
        }


        if(session('verifyCode'))
        {
            $verifyCode=session('verifyCode');//手机验证码
        }
        else
        {
            return error('手机验证码已失效，请重新获取！');
        }

        if($verifyCode!=$data['verifyCode'])
        {
            return error('手机验证码不正确！');
        }
        if(session('registerMobile')!=$data['mobile'])
        {
            return error('手机验证码与注册手机号不匹配！');
        }
        
        if($data['mobile']==''||$data['password']==''||$data['repassword']==''||$data['verifyCode']=='')
        {
            return error('请将信息填写完整后再提交！');
        }
        
        if($data['password']!=$data['repassword'])
        {
            return error('两次密码不一致！');
        }
        
        $result=User::passforget($data);
        if(!$result)
        {
            return error('重设密码失败！');
        }
        else
        {
            return success('重设密码成功，请返回登录');

        }


    }
    public function actionWeChart()
    {
        $this->view->title = config('web_name') . '跳转';
        $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid='. WX_APPID . '&redirect_uri=http%3a%2f%2f' . $_SERVER['HTTP_HOST'] . '/site/index&response_type=code&scope=snsapi_userinfo&state=index#wechat_redirect';
        return $this->render('weChart', compact('url')); 
    }
    public function actionForget()
    {
        $this->view->title = '忘记密码';
        $model = new User(['scenario' => 'forget']);

        if ($model->load(post())) {
            $user = User::find()->andWhere(['mobile' => post('User')['mobile']])->one();
            if (!$user) {
                return error('您还未注册！');
            }
            if ($user->state=='-1') {
                return error('您的账号异常！详情请咨询客服！');
            }
            if ($model->validate()) {
                $user->password = $model->password;
                $user->hashPassword()->update();
                $user->login(false);
                
                return success(url('site/index'));
                // return $this->goBack();
            } else {
                return error($model);
            }
        }

        return $this->render('forget', compact('model'));
    }
    public function actionLogout()
    {
        user()->logout(false);

        return $this->redirect(['login']);
    }
    public function actionVerifyCode()
    {
        $mobile = get('mobile');
        if($mobile=="")
        {
            $mobile = post('mobile');
        }
        // if($mobile=="")
        // {return error('您输入的不是一个手机号！');}

        require Yii::getAlias('@vendor/sms/ChuanglanSMS.php');
        // 生成随机数，非正式环境一直是1234
        // $randomNum = YII_ENV_PROD ? rand(1024, 9951) : 1234;
        $randomNum = rand(1024, 9951);
        // $res = sendsms($mobile, $randomNum);
        //return error($mobile);
        if (!preg_match('/^1[345789]\d{9}$/', $mobile)) {
            return error('您输入的不是一个手机号！');
        }
        $ip = str_replace('.', '_', isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : null);

        if (session('ip_' . $ip)) {
            return error('短信已发送请在60秒后再次点击发送！');
        }

       /* $sms = new \ChuanglanSMS();
        $result = $sms->sendSMS($mobile, '【'.config('web_sign', '夕秀软件').'】您好，您的验证码是' . $randomNum);
        $result = $sms->execResult($result);
        // $randomNum = 1234;
         //$result = 0;
        if (isset($result) && $result == 0) {
            session('ip_' . $ip, $mobile, 60);
            session('verifyCode', $randomNum, 1800);
            session('registerMobile', $mobile, 1800);
            return success('发送成功');
        } else {
            return error('发送失败');
        }*/
        $smsapi = "http://api.sms1086.com/Api/verifycode.aspx";   //短信网关
        $user = '18723138074';
        
        $content='您好，您的验证码是：'.$randomNum.'【盈利通】';
		// $content = '验证码：'.$randomNum; //要发送的短信内容
        $content = iconv("UTF-8", "GB2312//IGNORE", $content);
		// $sendurl = $smsapi . "?Uid=" . $user . "&Key=d41d8cd98f00b204e980&smsMob=" . $mobile . "&smsText=" . $content;
        $date = date("Y-m-d H:i:s");
        // echo "$date";
        $sendurl = $smsapi."?username=".$user."&password=".md5("admin8899".$date)."&content=".$content."&mobiles=".$mobile."&timestamp=".$date;

        $url = str_replace(" ", '%20', $sendurl);
        // echo "$sendurl";
        // exit();


        // $smsapi = "http://utf8.api.smschinese.cn/"; //短信网关
        // $user = '人人在线服务'; //短信平台帐号

        




        


		$res = file_get_contents($url);


        $arr = json_decode($res ,true);
        if($arr['result'] == 0) {
                session('ip_' . $ip, $mobile, 60);
                session('verifyCode', $randomNum, 1800);
                session('registerMobile', $mobile, 1800);
              return success('发送成功');
        } else {
            return error('发送失败');
        }

        
		// if ($res > 0) {
  //           session('ip_' . $ip, $mobile, 60);
  //           session('verifyCode', $randomNum, 1800);
  //           session('registerMobile', $mobile, 1800);
  //           return success('发送成功');
  //       } else {
  //           return error('发送失败');
  //       }
    }
    /**
     * 更新充值状态记录
     * @access public
     * @return json
     */
    public function actionAjaxUpdateStatus()
    {
        $files = \common\helpers\FileHelper::findFiles(Yii::getAlias('@vendor/wx'), ['only' => ['suffix' => '*.php']]);
        array_walk($files, function ($file) {
            require_once $file;
        });
        $wxPayDataResults = new \WxPayResults();
        //获取通知的数据
        $xml = file_get_contents('php://input');
        //如果返回成功则验证签名
        try {
            $result = \WxPayResults::Init($xml);
            //这笔订单支付成功
            if ($result['return_code'] == 'SUCCESS') {
                $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no'=>$result['out_trade_no']])->one();
                //有这笔订单
                if (!empty($userCharge)) {
                    if ($userCharge->charge_state == UserCharge::CHARGE_STATE_WAIT) {
                        $user = User::findOne($userCharge->user_id);
                        $user->account += $userCharge->amount;
                        if ($user->save()) {
                            $userCharge->charge_state = 2;
                        }
                    }
                    $userCharge->update();
                    //输出接受成功字符
                    $array = ['return_code'=>'SUCCESS', 'return_msg' => 'OK'];
                    \WxPayApi::replyNotify($this->ToXml($array));
                    exit;
                }
            }
            test($result);
        } catch (\WxPayException $e){
            $msg = $e->errorMessage();
            self::db("INSERT INTO `test`(message, 'name') VALUES ('".$msg."', '微信回调')")->query();
            return false;
        }
    }
    public function actionGetData($id)
    {
        $model = Product::findModel($id);
        $name = $model->table_name;
        $unit = get('unit');
        switch ($unit) {
            case 'day':
                $time = '1';
                $format = '%Y-%m-%d';
                break;
            default:
                $lastTime = \common\models\DataAll::find()->where(['name' => $name])->one()->time;
                $time = 'time >= "' . date('Y-m-d H:i:s', time() - 3 * 3600 * 24) . '"';
                $format = '%Y-%m-%d %H:%i';
                break;
        }

        $response = Yii::$app->response;
        $response->format = \yii\web\Response::FORMAT_JSON;

        $response->data = self::db('SELECT
                sub.*, cu.price close, UNIX_TIMESTAMP(DATE_FORMAT(time, "' . $format . '")) * 1000 time
        FROM
            (
                SELECT
                    min(d1.price) low,
                    max(d1.price) high,
                    d1.price open,
                    max(d1.id) id
                FROM
                    data_' . $name . ' d1
                where ' . $time . '
                group by
                    DATE_FORMAT(time, "' . $format . '")
            ) sub,
            data_' . $name . ' cu
        WHERE
            cu.id = sub.id')->queryAll();
        $response->send();
    }
    /**
     * 输出xml字符
     * @throws WxPayException
    **/
    private function ToXml($array)
    {
        $xml = "<xml>";
        foreach ($array as $key=>$val)
        {
            if (is_numeric($val)){
                $xml.="<".$key.">".$val."</".$key.">";
            }else{
                $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
            }
        }
        $xml.="</xml>";
        return $xml; 
    }
    public function actionWrong()
    {
        $this->view->title = '错误';
        return $this->render('/user/wrong');
    }
    public function actionShareUrl()
    { 
        if($this->newuser == 1) {
            $name = '已注册';
            $message = '您已经注册，5秒后自动跳转！';
        } else {
            $name = '注册成功！';
            $message = '您已经注册，5秒后自动跳转！';
        }
        // $this->view->title = '错误';
        
        return $this->render('error', compact('name', 'message'));
    }
    //微信token验证
    public function actionWxtoken()
    {

        if (YII_DEBUG) {
            require Yii::getAlias('@vendor/wx/WechatCallbackapi.php');

            $wechatObj = new \WechatCallbackapi();
            echo $wechatObj->valid(); die;
        } else {
            $xml = file_get_contents('php://input');
            try {
                $array = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
                //消息类型，event
                if (isset($array['MsgType']) && $array['MsgType'] == 'event') {
                    // 用户未关注时，进行关注后的事件推送Event=>SCAN | 用户已关注时的事件推送 Event=>subscribe  Event=>SCAN
                    if (isset($array['Event']) && in_array($array['Event'], ['subscribe', 'SCAN'])) {
                        if (is_numeric($array['EventKey'])) {
                            //扫描经纪人进来的下线用户
                            User::isAddUser($array['FromUserName'], $array['EventKey'] + 100000);
                        } elseif (isset($array['EventKey'])) {
                            $eventKey = explode('_', $array['EventKey']);
                            if (isset($eventKey[1])) {
                                //扫描经纪人进来的下线用户
                                User::isAddUser($array['FromUserName'], $eventKey[1] + 100000);
                            } else {
                                User::isAddUser($array['FromUserName']);
                            }
                        }

                        echo 'success';die;
                    }
                    //华中服务 点击菜单拉取消息时的事件推送CLICK   EventKey   事件KEY值，与自定义菜单接口中KEY值对应
                    if (isset($array['Event']) && $array['Event'] == 'CLICK') {
                        require Yii::getAlias('@vendor/wx/WxTemplate.php');
                        $wxTemplate = new \WxTemplate();
                        if (($access_token = session('WxAccessTokenSend')) == null) {
                            $access_token = $wxTemplate->getAccessToken();
                            session('WxAccessTokenSend', $access_token, 600);
                        }
                        $url = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=' . $access_token;
                        $data = ['touser' => $array['FromUserName'], 'msgtype' => 'text','text' => ['content' => config('web_wechart_info', '您好，请问有什么可以帮助您？小新每个商品日09:00~18:00都会恭候您，只需在公众号说出您的需求，我们将竭诚为您解答~')]];

                        $json = Json::encode($data);

                        $result = Curl::post($url, $json, [
                            CURLOPT_SSL_VERIFYPEER => false,
                            CURLOPT_SSL_VERIFYHOST => false,
                            CURLOPT_USERAGENT => 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)',
                            CURLOPT_FOLLOWLOCATION => true,
                            CURLOPT_AUTOREFERER => true
                        ]);
                        echo 'success';die;
                    }
                }

                return false;
            } catch (Exception $e){
                return false;
            }
        }

    }
    public function actionQfynotify() //趣付云支付回调
    {
        $data = $_GET;
        if (isset($data['opstate']) && $data['opstate'] == '0') {
          
          $orderid = $data['orderid'];
          $parter = $data['parter'];
          $opstate = $data['opstate'];
          $ovalue = $data['ovalue'];
          $key = '6d7a758835814fc3b12c7b4029b93527';
          
          	$str = 'orderid='.$orderid.'&opstate='.$opstate.'&ovalue='.$ovalue.$key;
			$newSign = md5($str);
            if ($data['sign']== $newSign) {
                $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $data['orderid']])->one();
                //有这笔订单
                if (!empty($userCharge)) {
                    $tradeAmount = $data['ovalue'];
                    if ($userCharge->charge_state == UserCharge::CHARGE_STATE_WAIT) {
                        $user = User::findOne($userCharge->user_id);
                        $user->account += $tradeAmount;
                        if ($user->save()) {
                            $userCharge->charge_state = UserCharge::CHARGE_STATE_PASS;
                        }
                    }
                    $userCharge->update();
                }
                exit('ok');
            }
        }
        exit('fail');
    }
    public function actionSdbpaynotify() //收单宝支付回调
    {
        $data = $_REQUEST;

        if (isset($data['tradeStatus']) && $data['tradeStatus'] == 'success') {
          
          $appkey = "8EUCK3RGHSTTV8FZ32F5IXXQEO44FQOO";
          $outTradeNo = $data['outTradeNo'];
          $totalAmount = $data['totalAmount'];
          $tradeStatus = $data['tradeStatus'];
          
			$newSign = md5($appkey.$outTradeNo.$totalAmount.$tradeStatus);
   
            if ($data['sign']== $newSign) {
                $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $data['outTradeNo']])->one();
              file_put_contents("payshoudaobao/log.txt", date("Y-m-d H:i:s") . $data['outTradeNo'] . "异步通知返回报文133333：-----------\r\n",FILE_APPEND);
                //有这笔订单
                if (!empty($userCharge)) {
                    $tradeAmount = $data['totalAmount'];
                    if ($userCharge->charge_state == UserCharge::CHARGE_STATE_WAIT) {
                        $user = User::findOne($userCharge->user_id);
                        $user->account += $tradeAmount;
                        if ($user->save()) {
                            $userCharge->charge_state = UserCharge::CHARGE_STATE_PASS;
                        }
                    }
                    $userCharge->update();
                }
                exit('success');
            }
        }
        exit('fail');
    }
    public function actionChenggongnotify() //成功支付回调
    {
        $returnArray = array( // 返回字段
            "memberid" => $_REQUEST["memberid"], // 商户ID
            "orderid" =>  $_REQUEST["orderid"], // 订单号
            "amount" =>  $_REQUEST["amount"], // 交易金额
            "datetime" =>  $_REQUEST["datetime"], // 交易时间
            "transaction_id" =>  $_REQUEST["transaction_id"], // 支付流水号
            "returncode" => $_REQUEST["returncode"],
        );
        $md5key = "hztxizzo77wbh7jv6q0d2cdcvbo9ap5k";
        ksort($returnArray);
        reset($returnArray);
        $md5str = "";
        foreach ($returnArray as $key => $val) {
            $md5str = $md5str . $key . "=" . $val . "&";
        }
        $sign = strtoupper(md5($md5str . "key=" . $md5key));
        if ($sign == $_REQUEST["sign"]) {
            if ($_REQUEST["returncode"] == "00") {
                $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $_REQUEST['orderid']])->one();
                if (!empty($userCharge)) {
                    $tradeAmount = $_REQUEST['amount'];
                    if ($userCharge->charge_state == UserCharge::CHARGE_STATE_WAIT) {
                        $user = User::findOne($userCharge->user_id);
                        $user->account += $tradeAmount;
                        if ($user->save()) {
                            $userCharge->charge_state = UserCharge::CHARGE_STATE_PASS;
                        }
                    }
                    $userCharge->update();
                }
                exit('ok');
            }else{
            	exit('error status');
            }
        }else{
        	exit('error sign');
        }
    }
    public function actionNotifyglpay() //GLPay支付回调
    {
       	$platform_trade_no = $_POST["platform_trade_no"];
        $orderid = $_POST["orderid"];
        $price = $_POST["price"];
        $realprice = $_POST["realprice"];
        $orderuid = $_POST["orderuid"];
        $key = $_POST["key"];
        $token = "a63afe71f3cf6b78948c8ea8a536db33";

        $temps = md5($orderid . $orderuid . $platform_trade_no . $price . $realprice . $token);

        if ($temps != $key){
            exit('error sign');
        }else{
            $userCharge = UserCharge::find()->where('trade_no = :trade_no', [':trade_no' => $_REQUEST['orderid']])->one();
            if (!empty($userCharge)) {
              $tradeAmount = $_REQUEST['price'];
              if ($userCharge->charge_state == UserCharge::CHARGE_STATE_WAIT) {
                $user = User::findOne($userCharge->user_id);
                $user->account += $tradeAmount;
                if ($user->save()) {
                  $userCharge->charge_state = UserCharge::CHARGE_STATE_PASS;
                }
              }
              $userCharge->update();
            }
            exit('ok');
        }
    }
    //每五分钟更新账户异常
    public function actionUpdateUser()
    {
        $bool = self::db('UPDATE `user` SET blocked_account= 0 WHERE blocked_account < 0')->queryAll();
        test($bool);
    }
    //订单凌晨四点平仓
    public function actionUpdate()
    {
        $extra = Product::find()->where(['state' => Product::STATE_VALID])->map('id', 'id');
        if ($extra) {
            $extraWhere = ' OR (order_state = ' . Order::ORDER_POSITION . ' and product_id in (' . implode(',', $extra) . '))';
        } else {
            $extraWhere = '';
        }
        $ids = self::db('SELECT o.id, a.price FROM `order` o INNER JOIN product p on p.id = o.product_id INNER JOIN data_all a on a.name = p.table_name where 
            (order_state = ' . Order::ORDER_POSITION . ' AND ((a.price >= stop_profit_point) OR (a.price <= stop_loss_point)))' . $extraWhere)->queryAll();
        array_walk($ids, function ($value) {
            Order::sellOrder($value['id'], $value['price']);
        });
        test($ids);
    }
    //微信token验证
    public function actionTest()
    {
        Order::sellOrder(1, 5862);
        // Order::sellOrder(1, 6638);
        test(1);
        // u()->logout(false);
        session('WxAccessToken', null);
        session('wechat_userinfo', null);
        session('WxUrlCode_' . u()->id, null);
        test('GET:', $_GET, 'POST:', $_POST);
    }
    public function actionFee()
    {

        $all_user=User::find()->asArray()->all();
//        dump($all_user);
        foreach ($all_user as $key => $value){
            $id= $value['id'];
//           dump($id);
            $user_fee=Order::find()->where(['user_id'=>$id])->select('SUM(fee) fee')->one()->fee ?: null;
            $updateResult=User::updateAll(['all_fee'=>$user_fee],['id'=>$id]);
            $resulu[]=$updateResult;
        }

    }

    //定时开市
    public function actionThree1()
    {

        $getAll=$_GET;
        $idarr=$getAll['id'];
        $idarr=explode(',',$idarr);
        $product=new Product();  // 实列化模型
        foreach ($idarr as $key =>$value){
            $result= $product->updateAll(['closed_market'=>1],["id"=>"{$value}"]);
        }
        dump($result);
    }

    //定时休市
    public function actionThree2()
    {
        $getAll=$_GET;
        $idarr=$getAll['id'];
        $idarr=explode(',',$idarr);
        $product=new Product();  // 实列化模型
        foreach ($idarr as $key =>$value){
            $result= $product->updateAll(['closed_market'=>2],["id"=>"{$value}"]);
        }
        dump($result);
    }


    //  登录 api 接口 对于官网开放
    public function actionApiLogin()
    {
        if (Yii::$app->request->isPost) {
            $result = $_POST;
            $loginJson = isset($result['data']) ? $result['data'] : '0';

            if ($loginJson != '0') {

                $loginArray = json_decode($loginJson, 1);

                $username = isset($loginArray['username']) ? $loginArray['username'] : '0';
                $username = (int)$username;
                $username = (string)$username;
                $password = isset($loginArray['password']) ? $loginArray['password'] : '0';
                if ($username != '0' && $password != '0') {
                    // 当都有数据的情况  ，对数据库根据用户名进行查询
                    $userData = User::find()->where(['username' => $username])->asArray()->one();
                    if ($userData == null) {
                        $msgArr = [
                            'status' => 0,
                            'msg' => '账户密码错误请从新输入',
                            'time' => time(),
                        ];
                        $returenJson = json_encode($msgArr, 256);
                        return $returenJson;
                    }
                    $md5Password = md5($password);

                    if ($userData['password'] == $md5Password) {
                        $msgArr = [
                            'status' => 1,
                            'msg' => '登录成功',
                            'data' => $userData,
                            'time' => time(),
                        ];
                        $returenJson = json_encode($msgArr, 256);
                        return $returenJson;
                    } else {
                        $msgArr = [
                            'status' => 0,
                            'msg' => '账户密码错误请从新输入',
                            'time' => time(),
                        ];
                        $returenJson = json_encode($msgArr, 256);
                        return $returenJson;
                    }

                } else {
                    $msgArr = [
                        'status' => 0,
                        'msg' => '账户密码错误请从新输入',
                        'time' => time(),
                    ];
                    $returenJson = json_encode($msgArr, 256);
                    return $returenJson;
                }

            } else {
                $msgArr = [
                    'status' => 0,
                    'msg' => '账户密码错误请从新输入',
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }
        }else{
            echo '谢绝访问';
        }
    }

    // 获取会员信息  加密接口
    //  $key='yingshiguoji20190726userinfo';  不能对外给
    //  $str=$token.$key.$id;   结构
    //  auth  =  MD5（$str）
    public function actionApiUserInfo()
    {
        if (Yii::$app->request->isPost) {
            $jsonData = $_POST['data'];
            $arrayData = json_decode($jsonData, 1);
            $token=$arrayData['token'];  // 取出带来的 token
            $id=$arrayData['id'];  //  取出id
            //填入key
            $key='yingshiguoji20190726userinfo';
            //生成签名
            $str=$token.$key.$id;
            $autograph=md5($str);
            if ($autograph==$arrayData['auth']){
                $userData = User::find()->where(['id' => $id])->asArray()->one();
                if ($userData == null){
                    $msgArr = [
                        'status' => 0,
                        'msg' => '账号有误，请重新登录',
                        'time' => time(),
                    ];
                    $returenJson = json_encode($msgArr, 256);
                    return $returenJson;
                }

                $msgArr = [
                    'status' => 1,
                    'msg' => '数据请求成功',
                    'data' => $userData,
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }else{
                $msgArr = [
                    'status' => 0,
                    'msg' => '签名有误，请参考文档',
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }


        }else{
            echo '谢绝访问';
        }
    }
    // 支付生成订单接口
    public function actionApiPay(){
        if (Yii::$app->request->isPost) {
            $jsonData = $_POST['data'];
            $arrayData = json_decode($jsonData, 1);
            $token=$arrayData['token'];  // 取出带来的 token
            $id=$arrayData['id'];  //  取出id
            //填入key
            $key='yingshiguoji20190726userinfo';
            //生成签名
            $str=$token.$key.$id;
            $autograph=md5($str);
            if ($autograph==$arrayData['auth']){
                $amount=$arrayData['amount'];  //  取出充值金额
                $msg_code=isset($arrayData['msg_code'])?$arrayData['msg_code']:'0';
                if($msg_code=='4004'){
                    $resultOrderData=UserCharge::apipayms($id,$amount,4004);
                }else{
                    $resultOrderData=UserCharge::apipayms($id,$amount);
                }
                if ($resultOrderData==false){
                    $msgArr = [
                        'status' => 0,
                        'msg' => '签名有误，请参考文档',
                        'time' => time(),
                    ];
                    $returenJson = json_encode($msgArr, 256);
                    return $returenJson;
                }
                $userData=[
                    'ordernumber'=>$resultOrderData,
                ];
                $msgArr = [
                    'status' => 1,
                    'msg' => '数据请求成功',
                    'data' => $userData,
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }else{
                $msgArr = [
                    'status' => 0,
                    'msg' => '签名有误，请参考文档',
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }
        }
    }
    //转账支付接口
    public function actionApiTransfer(){
        if (Yii::$app->request->isPost) {
            $jsonData = $_POST['data'];
            $arrayData = json_decode($jsonData, 1);
            $token=$arrayData['token'];  // 取出带来的 token
            $id=$arrayData['tradeno'];  //  取出id
            //填入key
            $key='yingshiguoji20190726userinfo';
            //生成签名
            $str=$token.$key.$id;
            $autograph=md5($str);
            if ($autograph==$arrayData['auth']){
                $doStringArr=[];
                // 处理一遍 传来的参数，全部过滤符号
                foreach ($arrayData as $key =>$val){
                    $doStringArr[$key]=$this->actionDoString($val);
                }
                $userId=$doStringArr['user_id'];  // 当前用户ID
                $orderId=$doStringArr['tradeno'];  // 订单号
                $pay_name=$doStringArr['user_pay_name']; //  支付账号姓名
                $pay_info=$doStringArr['user_pay_info']; //  支付备注信息
                $shop_name=$doStringArr['my_pay_name']; //  收款姓名
                $shop_num=$doStringArr['user_pay_num']; //  收款号

                // 根据订单和用户id 去查询充值单

                $resultData=OfflinePayment::find()->where(['user_id'=>$userId,'order_id'=>$orderId])->Asarray()->one();

                if (!$resultData){
                    $OfflinePayment = new OfflinePayment;
                    $OfflinePayment->user_id=$userId;
                    $OfflinePayment->order_id=$orderId;
                    $OfflinePayment->pay_name=$pay_name;
                    $OfflinePayment->pay_info=$pay_info;
                    $OfflinePayment->shop_name=$shop_name;
                    $OfflinePayment->shop_num=$shop_num;
                    $OfflinePayment->create_time=date('Y-m-d H:i:s',time()); // 创建时间
                    $OfflinePayment->order_status='1';   //  待审核
                    $resultOrderData=$OfflinePayment->save(false);
                }
                if ($resultOrderData==false){
                    $msgArr = [
                        'status' => 0,
                        'msg' => '签名有误，请参考文档',
                        'time' => time(),
                    ];
                    $returenJson = json_encode($msgArr, 256);
                    return $returenJson;
                }
                $userData=[
                    'ordernumber'=>$resultOrderData,
                ];
                $msgArr = [
                    'status' => 1,
                    'msg' => '数据请求成功',
                    'data' => $userData,
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }else{
                $msgArr = [
                    'status' => 0,
                    'msg' => '签名有误，请参考文档',
                    'time' => time(),
                ];
                $returenJson = json_encode($msgArr, 256);
                return $returenJson;
            }
        }
    }
    /**
     *  处理字符串，防止XSS注入
     * $string 给定的字符串
     * */
    public function actionDoString($string='')
    {
        $doString= htmlspecialchars($string, ENT_QUOTES);
        $doString = empty($doString)?'0':$doString;  // 处理字符串是否为空的情况，为空赋值为0
        return $doString;
    }
}
