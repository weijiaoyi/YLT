<?php

namespace admin\controllers;

use Yii;
use admin\models\Product;

class RiskController extends \admin\components\Controller
{
    /**
     * @authname 风险控制
     */
    public function actionCenter()
    {
        $switch = option('risk_switch');
        $products = Product::find()->where(['on_sale' => Product::ON_SALE_YES, 'state' => Product::STATE_VALID])->asArray()->all();
        $risk_product = option('risk_product') ?: [];

        if (req()->isPost) {
            option('risk_switch', post('risk_switch'));
            if ($post = post('product', [])) {
                foreach ($post as $product => $value) {
                    $params[$product] = $value;
                }
                option('risk_product', $params);
            }


            return success();
        }

        return $this->render('center', compact('switch', 'products', 'risk_product'));
    }


    public function actionMarket()
    {

        if (req()->isPost){   // 判断是不是post 请求
           $post= post(); // 取出post的值
          foreach ($post as $key =>$value){
              $id=$key;
          }
            $arr=explode('-',$id);   // 字符串分割
          $id=$arr[0];  //  取出传来的ID号
          $status=$arr[1];  // 取出传来的状态
            $product=new Product();  // 实列化模型
          if ($status=='1'){
              $result= $product->updateAll(['closed_market'=>2],["id"=>"{$id}"]); //  休市
            }else{
              $result= $product->updateAll(['closed_market'=>1],["id"=>"{$id}"]); // 开市
            }
        }
//        $getData=get();
//        dump($getData);
        $products = Product::find()->asArray()->all();  //  查询出所有 的 商品

        return $this->render('market',compact('products'));
    }

}
