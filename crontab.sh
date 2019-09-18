#!/bin/bash  
      
step=1  
      
for (( i = 0; i < 60; i=(i+step) )); do  
    $(php '/www/wwwroot/dqh.ooole.cn/yii' 'init/gather2')
     sleep $step  
done  
      
exit 0  