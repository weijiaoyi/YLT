<?php common\components\View::regCss('geren.css') ?>

<link rel="stylesheet" href="/test/main.css?r=20170520">
<ul class="index-head flex col-w" style="background: #000;color: #fff;text-align: center;">
        <li class="le" style="width: 20%; display: inline-block;"><a onclick="JavaScript:history.back(-1);" class="col-w"><i class="iconfont"></i></a></li>
        <li class="mid" style="width: 58%; display: inline-block;">信息设置</li>
        <li class="ri" style="width: 20%; display: inline-block;"><a class="col-w"></a></li>
</ul>
<!--头部导航-->
<div class="forget">
    <div class="center-list-wrap">
        <ul>
            <li class="table bottom-wrap" data-index="0">
                <a href="<?= url(['user/password']) ?>" class="content-w">
                    <div class="content-wrap table-cell">
                        <div class="title">修改密码</div>
                        <div class="title-tip">为了您的资金安全，请妥善保管您的密码</div>
                    </div>
                </a>
                <div class="table-cell" style="padding-bottom: 40px;"><span class="earrow earrow-right"></span></div> 
            </li>
            <li class="table bottom-wrap" data-index="1">
                <a href="<?= url(['user/changePhone']) ?>" class="content-w">
                    <div class="content-wrap table-cell">
                        <div class="title"><span>验证手机</span><span id="mobile" style="padding-left: 0.5em; color: #1d84d4; font-size: 13px;">
                        <?php if (strlen(u()->mobile) <= 10): ?>
                            您还未设置手机号码
                        <?php else : ?>
                            <?= substr(u()->mobile, 0, 3) . '*****' . substr(u()->mobile, -3) ?>
                        <?php endif ?>
                        </span></div>
                        <div class="title-tip">若您的验证手机丢失或停用，请立即更换</div>
                    </div>
                </a>
                <div class="table-cell" style="padding-bottom: 40px;"><span class="earrow earrow-right"></span></div>
            </li>
			<li class="table bottom-wrap" data-index="0">
                <a href="<?= url(['user/bankCard']) ?>" class="content-w">
                    <div class="content-wrap table-cell">
                        <div class="title">设置支付方式</div>
                        <div class="title-tip">为了您正常充值，请妥善完善您的充值信息</div>
                    </div>
                </a>
                <div class="table-cell" style="padding-bottom: 40px;"><span class="earrow earrow-right"></span></div> 
            </li>
        </ul>
    </div>
</div>
