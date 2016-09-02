<?php
/**
 * ajax -> data -> video
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('../../../bootstrap.php');

// fetch image class
require('../../class-image.php');

// check AJAX Request
is_ajax();

// check user logged in
if(!$user->_logged_in) {
    modal(LOGIN);
}

// check user activated
if($system['email_send_activation'] && !$user->_data['user_activated']) {
    modal(MESSAGE, __("Not Activated"), __("Before you can interact with other users, you need to confirm your email address"));
}

// check secret
if($_SESSION['secret'] != $_POST['secret']) {
    _error(403);
}

// valid inputs
if(!isset($_FILES["file"]) || $_FILES["file"]["error"] != UPLOAD_ERR_OK) {
    modal(MESSAGE, __("Upload Error"), __("Something wrong with upload! Is 'upload_max_filesize' set correctly?"));
}

// get allowed file size
$max_allowed_size = $system['max_video_size'] * 1024;

/* if file size is bigger than allowed size */
if($_FILES["file"]["size"] > $max_allowed_size) {
    modal(MESSAGE, __("Upload Error"), __("The file size is so big"));
}

/* if file size is bigger than allowed size */
if($_FILES["file"]["type"] != "video/mp4") {
    modal(MESSAGE, __("Upload Error"), __("The file type is not valid video, we support .mp4 only"));
}

// upload
try {

    $prefix = 'marsesweb_'.md5(time()*rand(1, 9999));
    $video_new_name = $prefix.'.mp4';
    $path_new = '../../../'.$system['system_uploads_directory'].'/'.$video_new_name;

    /* check if the file uploaded successfully */
    if(!@move_uploaded_file($_FILES['file']['tmp_name'], $path_new)) {
        modal(MESSAGE, __("Upload Error"), __("Sorry, can not upload the file"));
    }

    // return the file new name & exit
    return_json(array("file" => $video_new_name));

}catch (Exception $e) {
    modal(ERROR, __("Error"), $e->getMessage());
}
    

?>