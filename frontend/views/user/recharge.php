<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
        <meta name="keywords" content="股指期货,恒指">
        <meta name="description" content="<?=config('web_name')?>,恒指">
        <title><?=config('web_name')?></title>
        <link rel="stylesheet" href="/test/base.css?r=20170520">
        <link rel="stylesheet" href="/test/main.css?r=20170520">
        <link rel="stylesheet" href="/test/main-blue.css?r=20170520">
        <script type="text/javascript" src="/test/mui.min.js"></script>
        
</head>

<?php $this->regCss('iconfont/iconfont.css')?>
<?php $this->regCss('mine.css')?>
<?php $this->regCss('common.css')?>
<style type="text/css">body{background:#fff;}</style>
<ul class="index-head flex col-w">
        <li class="le"><a onclick="JavaScript:history.back(-1);" class="col-w"><i class="iconfont"></i></a></li>
        <li class="mid">充值</li>
        <li class="ri"><a class="col-w"></a></li>
</ul>
<div style="height: .45rem; width: 100%;"></div>

<div class="container " style="padding:0;">
    <p class="selecthe">选择充值面额（元）</p>
    <?php $form = self::beginForm(['showLabel' => false, 'action' => url(['user/pay']), 'id' => 'payform', 'method' => 'get'])?>
    <div class="boxflex1 paystyle" style="padding: 10px 15px 0;">
        <div class="group_btn group clearfloat">

            <div class="btn_re" >
                <a class="btn_money">180</a>
            </div>
            <div class="btn_re" >
                <a class="btn_money">1880</a>
            </div>
            <div class="btn_re" >
                <a class="btn_money">2880</a>
            </div>
            <div class="btn_re" >
                <a class="btn_money">3880</a>
            </div>
        </div>
        <div class="group_btn group clearfloat">
            <div class="btn_re"  >
                <a class="btn_money">8800</a>
            </div>
            <div class="btn_re" >
                <a class="btn_money">16800</a>
            </div>
            <div class="btn_re" >
                <a class="btn_money">28800</a>
            </div>
           <div class="btn_re" >
                <a class="btn_money">38800</a>
            </div>
        </div>
        充值金额：<input type="text" id="amount" name="amount" readonly value="150">
        <input type="hidden" id="type" name="type" value="2">
    </div>
    
  <div style="display">
  <div class="boxflex1 paystyle">
        <div class="moneyhead" >充值方式</div>
    </div>
      <!--
         <div class="boxflex1 paystyle checkImg7" style="border-top:0;">
            <img src="/images/alipay1.png" style="float:left; width: 3em;height: 3em;margin-right: 1em;">
            <span style="font-size: 1em; ">支付宝</span><br>
            <span style="font-size: 0.8em; ">推荐有支付宝的用户使用</span>
            <img src="/images/seleted.png" alt="" style="float:right;" class="check-7" >
        </div>
             -->
       <!--
        <div class="boxflex1 paystyle checkImg6" style="border-top:0;">
            <span>支付宝充值2</span>
            <img src="/images/notseleted.png" alt="" style="float:right;" class="check-6" >
        </div>


         <div class="boxflex1 paystyle checkImg8" style="border-top:0;">
            <span>支付宝充值3</span>
            <img src="/images/seleted.png" alt="" style="float:right;" class="check-8" >
        </div>
         <div class="boxflex1 paystyle checkImg9" style="border-top:0;">
            <span>微信扫码1</span>
            <img src="/images/notseleted.png" alt="" style="float:right;" class="check-9" >
        </div>
     -->
     <?php //$H=(int)date('H',time());if ($H > 6){

         ?>
      <div class="boxflex1 paystyle checkImg1" style="border-top:0;">
         <img src="/images/wxpay2.png" style="float:left;width: 3em;height: 3em;margin-right: 1em;">
        <span style="font-size: 1em; ">微信支付</span><br>
        <span style="font-size: 0.8em;">微信支付安全</span>
        <img src="/images/notseleted.png" alt="" style="float:right;" class="check-1" >
    </div>
      <?php //}?>

      <?php //if (u()->id ==100396){?>
          <div class="boxflex1 paystyle checkImg9" style="border-top:0;">
              <img src="/images/saoma.jpg" style="float:left;width: 3em;height: 3em;margin-right: 1em;">
              <span>扫码支付</span></br>
              <span style="font-size: 0.8em;">扫码支付</span>
              <img src="/images/notseleted.png" alt="" style="float:right;" class="check-9" >
          </div>
      <?php //}?>
      <div class="boxflex1 paystyle checkImg2" style="border-top:0;">
          <img src="/images/bankcard.png" style="float:left;width: 3em;height: 3em;margin-right: 1em;">
          <span style="font-size: 1em; ">银行卡支付</span><br>
          <span style="font-size: 0.8em;">银行卡支付安全</span>
          <img src="/images/seleted.png" alt="" style="float:right;" class="check-2" >
      </div>

      <!--     <div class="boxflex1 paystyle checkImg2" style="border-top:0;">-->
<!--        <span>微信扫码2</span>-->
<!--        <img src="/images/notseleted.png" alt="" style="float:right;" class="check-2" >-->
<!--    </div>-->
  </div>
  
    <div class="recharge-btn" id="payBtn">立即充值</div>

    <?php self::endForm()?>
    <div class="row">
        <!-- <div class="col-xs-12 text-center font_14 remain">跳转至微信安全支付网页，微信转账说明</div> -->
<!--         <div class="col-xs-12 text-center font_12">
            <font>注1：暂时只能使用借记卡充值</font>
            <br>
            <font>注2：为了管控资金风险，单日充值限额20000元</font>
        </div> -->
    </div>
</div>
<script>
$(function() {
    $('#type').val('4006');
    $(".btn_money").click(function() {
        $(".on").removeClass("on");
        $(this).addClass("on");
        $('#amount').val($(this).html());
    });

    $('#payBtn').on('click', function(){
        var amount = $('#amount').val();
        var type = $('#type').val();
        if(!amount || isNaN(amount) || amount <= 0){
            alert('金额输入不合法!');
            return false;
        }
        // var url = "http://103.230.241.135/user/pay?type="+type+"&amount="+amount;
        // // alert(url);
        // //打开关于页面
        // mui.openWindow({
        //     'url': url, 
        //     'id':'info'
        // });
        $("#payform").submit();
    });

 
    $(".checkImg6").click(function(){
        $('#type').val('4001');
        $(this).find('.check-6').attr({
            "src":"/images/seleted.png"
        })

        $(".check-1,.check-2,.check-3,.check-4,.check-5,.check-7,.check-8,.check-9,.check-10").attr({
            "src":"/images/notseleted.png"
        })
    })
    $(".checkImg7").click(function(){
        $('#type').val('4002');
        $(this).find('.check-7').attr({
            "src":"/images/seleted.png"
        })

        $(".check-1,.check-2,.check-3,.check-4,.check-5,.check-6,.check-8,.check-9,.check-10").attr({
            "src":"/images/notseleted.png"
        })
    })
  $(".checkImg8").click(function(){
        $('#type').val('4003');
        $(this).find('.check-8').attr({
            "src":"/images/seleted.png"
        })

        $(".check-1,.check-2,.check-3,.check-4,.check-5,.check-6,.check-7,.check-9,.check-10").attr({
            "src":"/images/notseleted.png"
        })
    })
  $(".checkImg9").click(function(){
        $('#type').val('4004');
        $(this).find('.check-9').attr({
            "src":"/images/seleted.png"
        })

        $(".check-1,.check-2,.check-3,.check-4,.check-5,.check-6,.check-7,.check-8,.check-10").attr({
            "src":"/images/notseleted.png"
        })
    })
  
   $(".checkImg1").click(function(){
        $('#type').val('4005');
        $(this).find('.check-1').attr({
            "src":"/images/seleted.png"
        })

        $(".check-9,.check-2,.check-3,.check-4,.check-5,.check-6,.check-7,.check-8,.check-10").attr({
            "src":"/images/notseleted.png"
        })
    })
  
   $(".checkImg2").click(function(){
        $('#type').val('4006');
        $(this).find('.check-2').attr({
            "src":"/images/seleted.png"
        })

        $(".check-1,.check-9,.check-3,.check-4,.check-5,.check-6,.check-7,.check-8,.check-10").attr({
            "src":"/images/notseleted.png"
        })
    })

})
</script>

