<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<div>账户姓名：<?= $pay_name?></div>
<div>支付备注：<?= $pay_info?></div>
<div>收款名称：<?= $shop_name?></div>
<div>收款卡号：<?= $shop_num?></div>
<div>充值单号：<?= $order_id?></div>

<?php  if($order_status==1){?>
    <a class="btn btn-danger" href="user-charge-examine?status=-1&order_id=<?=$order_id?>" role="button">否决</a>
    <a class="btn btn-success" href="user-charge-examine?status=2&order_id=<?=$order_id?>" role="button">通过</a>
<?php }elseif($order_status==2){ ?>
    <a class="btn btn-success" href="#" role="button">已经通过</a>
<?php }elseif ($order_status==-1){?>
    <a class="btn btn-success" href="#" role="button">已经否决</a>
<?php }?>
</body>
</html>