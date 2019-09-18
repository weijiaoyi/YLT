<?php $this->regCss('jilu.css') ?>
<?php $this->regCss('manager.css') ?>
<link rel="stylesheet" href="/test/main.css?r=20170520">
<ul class="index-head flex col-w" style="background: #000;color: #fff;text-align: center;">
        <li class="le" style="width: 20%; display: inline-block;"><a onclick="JavaScript:history.back(-1);" class="col-w"><i class="iconfont" style="color: white;"></i></a></li>
        <li class="mid" style="width: 58%; display: inline-block;">出金</li>
        <li class="ri" style="width: 20%; display: inline-block;"><a class="col-w"></a></li>
</ul>
<div class="outMoney">
<?= $this->render('_insideMoney', compact('data')) ?>
</div>
<?php if ($pageCount < 2): ?>
    <div class="deta_more" id="deta_more_div">没有更多了</div>
<?php else: ?>
    <div class="addMany" style="text-align: center;margin-top: 60px;">
        <a style="" type="button" value="加载更多" id="loadMore" data-count="<?= $pageCount ?>" data-page="1">加载更多</a>
    </div>
<?php endif ?>

<script type="text/javascript">
$(".addMany").on('click', '#loadMore', function() {
    var $this = $(this),
        page = parseInt($this.data('page')) + 1;

    $.get('', {p:page}, function(msg) {
        $(".outMoney").append(msg);
        $this.data('page', page);
        if (page >= parseInt($this.data('count'))) {
            $('.addMany').hide();
        }
    });
});
</script>