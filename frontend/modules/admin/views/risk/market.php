<html>
    <header></header>
    <body>
    <table class="table table-striped">
        <?php foreach ($products as $key => $value){?>
        <tr id="<?php echo $value['id']?>">
            <td class="active"><?php echo "{$value['name']}"; ?></td>
            <td class="success">
                <?php if ($value['closed_market']=='1'){
                    echo "<button type='button' class='btn btn-success' <?php echo uid='{$value['id']}-1'?>正常销售</button>";
                }else{
                    echo "<button type='button' class='btn btn-danger' <?php echo uid='{$value['id']}-2'>市场休息</button>";
                }?>
            </td>
        </tr>
        <?php }?>
    </table>

    </body>
    <script type="text/javascript">
        $(document).on("click", "button", function () {
            // 获取当前点击的id编号
            var uid = $(this)[0].getAttribute('uid');

            $.ajax({
                url:'/admin/risk/market',
                data:uid,
                type:'post',
                dataType:'text',
                contentType:'application/x-www-form-urlencoded; charset=utf-8',
                success:function(msg){
                    // top.location.reload() //刷新最顶端对象（用于多开窗口）
                    window.location.reload()
                    // console.log(msg);
                    // $("#main").empty();
                    // $("#main").html(msg);
                }

            });
        });
    </script>
</html>