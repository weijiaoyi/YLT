<?php
/**
 * Created by PhpStorm.
 * User: 10
 * Date: 2019/4/22
 * Time: 17:43
 */

namespace frontend\models;


class FileCache
{
    private static $Dir = './'; // 缓存的目录
    private static $DirMode = 0777; // 文件夹权限

    /**
     * 设置缓存目录
     * @param $dir string 缓存的目录
     */
    public function Dir( $dir ){
        if ( !is_dir( $dir ) ) {
            mkdir( $dir, self::$DirMode, true );
        }
        self::$Dir = $dir;
    }

    /**
     * 读取缓存文件
     * @param $file string 缓存文件
     * @param boolean 读取成功返回结果, 否则返回 false
     */
    public function Read( $file ){
        $filename = self::$Dir . $file;
        if ( !file_exists( $filename ) ) {
            return false;
        }
        // 读取缓存文件
        if (!( $handle = @fopen( $filename, 'rb' ) ) ) {
            return false;
        }
        // 跳过写入缓存文件保护代码
        fgets( $handle );
        // 取出序列化的缓存数据,并进行序列化恢复
        $data = unserialize( fgets( $handle ) );
        return $data;
    }

    /**
     * 写入缓存文件
     * @param $file string 写入缓存的文件名
     * @param $data array, 需要进行缓存数据
     * @param boolean 读取成功返回结果, 否则返回 false
     */
    public function Write( $file, $data = array() ){
        $filename = self::$Dir . $file;
        // 尝试打开 $filename，如果文件不存在则创建
        if ( $handle = @fopen( $filename, 'wb' ) ) {
            // 取得独占锁定
            @flock($handle, LOCK_EX);
            // 缓存文件建议保存为 .php 格式
            // 写入缓存文件保护代码
            // 防止恶意访问该文件
            fwrite( $handle, '<' . '?php exit; ?' . '>' );
            fwrite( $handle, "\n" );
            // 序列化待缓存的数据
            $data = serialize($data);
            // 写入缓存数据
            fwrite( $handle, $data );
            // 释放锁定
            @flock( $handle, LOCK_UN );
            fclose( $handle );
            return true;
        }
        return false;
    }

    /**
     * 清除缓存文件
     * @param array $fileArr 需要清除的缓存文件
     * @param bool $filenameMode 完整文件名模式，为 true 时必须 $file 参数必须输入完整的文件名，用于清除不在同一文件夹下的缓存文件！
     *
     * 案例：
     * Cache::Clear(array('file1'));//清除单条数据
     * Cache::Clear(array('file1', 'file2', 'file3'));//清除多条数据,注意：必须在同一文件夹下
     * Cache::Clear(array('../cache/file1', '../new/cache/file1'), true);//完整文件名模式
     */
    public function Clear( $fileArr, $filenameMode = false ) {
        if ( !is_array( $fileArr ) || empty( $fileArr ) ) {
            return;
        }
        foreach ( $fileArr as $File ) {
            if ( $filenameMode ) {
                unlink( $File );
            } else {
                unlink(self::$Dir . $File);
            }
        }
    }

}