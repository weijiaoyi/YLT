<?= $this->render('../site/_head') ?><!--引入公共头部-->

  <body>
<!--        <ul class="index-head flex col-w">
                <li class="le"></li>
                <li class="mid">我</li>
                <li class="ri"></li>
        </ul>
        <div style="height: .45rem; width: 100%;"></div> -->
        <!--  user-top  -->
        <div class="user-bg pr flex-c">
            <div class="user-box">
                <span><img src=<?= u()->face==''?'/test/4.jpg':u()->face ?> width="100%/"></span>
                <?php if ($relname=='0'){?>
                <div class="user-name"><?= u()->nickname ?></div>
                <?php }else{?>
                    <div class="user-name"><?= $relname ?></div>
                <?php }?>
            </div>
            <div class="user-box2 flex-c">
                <p><em>余额：<?= $user->account ?></em></p>
                <div class="btns">
<!--                    <a href="--><?//= url(['user/withDraw']) ?><!--"><button><i class="icon iconfont"></i>提现</button></a>-->

                    <?php if ($cardstatus==1){ ?>
                        <a href="#"><button><i class="icon iconfont"></i>待审核</button></a>
                    <?php }elseif($cardstatus==2){?>
                        <a href="<?= url(['user/withDraw']) ?>"><button><i class="icon iconfont"></i>提现</button></a>
                    <?php }elseif($cardstatus==0){?>
                        <a href="<?= url(['user/bank-card']) ?>"><button><i class="icon iconfont"></i>提现</button></a>
                    <?php }elseif($cardstatus==-1){?>
                        <a href="<?= url(['user/bank-card']) ?>"><button><i class="icon iconfont"></i>请重新提交</button></a>
                    <?php }?>


                        <a href="<?= url(['user/recharge', 'user_id' => u()->id]) ?>" id="charge"><button><i class="icon iconfont"></i>充值</button></a>


                </div>
                <?php if ($cardstatus!=2){ ?>
                提现需要实名认证，并联系客服审核！
                <?php }?>
            </div>
        </div>
        <!--    user-content     -->
        <div class="user-content">
            <ul>
                <li><a class="col-1" href="<?= url(['user/outMoney']) ?>"><i class="iconfont co5"></i><span>入金明细</span><i class="iconfont"></i></a></li>
                <li><a class="col-1" href="<?= url(['user/insideMoney']) ?>"><i class="iconfont co5"></i><span>出金明细</span><i class="iconfont"></i></a></li>
                <li><a class="col-1" href="<?= url(['user/transDetail']) ?>"><i class="iconfont co4"></i><span>交易记录</span><i class="iconfont"></i></a></li>
                <!-- <li><a class="col-1" href="#"><i class="iconfont co3"></i><span>优惠券</span><i class="iconfont"></i></a></li> -->
            </ul>
            <ul>
                            <?php if ($cardstatus==1){?>
                <li><a class="col-1" href="#"><i class="iconfont co1"></i><span>实名认证</span><i class="iconfont">待审核</i></a></li>
                            <?php }elseif($cardstatus==2){?>
                <li><a class="col-1" href="#"><i class="iconfont co1"></i><span>实名认证</span><i class="iconfont">已认证</i></a></li>
                            <?php }elseif($cardstatus==0){?>
                <li><a class="col-1" href="<?= url(['user/bank-card']) ?>"><i class="iconfont co1"></i><span>实名认证</span><i class="iconfont">未认证</i></a></li>
                            <?php }elseif($cardstatus==-1){?>
                <li><a class="col-1" href="<?= url(['user/bank-card']) ?>"><i class="iconfont co1"></i><span>实名认证</span><i class="iconfont">未通过</i></a></li>
                            <?php }?>
                <li><a class="col-1" href="<?= url(['user/setting']) ?>"><i class="iconfont  co2"></i><span>信息设置</span><i class="iconfont"></i></a></li>
                <!-- <li><a class="col-1" href="#"><i class="iconfont  co6"></i><span>交易规则</span><i class="iconfont "></i></a></li> -->
                <li><a class="col-1" href="<?= url(['site/logout']) ?>"><i class="iconfont  co8">&#xe699;</i><span>退出</span><i class="iconfont ">&#xe65e;</i></a></li>

               
            </ul>
        </div>
<!--        bottom       -->
        <div style="height:.54rem;"></div>
        <?= $this->render('../site/_foot') ?><!--引入公共尾部-->
</body>
<script>

</script>
</html>