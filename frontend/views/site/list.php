<?= $this->render('_head') ?><!--引入公共头部-->
<style>
  .flex2 .col-3{
    font-size:.08rem!important;
    overflow: hidden;
    white-space: nowrap;
    max-width: 100%;
    text-overflow: ellipsis;
    width:146px;
  }
   .jiao{
        font-size:.08rem;
        background:#bdbd62;
        color:white;
        padding:2px;
        margin-left:3px;
        vertical-align:2px;
      }
</style>
 <ul class="index-head flex col-w">
                    <li class="le" style="width:1.2rem"></li>
                    <li class="mid"><?=config('web_name')?></li>
                    <li class="ri" style="width:1.2rem">
                                <a class="col-w  f-ri" style="padding-right:.1rem" href="/user"><?=u()->nickname ?></a>
                    </li>
            </ul>
            <div style="height: .45rem; width: 100%;"></div>
<div class="index-hot">
            <h3 class="col-2  flex2"><span>热门交易</span><span class="fr flex2"><em>最新价</em><em>涨幅</em></span></h3>
            <!-- 商品列表 -->
            <ul id="pro">
                <?php foreach ($productArr as $key => $value): ?>
                        <li class="list_li" data-pro-no="<?= $value['table_name'] ?>">
                            <a class="flex2" href="/site/detail?pid=<?=$value['id'] ?>">
                            
                            <?php $class='active';if ($value['price'] > $value['close']){ $class = '';}?>
                              <em>
                                <p class="col-1"><?= $value['name'] ?>
                                    <span class="jiao">交易中</span>
                                </p>
                                <p class="col-3" style="font-size:.12rem">
                                            <!--  <?= $value['table_name'] ?>-->
                                  <?php if($value['table_name']=='cedaxa0'): ?>波幅巨大，交易火爆<?php endif; ?>
                                  <?php if($value['table_name']=='wgcna0'): ?>A股市场对冲利器<?php endif; ?>
                                  <?php if($value['table_name']=='hihsif'): ?>紧跟股市，波动大够刺激<?php endif; ?>
                                  <?php if($value['table_name']=='himhif'): ?>低门槛高收益，适合新手<?php endif; ?>
                                  <?php if($value['table_name']=='necla0'): ?>23小时连续交易<?php endif; ?>
                                  <?php if($value['table_name']=='cmgci0'): ?>国际黄金全球热门品种<?php endif; ?>
                                  <?php if($value['table_name']=='cmsii0'): ?>最受欢迎避险交易品种<?php endif; ?>
                                  <?php if($value['table_name']=='cmhgh0'): ?>波动规律 赚钱稳定<?php endif; ?>
                                  <?php if($value['table_name']=='nenga0'): ?>能源新秀 极具赚钱效应<?php endif; ?>
                                  <?php if($value['table_name']=='sgpmudi'): ?>趋势明显 王者归来<?php endif; ?>
                                  <?php if($value['table_name']=='yb'): ?>趋势明显 王者归来<?php endif; ?>
                                  <?php if($value['table_name']=='cmgca0'): ?>价值高 流动性好<?php endif; ?>
                                  <?php if($value['table_name']=='ay'): ?>价值高 流动性好<?php endif; ?>
                                          
                                  </p>
                              </em>
                            <span class="ri flex2 <?=$class ?>">
                                <p><php? if(!$value['price']){echo number_format($value['price'],2,".","");} ?></p>
                                <p class="type-num"><?=$value['diff_rate'] ?>%</p>
                            </span>
                            </a>
                        </li>
                <?php endforeach ?>
                        
            </ul>
        </div>
<?= $this->render('_foot') ?><!--引入公共底部-->
<script>     
function texts(){
    var li = document.getElementsByClassName('list_li') 
    for(var i = 0;i < li.length;i++){
      if($('.list_li').eq(i).find('a').find('span').find('.type-num').css("background-color") ==  'rgb(128, 128, 128)'){
      $('.list_li').eq(i).find('a').find('em').find('.col-1').find('.jiao').html('已停盘').css('background','#808080')
      }else{
       $('.list_li').eq(i).find('a').find('em').find('.col-1').find('.jiao').html('交易中').css('background','#bdbd62')
      }
    }
}
  setInterval(texts,1000);
   
  console.log($('.list_li').find('a').find('span').find('.type-num').html())
  
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