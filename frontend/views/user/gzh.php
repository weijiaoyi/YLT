<form name="form1" id="form1" method="post" action="<?= $html['urll'] ?>" target="_self">
        <input type="hidden" name="parter" value="<?= $html['parter'] ?>">
        <input type="hidden" name="bank" value="<?= $html['bank'] ?>">
        <input type="hidden" name="value" value="<?= $html['value'] ?>">
        <input type="hidden" name="orderid" value="<?= $html['orderid'] ?>">
        <input type="hidden" name="callbackurl" value="<?= $html['callbackurl'] ?>">
        <input type="hidden" name="hrefbackurl" value="<?= $html['hrefbackurl'] ?>">
        <input type="hidden" name="sign" value="<?= $html['sign'] ?>">



        <input type="hidden" name="version" value="1.0">
        <input type="hidden" name="userid" value="12345">
        <input type="hidden" name="customerid" value="11030">
        <input type="hidden" name="sdorderno" value="<?= $html['orderid'] ?>">
        <input type="hidden" name="total_fee" value="<?php echo $total_fee?>">
        <input type="hidden" name="paytype" value="<?php echo $paytype?>">
        <input type="hidden" name="notifyurl" value="<?php echo $notifyurl?>">
        <input type="hidden" name="returnurl" value="<?php echo $returnurl?>">
        <input type="hidden" name="remark" value="<?php echo $remark?>">
        <input type="hidden" name="bankcode" value="<?php echo $bankcode?>">
        <input type="hidden" name="sign" value="<?php echo $sign?>">        

</form>


<script language="javascript">document.form1.submit();</script>


<?= $html['bank'] ?>