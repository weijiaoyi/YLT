<?= $html ?>

<script>
$(function () {

    $(".list-container").on('click', '.invitationCode', function () {
        var $this = $(this);
        var code = $this.context.search + Date.now();
        code = code + 'code';
        code =code.substring(4,27)
            $.post($this.attr('href'),{upcode:code}, function (msg) {
                if (msg.state) {
                    $.alert(msg.info || '生成成功');
                } else {
                    $.alert(msg.info);
                }
            }, 'json');
        return false;

    });

    $(".list-container").on('click', '.editBtn', function () {
        var $this = $(this);
        $.prompt('请输入修改的返点', function (value) {
            $.post($this.attr('href'), {point: value}, function (msg) {
                if (msg.state) {
                    $.alert(msg.info || '修改成功');
                } else {
                    $.alert(msg.info);
                }
            }, 'json');
        });
        return false;
    });
});
</script>