<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <style>
        .a-upload {
            padding: 4px 10px;
            height: 32px;
            line-height: 26px;
            position: relative;
            cursor: pointer;
            color: #888;
            background: #fafafa;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            display: inline-block;
            *display: inline;
            *zoom: 1
        }

        .a-upload  input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer
        }

        .a-upload:hover {
            color: #444;
            background: #eee;
            border-color: #ccc;
            text-decoration: none
        }
        .headertext{
            width: 100% ;
            background-color: #ccccccba;
            height: 3em;
            text-align: center;
        }
        .headertext H4{
            padding-top: 1em;
        }
        .boody{
            background-color: #F2F2F2;
            width: 28em;
            height: 60em;
        }
    </style>
</head>
<body>
<div class="boody">

    <link rel="stylesheet" href="/test/main.css?r=20170520">
    <ul class="index-head flex col-w" style="background: #000;color: #fff;text-align: center;">
        <li class="le" style="width: 20%; display: inline-block;"><a onclick="JavaScript:history.back(-1);" class="col-w"><i class="iconfont"></i></a></li>
        <li class="mid" style="width: 58%; display: inline-block;">上传银行卡</li>
        <li class="ri" style="width: 20%; display: inline-block;"><a class="col-w"></a></li>
    </ul>
    <div class="headertext">
        <H4>您的照片仅用于审核，我们将严格为您保密</H4>
    </div>
<form enctype="multipart/form-data" action="upload-bank-picture" method="POST">

    <input type="hidden" name="userid" value="<?php echo  u()->id ;?>" />

    <i style="font-size: 18px;margin: 10px auto">上传银行卡:</i></br>
    <a href="javascript:;" class="a-upload">
        <input name="userfile" type="file"   id="file_input"/>点击这里选择银行卡
    </a>
    <div id="result">
        <!-- 这里用来显示读取结果 -->
        <img src="/test/bankcard.jpg" width="200px">
    </div>
</br>
    <input class="btn btn-info" type="submit" value="点击上传" />

</form>
</body>
<script type="text/javascript">
    var result = document.getElementById("result");
    var input = document.getElementById("file_input");

    if(typeof FileReader === 'undefined'){
        result.innerHTML = "抱歉，你的浏览器不支持 FileReader";
        input.setAttribute('disabled','disabled');
    }else{
        input.addEventListener('change',readFile,false);
    }


    function readFile(){
        var file = this.files[0];
        if(!/image\/\w+/.test(file.type)){
            alert("请确保文件为图像类型");
            return false;
        }
        var reader = new FileReader();
        reader.readAsDataURL(file);

        reader.onload = function(e){
            //alert(3333)
            //alert(this.result);
            result.innerHTML = '<img width="200px"  src="'+this.result+'" alt=""/>'
        }
    }
</script>
</html>