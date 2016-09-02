
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]><script src="{$system['system_url']}/includes/js/plugins/html5shiv/html5shiv.js"></script><![endif]-->

<!-- Initialize -->
<script type="text/javascript">
    // initialize vars
    var site_path = "{$system['system_url']}";
    var ajax_path = site_path+'/includes/ajax/';
    var uploads_path = "{$system['system_uploads']}";
    var secret = '{$secret}';
</script>
<script type="text/javascript">
    // initialize translated strings
    var __ = [];
    __["Add Friend"] = '{__("Add Friend")}';
    __["Friends"] = '{__("Friends")}';
    __["Friend Request Sent"] = '{__("Friend Request Sent")}';
    __["Following"] = '{__("Following")}';
    __["Follow"] = '{__("Follow")}';
    __["Remove"] = '{__("Remove")}';
    __["Error"] = '{__("Error")}';
    __["Success"] = '{__("Success")}';
    __["Loading"] = '{__("Loading")}';
    __["Like"] = '{__("Like")}';
    __["Unlike"] = '{__("Unlike")}';
    __["Joined"] = '{__("Joined")}';
    __["Join Group"] = '{__("Join Group")}';
    __["Delete"] = '{__("Delete")}';
    __["Delete Cover"] = '{__("Delete Cover")}';
    __["Delete Picture"] = '{__("Delete Picture")}';
    __["Delete Post"] = '{__("Delete Post")}';
    __["Delete Comment"] = '{__("Delete Comment")}';
    __["Delete Conversation"] = '{__("Delete Conversation")}';
    __["Share Post"] = '{__("Share Post")}';
    __["Report User"] = '{__("Report User")}';
    __["Report Page"] = '{__("Report Page")}';
    __["Report Group"] = '{__("Report Group")}';
    __["Block User"] = '{__("Block User")}';
    __["Unblock User"] = '{__("Unblock User")}';
    __["Are you sure you want to delete this?"] = '{__("Are you sure you want to delete this?")}';
    __["Are you sure you want to remove your cover photo?"] = '{__("Are you sure you want to remove your cover photo?")}';
    __["Are you sure you want to remove your profile picture?"] = '{__("Are you sure you want to remove your profile picture?")}';
    __["Are you sure you want to delete this post?"] = '{__("Are you sure you want to delete this post?")}';
    __["Are you sure you want to share this post?"] = '{__("Are you sure you want to share this post?")}';
    __["Are you sure you want to delete this comment?"] = '{__("Are you sure you want to delete this comment?")}';
    __["Are you sure you want to delete this conversation?"] = '{__("Are you sure you want to delete this conversation?")}';
    __["Are you sure you want to report this user?"] = '{__("Are you sure you want to report this user?")}';
    __["Are you sure you want to report this page?"] = '{__("Are you sure you want to report this page?")}';
    __["Are you sure you want to report this group?"] = '{__("Are you sure you want to report this group?")}';
    __["Are you sure you want to block this user?"] = '{__("Are you sure you want to block this user?")}';
    __["Are you sure you want to unblock this user?"] = '{__("Are you sure you want to unblock this user?")}';
    __["Are you sure you want to delete your account?"] = '{__("Are you sure you want to delete your account?")}';
    __["There is some thing went worng!"] = '{__("There is some thing went worng!")}';
    __["There is no more data to show"] = 'No hay más datos para mostrar';
    __["This has been shared to your Timeline"] = '{__("This has been shared to your Timeline")}';
</script>
<!-- Initialize -->

<!-- jQuery & jQuery UI -->
<script type="text/javascript" src="{$system['system_url']}/includes/js/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/jquery/jquery.ui.touch-punch.min.js"></script>
<!-- jQuery & jQuery UI -->

<!-- Bootstrap -->
<script type="text/javascript" src="{$system['system_url']}/includes/js/bootstrap/bootstrap.min.js"></script>
<!-- Bootstrap -->

<!-- Mustache -->
<script type="text/javascript" src="{$system['system_url']}/includes/js/mustache/mustache.min.js"></script>
<!-- Mustache -->

<!-- Plugins -->
<script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/autogrow/autogrow.min.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/moment/moment.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/form/jquery.form.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/inview/jquery.inview.min.js"></script>
<script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/fastclick/fastclick.js"></script>
<!-- Plugins -->

{if $page == "admin"}
    <!-- dataTables -->
    <link rel="stylesheet" type='text/css' href="{$system['system_url']}/includes/js/plugins/dataTables/dataTables.bootstrap.min.css">
    <script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/dataTables/dataTables.bootstrap.min.js"></script>
    <!-- dataTables -->

    <!-- metisMenu -->
    <link rel="stylesheet" type='text/css' href="{$system['system_url']}/includes/js/plugins/metisMenu/metisMenu.css">
    <script type="text/javascript" src="{$system['system_url']}/includes/js/plugins/metisMenu/metisMenu.js"></script>
    <!-- metisMenu -->
{/if}

<!-- Marsesweb -->
<script type="text/javascript" src="{$system['system_url']}/includes/js/core.js"></script>
{if $user->_logged_in}
    <script type="text/javascript" src="{$system['system_url']}/includes/js/user.js"></script>
    <script type="text/javascript" src="{$system['system_url']}/includes/js/post.js"></script>
    <script type="text/javascript" src="{$system['system_url']}/includes/js/chat.js"></script>
{/if}
{if $page == "admin"}
    <script type="text/javascript" src="{$system['system_url']}/includes/js/admin.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script>
{/if}
<!-- Marsesweb -->