{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container">

    <!-- profile-header -->
    <div class="profile-header">
        <!-- profile-cover -->
        {if $spage['page_cover']}
        <div class="profile-cover-wrapper" style="background-image:url('{$system['system_uploads']}/{$spage['page_cover']}');">
        {else}
        <div class="profile-cover-wrapper no-cover">
        {/if}
            {if $user->_logged_in && $user->_data['user_id'] == $spage['page_admin']}
            <div class="profile-cover-change">
                <i class="fa fa-camera js_x-uploader" data-handle="cover-page" data-id="{$spage['page_id']}"></i>
            </div>
            {if $spage['page_cover']}
            <div class="profile-cover-delete">
                <i class="fa fa-trash js_delete-cover" data-handle="cover-page" data-id="{$spage['page_id']}" title="{__("Delete Cover")}"></i>
            </div>
            {/if}
            <div class="profile-cover-change-loader">
                <div class="loader loader_large"></div>
            </div>
            {/if}
        </div>
        <!-- profile-cover -->

        <!-- profile-avatar -->
        <div class="profile-avatar-wrapper">
            <img src="{$spage['page_picture']}" alt="{$spage['page_title']}">
            {if $user->_logged_in && $user->_data['user_id'] == $spage['page_admin']}
            <div class="profile-avatar-change">
                <i class="fa fa-camera js_x-uploader" data-handle="picture-page" data-id="{$spage['page_id']}"></i>
            </div>
            <div class="profile-avatar-delete">
                <i class="fa fa-trash js_delete-picture" data-handle="picture-page" data-id="{$spage['page_id']}" title="{__("Delete Picture")}"></i>
            </div>
            <div class="profile-avatar-change-loader">
                <div class="loader loader_medium"></div>
            </div>
            {/if}
        </div>
        <!-- profile-avatar -->

        <!-- profile-name -->
        <div class="profile-name-wrapper">
            <a href="{$system['system_url']}/pages/{$spage['page_name']}">{$spage['page_title']}</a>
            {if $spage['page_verified']}
                <i data-toggle="tooltip" data-placement="top" title="{__("Verified page")}" class="fa fa-check verified-badge"></i>
            {/if}
        </div>
        <!-- profile-name -->

        <!-- profile-buttons -->
        <div class="profile-buttons-wrapper">
            {if $user->_logged_in && $spage['i_like']}
                <button type="button" class="btn btn-default js_unlike-page" data-id="{$spage['page_id']}">
                    <i class="fa fa-thumbs-o-up"></i>
                    {__("Unlike")}
                </button>
            {else}
                <button type="button" class="btn btn-primary js_like-page" data-id="{$spage['page_id']}">
                    <i class="fa fa-thumbs-o-up"></i>
                    {__("Like")}
                </button>
            {/if}
            {if $user->_logged_in && $user->_data['user_id'] == $spage['page_admin']}
                <a href="{$system['system_url']}/pages/{$spage['page_name']}/settings" class="btn btn-default">
                    <i class="fa fa-pencil"></i> {__("Update Info")}
                </a>
            {else}
                <a href="#" class="btn btn-default js_report-page" data-id="{$spage['page_id']}">
                    <i class="fa fa-flag"></i> {__("Report")}
                </a>
            {/if}
        </div>
        <!-- profile-buttons -->

        <!-- profile-tabs -->
        <div class="profile-tabs-wrapper">
            <ul class="nav">
                <li>
                    <a href="{$system['system_url']}/pages/{$spage['page_name']}">
                        {__("Timeline")}
                    </a>
                </li>
            </ul>
        </div>
        <!-- profile-tabs -->
    </div>
    <!-- profile-header -->


    <!-- profile-content -->
    <div class="row">

        <!-- profile-buttons alt -->
        <div class="col-sm-12">
            <div class="panel panel-default profile-buttons-wrapper-alt">
                <div class="panel-body">
                    {if $user->_logged_in && $spage['i_like']}
                        <button type="button" class="btn btn-default js_ullike-page" data-pid="{$spage['page_id']}">
                            <i class="fa fa-thumbs-o-up"></i>
                            {__("Unlike")}
                        </button>
                    {else}
                        <button type="button" class="btn btn-primary js_like-page" data-pid="{$spage['page_id']}">
                            <i class="fa fa-thumbs-o-up"></i>
                            {__("Like")}
                        </button>
                    {/if}
                    {if $user->_logged_in && $user->_data['user_id'] == $spage['page_admin']}
                        <a href="{$system['system_url']}/pages/{$spage['page_name']}/settings" class="btn btn-default">
                            <i class="fa fa-pencil"></i> {__("Update Info")}
                        </a>
                    {/if}
                </div>
            </div>
        </div>
        <!-- profile-buttons alt -->

        {if $view == ""}
            <div class="col-sm-4">
                <!-- about -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <ul class="about-list">
                            <li>
                                <div class="about-list-item">
                                    <i class="fa fa-thumbs-o-up fa-fw fa-lg"></i>
                                    {$spage['page_likes']} {__("people like this")}
                                </div>
                            </li>

                            <li>
                                <div class="about-list-item">
                                    <i class="fa fa-briefcase fa-fw fa-lg"></i>
                                    {$spage['category_name']}
                                </div>
                            </li>
                            
                            <li>
                                <div class="about-list-item">
                                    <i class="fa fa-star fa-fw fa-lg"></i>
                                    {$spage['page_description']}
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- about -->
            </div>
            <div class="col-sm-8">

                {if $user->_logged_in && $user->_data['user_id'] == $spage['page_admin']}
                <!-- publisher -->
                {include file='_publisher.tpl' _handle="page" _page=$spage['page_id']}
                <!-- publisher -->
                {/if}
                
                <!-- posts -->
                {include file='_posts.tpl' _get="posts_page" _id=$spage['page_id']}
                <!-- posts -->
            </div>

        {elseif $view == "settings"}
            <div class="col-md-3 col-sm-3">
                <div class="panel panel-default">
                    <div class="panel-body with-nav">
                        <ul class="nav">
                            <li {if $tab == ""}class="active"{/if}>
                                <a href="{$system['system_url']}/pages/{$spage['page_name']}/settings"><i class="fa fa-wrench fa-fw fa-lg pr10"></i> {__("Page Settings")}</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9">
                <!-- edit page -->
                <div class="panel panel-default">
                    <div class="panel-heading with-icon">
                        <!-- delete -->
                        <div class="pull-right flip">
                            <button type="button" class="btn btn-danger js_delete-page" data-id="{$spage['page_id']}">
                                <i class="fa fa-trash-o"></i>
                                {__("Delete Page")}
                            </button>
                        </div>
                        <!-- delete -->
                        <!-- panel title -->
                        <i class="fa fa-wrench pr5 panel-icon"></i>
                        <strong>{__("Page Settings")}</strong>
                        <!-- panel title -->
                    </div>
                    <div class="panel-body">
                        
                        <form class="js_ajax-forms" data-url="data/create.php?type=page&amp;do=edit&amp;id={$spage['page_id']}">
                            <div class="form-group">
                                <label for="category">{__("Category")}:</label>
                                <select class="form-control" name="category" id="category">
                                    {foreach $categories as $category}
                                        <option {if $spage['page_category'] == $category['category_id']}selected{/if} value="{$category['category_id']}">{$category['category_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="title">{__("Title")}:</label>
                                <input type="text" class="form-control" name="title" id="title" placeholder="{__("Title of your page")}" value="{$spage['page_title']}">
                            </div>
                            <div class="form-group">
                                <label for="username">{__("Username")}:</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="{__("Username, e.g. YouTubeOfficial")}" value="{$spage['page_name']}">
                            </div>
                            <div class="form-group">
                                <label for="description">{__("Description")}:</label>
                                <textarea class="form-control" name="description" id="description" placeholder="{__("Write about your page...")}">{$spage['page_description']}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">{__("Save")}</button>

                            <!-- error -->
                            <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                            <!-- error -->
                        </form>

                    </div>
                </div>
                <!-- edit page -->
            </div>

        {/if}

    </div>
    <!-- profile-content -->

</div>
<!-- page content -->

{include file='_footer.tpl'}