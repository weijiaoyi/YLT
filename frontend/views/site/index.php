<?= $this->render('_head') ?><!--引入公共头部-->
  <body>
    <style>
      .nav-img{
        width:30px;
        height:30px;
        background:#136aab;
        border-radius:50%;
        font-size: .35rem;
    display: inline-block;
        margin-top:.06rem;
      }
      .nav-img img{
         width:20px;
        display:block;
        margin:5px;
      }
      .scroll-msg, .scroll-msges{
         height:35px;
        overflow:hidden;
        background:white;
        margin-top:10px;
      }
      .scroll-msg ul li, .scroll-msges ul li{
         margin-top:8px;
         margin-left:10px;
         font-size:14px
      }
      .register-box{
        width:100%;
        height:40px;
        line-height:40px;
        background:black;
        opacity:.7;
        position:fixed;
        bottom:.54rem;
      }
     .register-box span{
        color:white;
      }
      .reg-msg{
        margin-left:5%;
      }
      .reg-button{
        margin-right:5%;
        background:#6e8dea;
        height:30px;
        line-height:30px;
        border-radius:3px;
        padding:0 10px;
        margin-top:4px;
        position:fixed;
        bottom:64px;
        right:-2px;
        z-index:999;
        
      }
      .reg-button a{
        color:white;
      }
      .close-reg{
         border-radius:50%;
        width:15px;
        height:15px;
        display:inline-block;
        background:#6b6b6b;
        text-align:center;
        float:left;
        margin-top:12px;
        line-height:14px;
        margin-left:5%;
      }
      .flex2 .col-3{
        font-size:.08rem!important;
      }
      .index-bot-btns{
        clear:both;
      }
      .index-hot li{
        height:auto!important;
      }
      #pro li{
        width:33%;
        height:106px;
        float:left;
        overflow: hidden;
        white-space: nowrap;
        max-width: 100%;
        text-overflow: ellipsis;
        background:white;
        border-right:1px solid #efeff6;
        border-bottom:1px solid #efeff6;
        padding:0;
        text-align:center;
      }
      #pro li .flex2{
       display:block;
      }
      #pro span p{
        display:block;
        text-align:center;
      }
      #pro span p+p{
       background:transparent!important;
        color:#000;
      }
      #pro .col-3{
        height:18px;
        overflow: hidden;
   	    white-space: nowrap;
        max-width: 100%;
        text-overflow: ellipsis;
      }
      #pro{
        background:white;
        overflow:hidden;
      }
      .index-hot .ri p{
       margin-top:0!important;
        text-align:center;
      }
      #pro li+li+li+li+li+li+li{
        display:none;
      }
        .new-left{
    width:62%;
    float:left;
  }
  .new-right{
    width:110px;
    float:right;
  }
  .new-right img{
    width:100%;
  }
  .new-list li{
    padding:9px 10px;
    border-bottom:1px solid #efeff4;
    overflow:hidden;
    background:white;
    height:auto;
  }
  .new-list .new-msg{
    font-size:16px;
    display: -webkit-box ;
    overflow: hidden;
    text-overflow: ellipsis;
    word-break: break-all;
    -webkit-box-orient: vertical;
    -webkit-line-clamp:2;
    margin-bottom:7px;
    color:#000;
  }
  .new-left p{
   color:#666;
  }
      .new-show{
      overflow:hidden;
        border-bottom:1px solid #efeff4;
        padding:10px 20px;
        border-top:7px solid #efeff4;
        background:white;
      }
      .new-deita{
       position:fixed;
       left:0;
        top:0;
        right:0;
        bottom:0;
        display:none;
        background:white;
        z-index:9999;
        overflow:scroll;
      }
      .new-deita h3{
        font-size:20px;
      }
      .new-cen{
        padding:0 15px;
        height:auto;
      }
      .new-deita p{
       margin:5px 0;
      }
      .new-centents{
        font-size:14px;
        text-indent:20px;
      }
      .box-none{
        display:none;
      }

    </style>
 
    <!--    首页      -->
    <!--固定头部-->
            <ul class="index-head flex col-w">
                    <li class="le" style="width:1.2rem"></li>
                    <li class="mid"><?=config('web_name')?></li>
                    <li class="ri" style="width:1.2rem">
                                <a class="col-w  f-ri" style="padding-right:.1rem" href="/user"><?=u()->nickname ?></a>
                    </li>
            </ul>
            <div style="height: .45rem; width: 100%;"></div>
            
            <!--        滚动图片        -->
        <!-- <div class="swiper-container swiper-container-horizontal"> -->
        <div>
            <!-- <div class="swiper-wrapper" style="transform: translate3d(-5709px, 0px, 0px); transition-duration: 0ms;"> -->
              <div>
                        <div class="swiper-slide" style="width: 100%;">
                            <a href="#"><img src="/test/banner5.jpg" width="100%"></a>
                        </div>
                        <!-- <div class="swiper-slide" style="width: 1903px;">
                            <a href="#"><img src="/test/20170331165156760.jpg" width="100%"></a>
                        </div>
                        <div class="swiper-slide swiper-slide-prev" style="width: 1903px;">
                            <a href="#"><img src="/test/banner2.jpg" width="100%"></a>
                        </div>
                        <div class="swiper-slide swiper-slide-active" style="width: 1903px;">
                            <a href="#"><img src="/test/banner3.jpg" width="100%"></a>
                        </div>
                        <div class="swiper-slide swiper-slide-next" style="width: 1903px;">
                            <a href="#"><img src="/test/banner4.jpg" width="100%"></a>
                        </div> -->
            </div>
            <!-- Add Pagination -->
          <!--  <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span><span class="swiper-pagination-bullet"></span></div>-->
        </div>
        
        <!--        头部菜单                   -->
        <ul class="index-tab flex">
<!--            <li>-->
                <!-- <a href="/site/detail?type=sim"><i class="iconfont col-4"></i>
                    <p class="col-1">APP下载</p>
                </a> -->
<!--                <a href="http://xiongmaofenfa.com/AuChe"><i class="iconfont col-4"></i>-->
<!--                    <p class="col-1">APP下载</p>-->
<!--                </a>-->
                <!-- <a href="/site/downapp"><i class="iconfont col-4"></i>
                    <p class="col-1">APP下载</p>
                </a> -->
<!--            </li>-->
            <li>
              <!-- <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=<?=config('qq')?>&amp;site=qq&amp;menu=yes" target="_blank">-->
              <a href="/site/wx">
                  <div class="nav-img">
                    <img src="/test/qqimg.png"/>
                  </div>
                    <p class="col-1">客服QQ</p>
               </a>
               <!-- </a>-->
            </li>
           <li>
              <!-- <a href="http://www.jinshishujuwang.com/">
                <i class="iconfont col-4"></i>
                    <p class="col-1">新闻资讯</p>
                </a> -->
                <a href="/site/news">
                <i class="iconfont col-4"></i>
                    <p class="col-1">新闻资讯</p>
                </a>
            </li>
        </ul>
       <!--滚动信息-->
     <!--    <div class="scroll-msg box-block">
          <ul>
            <li>
               用户187****5658盈利3558元
            </li>
            <li>
               用户134****2633盈利4288元
            </li>
            <li>
               用户189****7277盈利2562元
            </li>
            <li>
               用户187****2554盈利4996元
            </li>
            <li>
               用户189****3858盈利4328元
            </li>
            <li>
               用户177****2555盈利6878元
            </li>
            <li>
               用户130****2417盈利2568元
            </li>
            <li>
               用户187****5566盈利4627元
            </li>
            <li>
               用户189****3822盈利5568元
            </li>
            <li>
               用户137****3268盈利5563元
            </li>
            <li>
               用户155****9575盈利4378元
            </li>
            <li>
               用户155****3228盈利7845元
            </li>
            <li>
               用户187****6255盈利4928元
            </li>
            <li>
               用户188****3778盈利3354元
            </li>
            <li>
               用户187****3568盈利3789元
            </li>
          </ul>    
        </div> -->
    <div class="scroll-msges box-none">
          <ul>
            <li>
              休市中，养精蓄锐，静待开盘
            </li>
            <li>
              休市中，养精蓄锐，静待开盘
            </li>
          </ul>
       </div>
    
       
        <div style="height: .1rem"></div>
        <!--            首页热门        -->
        <div class="index-hot">
          <div class="hot-show" style="overflow:hidden;border-bottom:1px solid #efeff4;padding:10px 20px;">
            <div class="hot-show_msg" style="float:left;">交易品种</div>
            <div class="hot-more" style="float:right">
              <a href="/site/list">
              查看更多<i class="iconfont"></i>
              </a>
            </div>
          </div>
            <!-- 商品列表 -->
            <ul id="pro">
                <?php foreach ($productArr as $key => $value): ?>
                        <li class="ddata" data-pro-no="<?= $value['table_name'] ?>">
                            <a class="flex2" href="/site/detail?pid=<?=$value['id'] ?>">
                            
                            <?php $class='active';if ($value['price'] > $value['close']){ $class = '';}?>
                              <em>
                                <p class="col-1"><?= $value['name'] ?></p><p class="col-3" style="font-size:.12rem">
                                        <!--  <?= $value['table_name'] ?>-->
                                      <?php if($value['table_name']=='cedaxa0'): ?>波幅巨大，交易火爆<?php endif; ?>
                                      <?php if($value['table_name']=='wgcna0'): ?>A股市场对冲利器<?php endif; ?>
                                      <?php if($value['table_name']=='hihsif'): ?>紧跟股市，波动大够刺激<?php endif; ?>
                                      <?php if($value['table_name']=='himhif'): ?>低门槛高收益，适合新手<?php endif; ?>
                                      <?php if($value['table_name']=='necla0'): ?>23小时连续交易<?php endif; ?>
                                      <?php if($value['table_name']=='cmgci0'): ?>国际黄金全球热门品种<?php endif; ?>
                                      <?php if($value['table_name']=='cmsii0'): ?>最受欢迎避险交易品种<?php endif; ?>
                                      <?php if($value['table_name']=='baishatang'): ?>波动规律 赚钱稳定<?php endif; ?>
                                      <?php if($value['table_name']=='nenga0'): ?>能源新秀 极具赚钱效应<?php endif; ?>
                                      <?php if($value['table_name']=='sgpmudi'): ?>趋势明显 王者归来<?php endif; ?>
                                      <?php if($value['table_name']=='himhif'): ?>价值高 流动性好<?php endif; ?>
                                      
                              </p>
                            </em>
                            <span class="ri flex2 <?=$class ?>">
                                <p class="t_data"><php? if(!$value['price']){echo number_format($value['price'],2,".","");} ?></p>
                                <p><?=$value['diff_rate'] ?>%</p>
                            </span>
                            </a>
                        </li>
                <?php endforeach ?>
                        
            </ul>
        </div>
          <!-- <div class="new-show">
            <div class="new-show_msg" style="float:left;">新闻资讯</div>
            <div class="new-more" style="float:right">
              <a href="http://www.jinshishujuwang.com/">
              查看更多<i class="iconfont"></i>
              </a>
            </div>
          </div> -->
     <!-- <div class="new-list">
    <ul>
      <li>
        <div class="new-left">
          <p class="new-msg">美国加征钢铝关税 全球贸易体系正面临巨大冲击</p>
          <p>FX168财经网 05-31 12.36</p>
        </div>
        <div class="new-right">
          <img src="/test/zhongtong.jpg"/>
        </div>
      </li>
      <li>
        <div class="new-left">
          <p class="new-msg">玉米减仓下跌 维持日内短空</p>
          <p>FX168财经网 05-31 14.36</p>
        </div>
        <div class="new-right">
          <img src="/test/yumi.jpg"/>
        </div>
      </li>
      <li>
        <div class="new-left">
          <p class="new-msg">中美谈判前瞻二 多买美4成农产品大豆价格会怎样</p>
          <p>FX168财经网 05-31 18.05</p>
        </div>
        <div class="new-right">
          <img src="/test/zm.jpg"/>
        </div>
      </li>
      <li>
        <div class="new-left">
          <p class="new-msg">芝加哥期权交易所Cboe 5月外汇交易量创下历史新</p>
          <p>FX168财经网 6-02 2.35</p>
        </div>
        <div class="new-right">
          <img src="/test/zjg.jpg"/>
        </div>
      </li>
    </ul>
  </div> -->
   <!-- new-deita-->
    
    
    
    <div class="new-deita">
       <ul class="index-head flex col-w">
                    <li class="le" style="width:1.2rem;text-align:left">
                      <i class="iconfont" style="margin-left:10px"></i>
                    </li>
                    <li class="mid"><?=config('web_name')?></li>
                    <li class="ri" style="width:1.2rem">
                                <a class="col-w  f-ri" style="padding-right:.1rem" href="/user"><?=u()->nickname ?></a>
                    </li>
            </ul>
            <div style="height: .45rem; width: 100%;"></div>
      <div class="new-cen">
         <h3>美国加征钢铝关税 全球贸易体系正面临巨大冲击</h3>
      <p>2018年06月01日 16:21 新浪财经综合</p>
      <img src="/test/new11.png" style="width:100%">
      <p class="new-centents">随着美国宣布将对欧盟等经济体钢铝产品征收高关税，欧盟、墨西哥、加拿大纷纷表态将采取报复行动，全球贸易体系正面临巨大冲击。

　　美国商务部长罗斯5月31日表示，美国总统特朗普决定不再延长对欧盟、加拿大和墨西哥的钢铝关税豁免期限，将从6月1日开始对这三个经济体的钢铝产品分别征收25%和10%的关税。
        欧盟委员会主席容克对此表示，欧盟认为美国单方面采取关税措施是不公平的，与世界贸易组织规则不符，是“纯粹的保护主义”，完全不可接受。他说：“对全球贸易来说，今天是糟糕的一天。”

</p>
      </div>
      <div style=""height:.54rem></div>
    </div>
    
    
        <div class="new-deita">
       <ul class="index-head flex col-w">
                    <li class="le" style="width:1.2rem;text-align:left">
                      <i class="iconfont" style="margin-left:10px"></i>
                    </li>
                    <li class="mid"><?=config('web_name')?></li>
                    <li class="ri" style="width:1.2rem">
                                <a class="col-w  f-ri" style="padding-right:.1rem" href="/user"><?=u()->nickname ?></a>
                    </li>
            </ul>
            <div style="height: .45rem; width: 100%;"></div>
      <div class="new-cen">
         <h3>瑞达期货：DCE玉米减仓下跌 维持日内短空交易</h3>
      <p>2018年06月01日 17:11 新浪财经</p>
      <p class="new-centents">
 国内盘面：周五DCE玉米(1768, -12.00, -0.67%)C1809合约减仓收跌，终盘报1768元/吨，下跌12元/吨，跌幅0.67%，持仓量减少33868手至785506手。玉米淀粉(2207, -17.00, -0.76%)CS1809合约同样走弱，最终报收于22
        07元/吨，下跌17元/吨，跌幅0.76%，波动区间2200-2227元/吨，持仓量274190手，减仓22048手。外盘走势：芝加哥期货交易所（CBOT）美玉米期货主力合约07合约小幅上涨，截至下午15时05分，报395.6美分/蒲式耳，涨幅0.41%。消息面：1、5月31日国家临储玉米交易结果：计划投放3922582吨，实际成交2422095吨，成交率61.74%，最高价1700元/吨，最低价1350元/吨，成交均价1498元/吨。2、2017/18年度迄今为止，乌克兰小麦出口量为1620万吨，玉米出口量为1590万吨，大麦出口量为419万吨。

　　现货方面：锦州港地区水分15%、霉变2%以内新粮报收1710-1730元/吨，平舱价1755-1765元/吨，较昨日下跌10元/吨；吉林四平地区玉米淀粉出厂价格为2300元/吨，较昨日持平。

　　总结：现货价格总体持稳，运费上升支撑玉米价格，而腾出库容收新麦或施压玉米价格，后市仍需关注拍卖粮流入市场所产生的影响，预计短期内玉米价格以稳为主。技术面上，玉米1809合约与淀粉1809合约减仓下跌，呈现回调走势，操作上建议维持日内逢高短空交易，玉米1809合约关注1760附近支撑，淀粉1809合约关注20日均线附近支撑。

新浪声明：新浪网登载此文出于传递更多信息之目的，并不意味着赞同其观点或证实其描述。文章内容仅供参考，不构成投资建议。投资者据此操作，风险自担。
　　

</p>
      </div>
          <div style="height:.54rem"></div>
    </div>
    
            <div class="new-deita">
       <ul class="index-head flex col-w">
                    <li class="le" style="width:1.2rem;text-align:left">
                      <i class="iconfont" style="margin-left:10px"></i>
                    </li>
                    <li class="mid"><?=config('web_name')?></li>
                    <li class="ri" style="width:1.2rem">
                                <a class="col-w  f-ri" style="padding-right:.1rem" href="/user"><?=u()->nickname ?></a>
                    </li>
            </ul>
            <div style="height: .45rem; width: 100%;"></div>
      <div class="new-cen">
         <h3>中美谈判前瞻二 多买美4成农产品大豆牛肉价格会怎样</h3>
      <p>2018年05月31日 18:05 新浪财经</p>
      <p class="new-centents">
 新浪财经讯 5月31日在市场的焦灼等待中，美国贸易先遣团来华进入了第二天，按照之前特朗普的强硬说法，如果先遣团谈不好，美国的商务部长就不会再来北京的。

　　而此前中美达成共识是，双方同意有意义地增加美国农产品和能源出口，美方将派团赴华讨论具体事项。

　　当前究竟美国有什么东西能卖给我们呢？又应该如何理解，有意义的增加自美国农产品进口呢？是否意味着中国会脱离市场增加美国大豆的采购？
        据美国农业部统计，中国是美国农产品第二大出口市场。2017年出口中国的美国农产品占美国农产品出口的15%。中国是美大豆第一大、棉花(18785, 95.00, 0.51%)第二大出口目的地。美国出口的62%大豆、14%棉花均销往中国。平均每个美国农民向中国出口农产品约1.2万美元

　　2017年，中国从美国产品进口金额为241.16亿美元。根据中粮集团数据分析，食用油籽是第一大类农产品，全年共计从美国进口食用油籽3298.4万吨，总价值140.2亿美元。2017年中国从美国进口的食用油籽金额占我国全年对美农产品进口总额的58.14%。

　　食用油籽中，以大豆的进口数量和进口金额最高。2017年我国从美进口大豆共计3286万吨，进口金额为139.45亿美元。

　　按照进口金额排序，剩下前四名重要进口品种为，畜产品、粮食（谷物）、水产品、生猪产品。前五大进口产品金额占从美进口农产品总额的87.6%。
        中国四季度的大豆还基本没有采购，四季度主要是美国供应全球市场，在当前的形势下，增加购买美国大豆似无悬念。

　　中美联合声明中的“有意义的”这一说法并没有明确其含义，但是根据业内人士的分析，由于特朗普非常在意农业周的选票，驻华大使也是前农业州的州长，因此双方达成一个类似长期供销协议的方案是存在可能的。

　　根据中粮集团提供的数据显示：2016-2017年度美国大豆总产量为1.1692亿公吨，占全球产量33%；2017-2018年度总产量为1.1952亿公吨，占全球产量的约35%。2018-2019年度预期产量为1.1648亿公吨，低于2017/18年度的1.1952亿吨。但与此同时，2018/19年度美国大豆出口预计为6232万吨，高于2017/18年度的5620万吨。

　　而中国的大豆产量2018/19将会减少到1410万吨，低于2017/18年度的1420万吨。中国2018/19年度中国大豆进口量预计提高到创纪录1.03亿吨，高于2017/18年度的9700万吨。虽然中国出台政策鼓励农户种植大豆，不过在本年度以及下一年度，中国大豆产量预计稳定，因为耕地有限，单产增长乏力。
　　

</p>
      </div>
          <div style="height:.54rem"></div>
    </div>
        <div class="new-deita">
       <ul class="index-head flex col-w">
                    <li class="le" style="width:1.2rem;text-align:left">
                      <i class="iconfont" style="margin-left:10px"></i>
                    </li>
                    <li class="mid"><?=config('web_name')?></li>
                    <li class="ri" style="width:1.2rem">
                                <a class="col-w  f-ri" style="padding-right:.1rem" href="/user"><?=u()->nickname ?></a>
                    </li>
            </ul>
            <div style="height: .45rem; width: 100%;"></div>
      <div class="new-cen">
         <h3>芝加哥期权交易所Cboe 5月外汇交易量创下历史新高 环比大增23%</h3>
      <p>2018年06月02日 02:27 新浪财经综合</p>
      <p class="new-centents">2018年5月，Cboe外汇公布的总成交量为9402亿美元，较上月的7629亿美元增长23%。与此类似，这一数字甚至比去年同期高出45%，当时的总成交量为6472亿美元。

此外，2018年5月，该交易所的机构外汇交易的日均交易量为409亿美元，较2017年4月的363亿美元增长了12.4%。

与上年同期相比，日均交易量（ADV）显示了一幅更为乐观的图景，较上年同期的281亿美元增长了45%。

Cboe FX发布的数据显示，GTX交易平台的交易大幅飙升。GTX交易平台是嘉盛的机构外汇部门，最近被德意志交易所的360T收购，其5月份的交易量比去年增长了43%。此外，继自一年前增长了56%之后，GTX ECN的营业额创下了最佳单月表现，而日均成交量按月也增长了26.0%。

</p>
      </div>
      <div style=""height:.54rem></div>
    </div>
    
        
        <!--                底部按钮                    -->
        <div class="index-bot-btns">
            <div>
                <p>交易由纽约商品交易所，香港交易所，新加坡交易所等提供实盘对接</p>
                
            </div>
            <p>投资有风险，入市须谨慎</p>
        </div>
      <!-- 底部浮动的注册-->
     <!-- <span class="reg-button">
        <a href="/site/reg">
           马上注册
        </a>
      </span> -->
    <!-- <div class="register-box">
      <span class="close-reg">x</span>
      <span class="reg-msg">聪明的人在这里赚到第一桶金</span>
    </div> -->
        <?= $this->render('_foot') ?><!--引入公共底部-->

        
<script src="/test/swiper.min.js"></script>
<script src="/test/jquery.cookie.js"></script>
<script>
   //判断是否停市
  setInterval(function() {
			var lis = document.getElementsByClassName('ddata')
            console.log(lis);
			for(var k = 0; k < lis.length; k++) {
				if($('.ddata').eq(k).find('a').find('span').find('.t_data').css('color') == 'rgb(41, 206, 146)' || $('.ddata').eq(k).find('a').find('span').find('.t_data').css('color') == 'rgb(243, 75, 96)') {
					$('.box-none').css({
						'display': 'none'
					})
					$('.box-block').css({
						'display': 'block'
					})
					// console.log(1)
					break;
				} else {
					$('.box-none').css({
						'display': 'block'
					})
					$('.box-block').css({
						'display': 'none'
					})
					// console.log(2)
				}
			}

		}, 1000)
  
 
   
  
 // 新闻动画
   $('.new-deita').css({
     'margin-top':$('.new-deita').height()
   })
   $('.le i').click(function(){
     $('.new-deita').css({
      'margin-top':$('.new-deita').height(),
       'display':'none'
     })
   })
    $('.new-list li').click(function(){
       $('.new-deita').eq($(this).index()).css('display','block').animate({'margin-top':'0'},800)
    })
  
  
  
       $('.close-reg').click(function(){
           $('.reg-button').css('display','none')
           $('.register-box').css('display','none')
          $('.new-deita').css({
     'margin-top':$('.new-deita').height()
   })
       })
       
        // 向上滚动信息
       function scrollmsg(){
       $('.scroll-msg ul').animate({
       	marginTop:-28
       },1000,function(){
       	$('.scroll-msg ul').css({marginTop:0})
        $('.scroll-msg ul').append($('.scroll-msg ul li').first())
       })
    }
	 setInterval(scrollmsg,3000)
  
   function scrollmsges(){
       $('.scroll-msges ul').animate({
       	marginTop:-28
       },1000,function(){
       	$('.scroll-msges ul').css({marginTop:0})
        $('.scroll-msges ul').append($('.scroll-msges ul li').first())
       })
    }
	 setInterval(scrollmsges,3000)
       
  
  
            var swiper = new Swiper('.swiper-container', {
                pagination: '.swiper-pagination',
                paginationClickable: true,
                autoplay: 2800,
                autoplayDisableOnInteraction: false,
            });


            $("#sim").click(function(){
                layer.open({
                className:'index-msg',
                content: "暂未开放",
                btn: ['确定']
            })
            })
    
    $(function(){
        var proNos = '';
        var msg = '';
        if(msg != ''){
            layer.open({
                className:'index-msg',
                content: msg,
                btn: ['确定']
            })
        }
        $('#pro li').each(function(i){
            proNos += (i == 0 ? '' : ',') + $(this).data('proNo')
        })
        $.ajax({
            url: '<?= url('site/proCloseList')?>',//ProCloseList
            data: {
                proNo: proNos
            },
            success: function(data){
                var obj = data.data;
                for(var prop in obj){
                    $('[data-pro-no=' + prop + ']').data('preClose', obj[prop]);
                }
                setInterval(queryIndices, 1000);
                queryIndices();
                
            }
        })
        
        
        function queryIndices(){
            $.ajax({
                url: '<?= url('site/proPriceList')?>',
                data: {
                    proNo: proNos
                },
                success: function(data){
                    var obj = data.data;
                    for(var prop in obj){
                        var indices = obj[prop];
                        var preClose = $('[data-pro-no=' + prop + ']').data('preClose');
                        var p = $('[data-pro-no=' + prop + '] span p')
                        console.log(indices);

                        if(preClose != undefined && preClose != null && preClose != 0 && indices != null){
                            
                            if(indices < preClose){
                                p.parent().addClass('active');
                            }

                            p.eq(0).text(parseFloat(indices));
                            ((indices / preClose - 1) * 100).toFixed(2) > 0 ? p.eq(1).text("+"+((indices / preClose - 1) * 100).toFixed(2) + '%') : p.eq(1).text(((indices / preClose - 1) * 100).toFixed(2) + '%')
                            
                            
                        }else{
                            p.parent().addClass('active3');
                            p.eq(0).text("- -.- -");
                            p.eq(1).text("停市");
                        }
                    }
                }
            })
        }
    })

    
    function getQueryString(name)
    {
         var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
         var r = window.location.search.substr(1).match(reg);
         if(r!=null)return  unescape(r[2]); return null;
    }
    var rid = getQueryString("rid");
    var COOKIE_NAME = 'yht_rid';
    if(rid != null && rid != ''){
        $.cookie(COOKIE_NAME, rid, {path:'/', expires:3});
    }
        </script>
  
</body></html>