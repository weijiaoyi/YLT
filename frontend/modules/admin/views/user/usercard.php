<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<div>姓名：<?= $bank_user?></div>
<div>电话：<?= $bank_mobile?></div>
<div>银行卡号：<?= $bank_card?></div>
<div>身份证号：<?= $id_card?></div>
<div>身份证： <img src="<?= $idcard?>" height="200em" title="身份证正面"><img src="<?= $backidcard?>" height="200em" title="身份证背面"></div>
<div>银行卡： <img src="<?= $bankcard?>" height="200em" title="银行卡"></div>
<?php  if($status==1){?>
<a class="btn btn-danger" href="user-data-to-examine?status=-1&id=<?=$userid?>" role="button">否决</a>
<a class="btn btn-success" href="user-data-to-examine?status=2&id=<?=$userid?>&name=<?=$bank_user?>" role="button">通过</a>
<?php }elseif($status==2){ ?>
    <a class="btn btn-success" href="#" role="button">已经通过</a>
<?php }elseif ($status==-1){?>
    <a class="btn btn-success" href="#" role="button">已经否决</a>
<?php }?>
</body>
</html>