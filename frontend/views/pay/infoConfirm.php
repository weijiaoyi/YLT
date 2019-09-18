<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>确认支付信息</title>
    <meta http-equiv="X-UA-compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
<!--    <meta name="viewport" content="width=device-width, initial-scale=1">-->
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <style>
        .a-upload {
            padding: 4px 10px;
            height: 32px;
            line-height: 26px;
            position: relative;
            cursor: pointer;
            color: #888;
            background: #fafafa;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            display: inline-block;
            *display: inline;
            *zoom: 1
        }

        .a-upload  input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer
        }

        .a-upload:hover {
            color: #444;
            background: #eee;
            border-color: #ccc;
            text-decoration: none
        }
        .headertext{
            width: 100% ;
            background-color: #ccccccba;
            height: 3em;
            text-align: center;
        }
        .headertext H4{
            padding-top: 1em;
        }
        .boody{
            background-color: #F2F2F2;
        }

        .tab-menu ul{
            padding: 0;
            margin: 0;
        }
        .tab-menu ul li{
            display: inline-block;
            width: 8em;
            height: 30px;
            line-height: 30px;
            text-align: center;
            cursor: pointer;
        }
        .tab-menu ul li.active{
            background: #749dcf;
        }
        .tab-con div{
            width: 80%;
            height: 20%;
            background: #F2F2F2;
            display: none;
            margin: auto;
        }
        .tab-con div:first-child{
            display: block;
        }
        #input0 {position: absolute;top: 0;left: 0;opacity: 0;z-index: -10;}
        #input1 {position: absolute;top: 0;left: 0;opacity: 0;z-index: -10;}
        #input2 {position: absolute;top: 0;left: 0;opacity: 0;z-index: -10;}
        #input21 {position: absolute;top: 0;left: 0;opacity: 0;z-index: -10;}
    </style>
</head>
<body class="boody">
<link rel="stylesheet" href="/test/main.css?r=20170520">
<ul class="index-head flex col-w" style="background: #000;color: #fff;text-align: center;">
    <li class="le" style="width: 20%; display: inline-block;"></li>
    <li class="mid" style="width: 58%; display: inline-block;">支付信息</li>
    <li class="ri" style="width: 20%; display: inline-block;"><a class="col-w"></a></li>
</ul>
<h5>当前订单支付金额为：<strong style="color: red; font-size: 1.5em "><?php echo  $money?></strong>&nbsp;&nbsp;元</h5>
<form method="post" action="index9">
    <input name="tradeno" type="hidden" value="<?echo $tradeno?>">
    <div class="form-group">
        <label for="exampleInputPayName">用户姓名</label>
        <input type="text" class="form-control" name="user_pay_name" id="exampleInputPayName" placeholder="名称" required oninvalid="setCustomValidity('请输入您的姓名');" oninput="setCustomValidity('');">
    </div>
    <div class="form-group">
        <label for="exampleInputPayInfo">用户支付备注</label> &nbsp;&nbsp;&nbsp;<input class="btn btn-default btn-xs" type="button" value="复制备注" onclick="copyTextUser()">
        <input type="text" class="form-control" name="user_pay_info" id="exampleInputPayInfo" placeholder="备注" value='<?php echo
            $uid.'-'.$username.'-'.$money.'-'.$tradeno?>' readonly="readonly">
    </div>
    <div class="tab-menu">
        <ul>
            <li class="active">支付宝转账</li>
            <li>微信转账</li>
            <li>银行卡转账</li>
        </ul>
    </div>
    <div class="tab-con">
        <div>
                <label for="exampleInputName">支付宝商户名:合肥市飞本网络科技有限公司</label></br>
                    <textarea id="input0">这是幕后黑手</textarea>
                <label for="exampleInputNumber" id="text0">支付宝商户:lhmxsc@163.com</label>

            <input class="btn btn-default btn-xs" type="button" value="复制账号" onclick="copyText0()">
                <img src="/test/pay/alipaycode11.png" style="width: 20em;height: 23em;margin: 5px 2em">
        </div>
        <div>
            <label for="exampleInputName">微信商户名:即将上线</label></br>
            <textarea id="input1">这是幕后黑手</textarea>
            <label for="exampleInputNumber" id="text1">微信商户:即将上线</label>
            <input class="btn btn-default btn-xs" type="button" value="复制账号" onclick="copyText1()">
            <img src="/images/wxpay2.png" style="width: 20em;height: 16em;margin: 5px 2em">

        </div>
        <div>
            <label for="exampleInputName" id="text21">银行户名:南京蚩胤电子商务有限公司</label>&nbsp;&nbsp;<input class="btn btn-default btn-xs" type="button" value="复制名称" onclick="copyText2()"></br>
            <textarea id="input2">这是幕后黑手</textarea>
            <textarea id="input21">这是幕后黑手</textarea>
            <label for="exampleInputNumber" id="text2">银行账号:93030078801900000165</label>&nbsp;&nbsp;
            <input class="btn btn-default btn-xs" type="button" value="复制账号" onclick="copyText2()">
            <label for="exampleInputNumber">开户行:上海浦东发展银行南京分行鼓楼支行</label>
            <img src="/images/bankcard.png" style="width: 20em;height: 13em;margin: 0px 2em">
        </div>
        <input type="hidden" name="my_pay_name" id="payname0" placeholder="支付宝账号名称" value="合肥市飞本网络科技有限公司">
        <input type="hidden" name="user_pay_num" id="paynum0" placeholder="支付宝账号" value="lhmxsc@163.com">
    </div>
    <script type="text/javascript">
        $(function () {
            $('.tab-menu li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
//          $('.tab-top li').eq($(this).index()).addClass('active').siblings().removeClass('active');  tab按钮第二种写法
                var index=$(this).index();
                if (index==0){
                    $('#payname1').remove();
                    $('#paynum1').remove();
                    $('#payname2').remove();
                    $('#paynum2').remove();
                    $(".tab-con").append('<input type="hidden" name="my_pay_name" id="payname0" placeholder="支付宝账号名称" value="合肥市飞本网络科技有限公司">');
                    $(".tab-con").append('<input type="hidden" name="user_pay_num" id="paynum0" placeholder="支付宝账号" value="lhmxsc@163.com">');
                }else if(index==1){
                    $('#payname0').remove();
                    $('#paynum0').remove();
                    $('#payname2').remove();
                    $('#paynum2').remove();
                    $(".tab-con").append('<input type="hidden" name="my_pay_name" id="payname1" placeholder="微信账号名称" value="即将上线">');
                    $(".tab-con").append('<input type="hidden" name="user_pay_num" id="paynum1" placeholder="微信账号" value="即将上线">');
                }else if(index == 2){
                    $('#payname0').remove();
                    $('#paynum0').remove();
                    $('#payname1').remove();
                    $('#paynum1').remove();
                    $(".tab-con").append('<input type="hidden" name="my_pay_name" id="payname2" placeholder="银行卡名称" value="南京蚩胤电子商务有限公司">');
                    $(".tab-con").append('<input type="hidden" name="user_pay_num" id="paynum2" placeholder="银行卡号" value="93030078801900000165">');

                }
                $(".tab-con div").eq(index).show().siblings().hide();


            })
        })
    </script>
    <script type="text/javascript">
        function copyText0() {
            var text = document.getElementById("text0").innerText;
            var input = document.getElementById("input0");
            input.value = text; // 修改文本框的内容
            input.select(); // 选中文本
            document.execCommand("copy"); // 执行浏览器复制命令
            $('#myModa00').modal();
            return
        }
        function copyTextUser() {
            var input = document.getElementById("exampleInputPayInfo");
            input.select(); // 选中文本
            document.execCommand("copy"); // 执行浏览器复制命令
            $('#myModaInfo').modal();
            return
        }

        function copyText1() {
            var text = document.getElementById("text1").innerText;
            var input = document.getElementById("input1");
            input.value = text; // 修改文本框的内容
            input.select(); // 选中文本
            document.execCommand("copy"); // 执行浏览器复制命令
            $('#myModa00').modal();
            return
        }
        function copyText2() {
            var text = document.getElementById("text2").innerText;
            var input = document.getElementById("input2");
            input.value = text; // 修改文本框的内容
            input.select(); // 选中文本
            document.execCommand("copy"); // 执行浏览器复制命令
            $('#myModa00').modal();
            return
        }
        function copyText21() {
            var text = document.getElementById("text21").innerText;
            var input = document.getElementById("input21");
            input.value = text; // 修改文本框的内容
            input.select(); // 选中文本
            document.execCommand("copy"); // 执行浏览器复制命令
            $('#myModa00').modal();
            return
        }
    </script>
<!--    <div class="form-group">-->
<!--        <label for="exampleInputName">支付宝商户名</label>-->
<!--        <input type="text" class="form-control" name="my_pay_name" id="exampleInputName" placeholder="支付宝账号名称" value="黄XXX" readonly="readonly">-->
<!--    </div>-->
<!---->
<!--    <div class="form-group">-->
<!--        <label for="exampleInputNumber">支付宝商户</label>-->
<!--        <input type="text" class="form-control" name="user_pay_num" id="exampleInputNumber" placeholder="支付宝账号" value="123123123" readonly="readonly">-->
<!--    </div>-->

    <button type="submit" class="btn btn-info" style="margin-top: 8px;margin-left: 5%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;完&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;成&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
</form>
<!--<form name="alipaypay" method="post" accept-charset="gbk" onsubmit="document.charset='gbk'" action="https://shenghuo.alipay.com/send/payment/fill.htm">-->
<!--    <input type="hidden" name="optEmail" value="100@alipay.com">-->
<!--    <input type="hidden" name="payAmount" value="10">-->
<!--    <input type="hidden" name="title" value="请在这里输入您的xx网用户名">-->
<!--    <input type="hidden" name="memo" value="付款后xx网账号会在一分钟内自动到账！">-->
<!--    <input type="hidden" name="isSend" value="">-->
<!--    <input type="hidden" name="smsNo" value="">-->
<!--    支付宝支付链接：-->
<!--    <input type="image" src="http://www.ecshop120.com/data/editor/111012/1110121529327629059zii1b.png">-->
<!--    <br>-->
<!--</form>-->

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    转账注意事项
                </h4>
            </div>
            <div class="modal-body">
                账户注意：必须使用对应付款姓名的支付宝转账</br>
                金额注意：单笔金额必须与下单金额一致</br>
                订单注意：每笔订单会生成唯一收款信息，请不要截图保存</br>
            </div>
            <div class="modal-footer">

                <div id="thediv" align="left" style="color: #9e0505">温馨提示：请务必按照上述规定进行转账，转账之后请立即联系客服，如不按规定转账，您的资金将会延迟到账。<p></p></div>
                <button type="button" class="btn btn-primary"
                        data-dismiss="modal">知道了
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModa00" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                   复制通知
                </h4>
            </div>
            <div class="modal-body">
                账号复制成功，请在转账时粘贴使用</br>
                使用时请把支付宝账户/微信账户/银行账户此类前缀删除
            </div>
            <div class="modal-footer">

                <div id="thediv" align="left" style="color: #9e0505">温馨提示：请务必按照上述规定进行转账，转账之后请立即联系客服，如不按规定转账，您的资金将会延迟到账。<p></p></div>
                <button type="button" class="btn btn-primary"
                        data-dismiss="modal">知道了
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<!-- 模态框（Modal） -->
<div class="modal fade" id="myModaInfo" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    复制通知
                </h4>
            </div>
            <div class="modal-body">
                备注复制成功，请在转账时粘贴在转账备注里使用</br>
                使用时把复制内容粘贴到转账备注里，请勿修改和删除</br>
                如果转账时，忘记填写备注，请联系客服</br>
                未填写备注，将会导致您的资金延迟到账
            </div>
            <div class="modal-footer">

                <div id="thediv" align="left" style="color: #9e0505">温馨提示：请务必按照上诉规定进行转账，如不按规定，您的资金将会延迟到账，如一直未到账，请联系客服<p></p></div>
                <button type="button" class="btn btn-primary"
                        data-dismiss="modal">知道了
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


</body>

<script>
    //加载模态框
    $('#myModal').modal();

    $(document).ready(function () {
        $("#select").bind("change",function(){
            if($(this).val()==0){
                return;
            }
            else{
                $("p").text($(this).val());
            }
        });
    });
    //选择触发事件
    function goUrl(obj){
        location.href=obj.value;
    }
</script>


</html>