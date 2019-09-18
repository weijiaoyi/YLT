<?php
// var_dump($data);
// exit();
foreach ($data as $userWithdraw) :
// var_dump($userWithdraw);
// exit();
	?>
<div class="container">
    <div class="list fl" style="color:#000;text-align: center;">状态：<?= $userWithdraw->getOpStateValue($userWithdraw->op_state) ?></div>
    <div class="list fl"><?= $userWithdraw->account_id ?></div>
    <div class="lisch fl"><span class="cz">提</span><b> <?= $userWithdraw->amount ?></b></div>
    <div class="lisch fl"><span class="fy">费</span> 4</div>
    <div class="lisch fl" style="color:#afaaaa;width:50%;text-align: center;"><?= $userWithdraw->created_at ?></div>
    <div class="clearfix" style="clear:both;"></div>
</div>
<?php endforeach ?>