<?= $this->render('_head') ?><!--引入公共头部-->
<body style="">
<>
<ul class="index-head flex col-w">
    <li class="le"><a onclick="JavaScript:history.back(-1);" class="col-w"><i class="iconfont"></i></a></li>
    <li class="mid">客服QQ号</li>
    <li class="ri"><a class="col-w"></a></li>
</ul>
<div style="height: .45rem; width: 100%;"></div>
<!-- <img src="/images/gzh.jpg" width="100%">-->
<!--            <div style="width:100%; text-align:center; font-size:30px;">--><?//= $data['qq'] ?><!--</div>-->
<a href="javascript:;" onclick="chatQQ()" style="width:100%; height:100%;  text-align:center; font-size:30px;">点击直接QQ咨询<?= $data['qq']?></a>
</form></body>

<script>
    function chatQQ(){
        //其中1234567指的是QQ号码
        window.location.href="mqqwpa://im/chat?chat_type=wpa&uin=<?= $data['qq'] ?>&version=1&src_type=web&web_src=oicqzone.com";
    }
</script>
</html>