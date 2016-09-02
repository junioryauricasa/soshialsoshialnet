<?php
/**
 * config
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

class Image {
    
    public $_img;
    public $_img_ext;
    public $_img_type;
    public $_img_width;
    public $_img_height;
    
    /**
     * __construct
     * 
     * @param string $file
     */
    public function __construct($file) {
        
        $img_info = @getimagesize($file);
        if(!$img_info) {
            throw new Exception(__("The file type is not valid image"));
        }
        $this->_img_type = $img_info['mime'];
        if($this->_img_type == 'image/jpeg' || $this->_img_type == 'image/jpg') {
            $this->_img = imagecreatefromjpeg($file);
            $this->_img_ext = '.jpg';
        }elseif($this->_img_type == 'image/gif') {
            $this->_img = imagecreatefromgif($file);
            $this->_img_ext = '.gif';
        }elseif($this->_img_type == 'image/png') {
            $this->_img = imagecreatefrompng($file);
            $this->_img_ext = '.png';
        }else {
            throw new Exception(__("The file type is not valid image"));
        }
    }
    
    /**
     * get_type
     * 
     * @return string
     */
    public function get_type() {
        return $this->_img_type;
    }
    
    /**
     * get_width
     * 
     * @return integer
     */
    public function get_width() {
        return imagesx($this->_img);
    }
    
    /**
     * get_height
     * 
     * @return integer
     */
    public function get_height() {
        return imagesy($this->_img);
    }
    
    /**
     * resize
     * 
     * @param integer $width
     * @param integer $height
     */
    public function resize($width, $height) {
        $new_image = imagecreatetruecolor($width, $height);
        imagecopyresampled($new_image, $this->_img, 0, 0, 0, 0, $width, $height, $this->get_width(), $this->get_height());
        $this->_img = $new_image;
    }
    
    /**
     * resize_width
     * 
     * @param integer $width
     */
    public function resize_width($width) {
        $ratio = $width / $this->get_width();
        $height = $this->get_height() * $ratio;
        $this->resize($width, $height);
    }
    
    /**
     * resize_height
     * 
     * @param integer $height
     */
    public function resize_height($height) {
        $ratio = $height / $this->get_height();
        $width = $this->get_width() * $ratio;
        $this->resize($width, $height);
    }
    
    /**
     * save
     * 
     * @param string $path_new
     * @param string $path_tmp
     */
    public function save($path_new, $path_tmp = '') {
        if($this->_img_type == 'image/jpeg' || $this->_img_type == 'image/jpg') {
            if($this->get_width() > 800) {
                $this->resize_width(800);
            }
            imagejpeg($this->_img, $path_new);
        }elseif($this->_img_type == 'image/gif') {
            copy($path_tmp, $path_new);
        }elseif($this->_img_type == 'image/png') {
            if($this->get_width() > 800) {
                $this->resize_width(800);
            }
            imagealphablending($this->_img, false);
            imagesavealpha($this->_img, true);
            imagepng($this->_img, $path_new);
        }
    }
    
}
?>