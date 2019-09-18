<?php $form = self::beginForm() ?>
<?= $user->title('经纪人') ?>
<?= $form->field($user, 'username')->textInput(['placeholder'=> '登录用户名']) ?>
<?= $form->field($user, 'nickname')->textInput(['placeholder'=> '用户姓名']) ?>
<?= $form->field($user, 'mobile') ?>
<?= $form->field($user, 'admin_id')->textInput(['placeholder'=> '代理商ID号']) ?>
<?= $form->field($user, 'password')->textInput(['placeholder' => $user->isNewRecord ? '' : '不填表示不修改']) ?>
<?= $form->submit($user) ?>
<?php self::endForm() ?>

<script>
$(function () {
    $("#submitBtn").click(function () {
        $("form").ajaxSubmit($.config('ajaxSubmit', {
            success: function (msg) {
                if (msg.state) {
                    $.alert('操作成功', function () {
                        parent.location.reload();
                    });
                } else {
                    $.alert(msg.info);
                }
            }
        }));
        return false;
    });
});
</script>