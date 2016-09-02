{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container">

    <!-- profile-header -->
    <div class="profile-header">
        <!-- profile-cover -->
        {if $group['group_cover']}
        <div class="profile-cover-wrapper" style="background-image:url('{$system['system_uploads']}/{$group['group_cover']}');">
        {else}
        <div class="profile-cover-wrapper no-cover">
        {/if}
            {if $user->_logged_in && $user->_data['user_id'] == $group['group_admin']}
            <div class="profile-cover-change">
                <i class="fa fa-camera js_x-uploader" data-handle="cover-group" data-id="{$group['group_id']}"></i>
            </div>
            {if $group['group_cover']}
            <div class="profile-cover-delete">
                <i class="fa fa-trash js_delete-cover" data-handle="cover-group" data-id="{$group['group_id']}" title="{__("Delete Cover")}"></i>
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
            <img class="img-responsive" src="{$group['group_picture']}" alt="{$group['group_title']}">
            {if $user->_logged_in && $user->_data['user_id'] == $group['group_admin']}
            <div class="profile-avatar-change">
                <i class="fa fa-camera js_x-uploader" data-handle="picture-group" data-id="{$group['group_id']}"></i>
            </div>
            <div class="profile-avatar-delete">
                <i class="fa fa-trash js_delete-picture" data-handle="picture-group" data-id="{$group['group_id']}" title="{__("Delete Picture")}"></i>
            </div>
            <div class="profile-avatar-change-loader">
                <div class="loader loader_medium"></div>
            </div>
            {/if}
        </div>
        <!-- profile-avatar -->

        <!-- profile-name -->
        <div class="profile-name-wrapper">
            <a href="{$system['system_url']}/groups/{$group['group_name']}">{$group['group_title']}</a>
        </div>
        <!-- profile-name -->

        <!-- profile-buttons -->
        <div class="profile-buttons-wrapper">
            {if $user->_logged_in && $group['i_joined']}
                <button type="button" class="btn btn-default btn-friends js_leave-group" data-id="{$group['group_id']}">
                    <i class="fa fa-check"></i>
                    {__("Joined")}
                </button>
            {else}
                <button type="button" class="btn btn-success js_join-group" data-id="{$group['group_id']}">
                    <i class="fa fa-user-plus"></i>
                    {__("Join Group")}
                </button>
            {/if}
            {if $user->_logged_in && $user->_data['user_id'] == $group['group_admin']}
                <a href="{$system['system_url']}/groups/{$group['group_name']}/settings" class="btn btn-default">
                    <i class="fa fa-pencil"></i> {__("Update Info")}
                </a>
            {else}
                <a href="#" class="btn btn-default js_report-group" data-id="{$group['group_id']}">
                    <i class="fa fa-flag"></i> {__("Report")}
                </a>
            {/if}
        </div>
        <!-- profile-buttons -->

        <!-- profile-tabs -->
        <div class="profile-tabs-wrapper">
            <ul class="nav">
                <li>
                    <a href="{$system['system_url']}/groups/{$group['group_name']}">
                        {__("Timeline")}
                    </a>
                </li>
                <li class="middle-tabs">
                    <a href="{$system['system_url']}/groups/{$group['group_name']}/members">
                        {__("Members")}
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
                    {if $user->_logged_in && $group['i_joined']}
                        <button type="button" class="btn btn-default btn-friends js_leave-group" data-id="{$group['group_id']}">
                            <i class="fa fa-check"></i>
                            {__("Joined")}
                        </button>
                    {else}
                        <button type="button" class="btn btn-success js_join-group" data-id="{$group['group_id']}">
                            <i class="fa fa-user-plus"></i>
                            {__("Join Group")}
                        </button>
                    {/if}
                    {if $user->_logged_in && $user->_data['user_id'] == $group['group_admin']}
                        <a href="{$system['system_url']}/groups/{$group['group_name']}/settings" class="btn btn-default">
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
                                    <i class="fa fa-users fa-fw fa-lg"></i>
                                    {$group['group_members']} {__("members")}
                                </div>
                            </li>
                            <li>
                                <div class="about-list-item">
                                    <i class="fa fa-star fa-fw fa-lg"></i>
                                    {$group['group_description']}
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- about -->
            </div>
            <div class="col-sm-8">

                {if $user->_logged_in && $group['i_joined']}
                <!-- publisher -->
                {include file='_publisher.tpl' _handle="group" _group=$group['group_id']}
                <!-- publisher -->
                {/if}

                <!-- posts -->
                {include file='_posts.tpl' _get="posts_group" _id=$group['group_id']}
                <!-- posts -->
            </div>

        {elseif $view == "members"}
            <!-- members -->
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading with-icon with-nav">

                        <!-- panel title -->
                        <div class="mb20">
                            <i class="fa fa-users pr5 panel-icon"></i>
                            <strong>{__("Members")}</strong>
                        </div>
                        <!-- panel title -->

                        <!-- panel nav -->
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="{$system['system_url']}/{$profile['user_name']}/members">
                                    <strong class="pr5">{__("Members")}</strong>
                                    <small>{$group['group_members']}</small>
                                </a>
                            </li>
                        </ul>
                        <!-- panel nav -->
                    </div>
                    <div class="panel-body">
                        {if $group['group_members'] > 0}
                        <ul class="row">
                            {foreach $group['members'] as $_user}
                            {include file='__feeds_user.tpl' _connection=$_user["connection"] _parent="profile"}
                            {/foreach}
                        </ul>

                        {if count($group['group_members']) >= $system['max_results']}
                        <!-- see-more -->
                        <div class="alert alert-info see-more js_see-more" data-get="members" data-id="{$group['group_id']}">
                            <span>{__("See More")}</span>
                            <div class="loader loader_small x-hidden"></div>
                        </div>
                        <!-- see-more -->
                        {/if}
                        {else}
                        <p class="text-center text-muted mt10">
                            {$group['user_fullname']} {__("doesn't have members")}
                        </p>
                        {/if}
                    </div>
                </div>
            </div>
            <!-- members -->

        {elseif $view == "settings"}
            <div class="col-md-3 col-sm-3">
                <div class="panel panel-default">
                    <div class="panel-body with-nav">
                        <ul class="nav">
                            <li {if $tab == ""}class="active"{/if}>
                                <a href="{$system['system_url']}/groups/{$group['group_name']}/settings"><i class="fa fa-wrench fa-fw fa-lg pr10"></i> {__("Group Settings")}</a>
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
                            <button type="button" class="btn btn-danger js_delete-group" data-id="{$group['group_id']}">
                                <i class="fa fa-trash-o"></i>
                                {__("Delete Group")}
                            </button>
                        </div>
                        <!-- delete -->
                        <!-- panel title -->
                        <i class="fa fa-wrench pr5 panel-icon"></i>
                        <strong>{__("Group Settings")}</strong>
                        <!-- panel title -->
                    </div>
                    <div class="panel-body">
                        
                        <form class="js_ajax-forms" data-url="data/create.php?type=group&amp;do=edit&amp;id={$group['group_id']}">
                            <div class="form-group">
                                <label for="title">{__("Title")}:</label>
                                <input type="text" class="form-control" name="title" id="title" placeholder="{__("Name of your group")}" value="{$group['group_title']}">
                            </div>
                            <div class="form-group">
                                <label for="username">{__("Username")}:</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="{__("Username, e.g. DevelopersGroup")}" value="{$group['group_name']}">
                            </div>
                            <div class="form-group">
                                <label for="description">{__("Description")}:</label>
                                <textarea class="form-control" name="description" id="description" placeholder="{__("Write about your group...")}">{$group['group_description']}</textarea>
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