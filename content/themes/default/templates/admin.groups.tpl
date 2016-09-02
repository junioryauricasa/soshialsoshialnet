<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == "edit"}
            <div class="pull-right flip">
                <a target="_blank" href="{$system['system_url']}/groups/{$data['group_name']}" class="btn btn-info">
                    {__("Go to this group")}
                </a>
            </div>
        {/if}
        <i class="fa fa-users pr5 panel-icon"></i>
        <strong>{__("Groups")}</strong>
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['group_title']}</strong>{/if}
    </div>
    {if $sub_view != "edit"}
        <div class="panel-body with-table">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover js_dataTable">
                    <thead>
                        <tr>
                            <th>{__("ID")}</th>
                            <th>{__("Picture")}</th>
                            <th>{__("URL")}</th>
                            <th>{__("Title")}</th>
                            <th>{__("Members")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td><a href="{$system['system_url']}/groups/{$row['group_name']}" target="_blank">{$row['group_id']}</a></td>
                            <td class="post-avatar">
                                <a target="_blank" class="post-avatar-picture" href="{$system['system_url']}/groups/{$row['group_name']}" style="background-image:url({$row['group_picture']});">
                                </a>
                            </td>
                            <td>
                                <a href="{$system['system_url']}/groups/{$row['group_name']}" target="_blank">
                                    {$row['group_name']}
                                </a>
                            </td>
                            <td>
                                <a href="{$system['system_url']}/groups/{$row['group_name']}" target="_blank">
                                    {$row['group_title']}
                                </a>
                            </td>
                            <td>{$row['group_members']}</td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="group" data-id="{$row['group_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/groups/edit/{$row['group_id']}" class="btn btn-xs btn-primary">
                                    <i class="fa fa-pencil"></i>
                                </a>
                            </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>

    {elseif $sub_view == "edit"}
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-offset-3 col-xs-6 col-sm-offset-0 col-sm-2 mb10">
                    <img class="img-responsive img-thumbnail" src="{$data['group_picture']}">
                </div>
                <div class="col-xs-12 col-sm-10 mb10">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <span class="badge">{$data['group_id']}</span>
                            {__("Group ID")}
                        </li>
                        <li class="list-group-item">
                            <span class="badge">{$data['group_members']}</span>
                            {__("Members")}
                        </li>
                    </ul>
                </div>
            </div>
            <!-- tabs nav -->
            <ul class="nav nav-tabs mb20">
                <li class="active">
                    <a href="#basic" data-toggle="tab">
                        <strong class="pr5">{__("Group Info")}</strong>
                    </a>
                </li>
            </ul>
            <!-- tabs nav -->

            <!-- tabs content -->
            <div class="tab-content">
                <!-- basic tab -->
                <div class="tab-pane active" id="basic">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/group.php?id={$data['group_id']}">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Title")}
                            </label>
                            <div class="col-sm-9">
                                <input class="form-control" name="group_title" value="{$data['group_title']}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Username")}
                            </label>
                            <div class="col-sm-9">
                                <input class="form-control" name="group_name" value="{$data['group_name']}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Username")}
                            </label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="group_description">{$data['group_description']}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-9 col-sm-offset-3">
                                <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
                            </div>
                        </div>

                        <!-- success -->
                        <div class="alert alert-success mb0 mt10 x-hidden" role="alert"></div>
                        <!-- success -->

                        <!-- error -->
                        <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                        <!-- error -->
                    </form>
                </div>
            </div>
            <!-- tabs content -->
        </div>
    {/if}
</div>