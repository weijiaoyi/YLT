<?php error_reporting(E_ERROR);?>
<style>*{font-size:12px; }h1{font-size:24px;}</style>
<form action="card_callback_test.php" method="post">
<h1>Ȥ���ƿ���֧�����в���</h1>
���е�ַ��<input name="url" type="text" value="<?php echo(isset($_POST['url']) ? $_POST['url'] : "http://localhost/shunfoo/callback/pay_card_callback.php");?>" size="80"/>
<p><strong>����Э�������</strong></p>
<table border="1" cellspacing="0" cellpadding="0" width="552">
  <tr>
    <td width="144" valign="top">      �ֶ��� </td>
    <td width="408" valign="top"><p>˵��</p></td>
  </tr>
  <tr>
    <td width="144" valign="top"><p>orderid</p></td>
    <td width="408" valign="top"><p><input type="text" name="orderid" value="<?php echo($_POST['orderid']);?>"/>���й����д����orderid</p></td>
  </tr>
  <tr>
    <td width="144" valign="top"><p>opstate</p></td>
    <td width="408" valign="top"><p><input type="text" name="opstate"  value="<?php echo($_POST['opstate']);?>"/><br>�������״̬��<br />
      0 �����ɹ�ʹ��<br />
      -1 �����������<br />
      -2 ��ʵ����ֵ���ύʱ��ֵ����������ʵ����ֵδʹ�á���ʵ����ֵ��ovalue��ʾ<br />
      -3 ��ʵ����ֵ���ύʱ��ֵ����������ʵ����ֵ�ѱ�ʹ�á���ʵ����ֵ��ovalue��ʾ<br />
      -4 ���Ѿ�ʹ�ã������ύ��Ȥ����֮ǰ�Ѿ���ʹ�ã� <br />
      -5 ʧ��(����ԭ�򡢾���ԭ����ȷ��)</p></td>
  </tr>
  <tr>
    <td width="144" valign="top"><p>ovalue</p></td>
    <td width="408" valign="top"><p><input type="text" name="ovalue"  value="<?php echo($_POST['ovalue']);?>"/>
      <br>opstate=-2����-3ʱ��ʾ��ֵ����λԪ(ע����ֻ�ṩ��ȷ�Ŀ�����ʵ����ֵ��������ֵΪ0������Ч��Ϊ�˾�ȷ�ԣ���ֵ���ܴ���4λС��)</p></td>
  </tr>
  <tr>
    <td valign="top">shunfooorderid</td>
    <td valign="top"><input type="text" name="shunfooorderid"  value="<?php echo($_POST['shunfooorderid']);?>"/>
      <br />
      �˴ο����Ĺ�����Ȥ����ϵͳ�Ķ���Id��Ϊ���ֺ���ǰ�汾���ݣ���ֵ�����뷵�ؽ��ǩ����֤��</td>
  </tr>
  <tr>
    <td valign="top">shunfootime</td>
    <td valign="top"><input type="text" name="shunfootime"  value="<?php echo($_POST['shunfootime']);?>"/>
      <br />
      �˴ο����Ĺ�����Ȥ����ϵͳ�Ķ�������ʱ�䡣��ʽΪ<br />
        ��/��/�� ʱ���֣��룬��2010/04/05 21:50:58��<br />
      Ϊ���ֺ���ǰ�汾���ݣ���ֵ�����뷵�ؽ��ǩ����֤��</td>
  </tr>
  <tr>
    <td width="144" valign="top"><p>&nbsp;</p></td>
    <td width="408" valign="top"><p>
      <label>
      <input type="submit" name="Submit" value="ģ������">
      </label>
    </p></td>
  </tr>
</table>
</form>

<p><strong>����Э�������</strong></p>
<table border="1" cellspacing="0" cellpadding="0" width="552">
  <tr>
    <td width="144" valign="top"><p>��������</p></td>
    <td width="408" valign="top"><p>˵��</p></td>
  </tr>
  <tr>
    <td width="144" valign="top"><p>opstate</p></td>
    <td width="408" valign="top"><p>�������״̬��<br>
      0 �ɹ�<br>
      -1 ���������Ч<br>
      -2 ǩ������</p></td>
  </tr>
</table>

==============================���ؽ��===============================
<br />
<?php
require_once("../config/pay_config.php");
$callback_url	= $_POST['url'];

/*
$orderid
���й����д�����̻�orderid
*/
$orderid		= $_POST['orderid'];

/*
$opstate
�������״̬��
0 �����ɹ�ʹ��
-1 �����������
-2 ��ʵ����ֵ���ύʱ��ֵ����������ʵ����ֵδʹ�á���ʵ����ֵ��ovalue��ʾ
-3 ��ʵ����ֵ���ύʱ��ֵ����������ʵ����ֵ�ѱ�ʹ�á���ʵ����ֵ��ovalue��ʾ
-4 ���Ѿ�ʹ�ã������ύ���ڿ�����֮ǰ�Ѿ���ʹ�ã�
-5 ʧ��(����ԭ�򡢾���ԭ����ȷ��)

*/
$opstate		= $_POST['opstate'];

/*
opstate=-2����-3ʱ��ʾ��ֵ����λԪ(ע����ֻ�ṩ��ȷ�Ŀ�����ʵ����ֵ��������ֵΪ0������Ч��Ϊ�˾�ȷ�ԣ���ֵ���ܴ���4λС��)
*/
$ovalue			= $_POST['ovalue'];

/*
�˴ο����Ĺ������ڿ�ϵͳ�Ķ���Id
*/
$shunfooorderid		= $_POST['shunfooorderid'];

/*
�˴ο����Ĺ������ڿ�ϵͳ�Ķ�������ʱ��
*/
$shunfootime		= $_POST['shunfootime'];


$sign_text  = "orderid=" . $orderid . "&opstate=" . $opstate . "&ovalue=" . $ovalue;
$sign_md5 	= md5($sign_text .$shunfoo_merchant_key);


$url = 	$callback_url . '?' . $sign_text . "&sign=" .$sign_md5;
$url .= "&shunfooorderid=$shunfooorderid&shunfootime=$shunfootime";


echo("�����ַ�� ". $url);


$result=file_get_contents($url);
echo("<br />�������� ". $result);


?>