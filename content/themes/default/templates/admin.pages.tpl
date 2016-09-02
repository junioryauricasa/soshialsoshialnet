<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == "edit"}
            <div class="pull-right flip">
                <a target="_blank" href="{$system['system_url']}/pages/{$data['page_name']}" class="btn btn-info">
                    {__("Go to this page")}
                </a>
            </div>
        {/if}
        <i class="fa fa-flag pr5 panel-icon"></i>
        <strong>{__("Pages")}</strong>
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['page_title']}</strong>{/if}
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
                            <th>{__("Likes")}</th>
                            <th>{__("Verified")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td>
                                <a href="{$system['system_url']}/pages/{$row['page_name']}" target="_blank">
                                    {$row['page_id']}
                                </a>
                            </td>
                            <td class="post-avatar">
                                <a target="_blank" class="post-avatar-picture" href="{$system['system_url']}/pages/{$row['page_name']}" style="background-image:url({$row['page_picture']});">
                                </a>
                            </td>
                            <td>
                                <a href="{$system['system_url']}/pages/{$row['page_name']}" target="_blank">
                                    {$row['page_name']}
                                </a>
                            </td>
                            <td>
                                <a href="{$system['system_url']}/pages/{$row['page_name']}" target="_blank">
                                    {$row['page_title']}
                                </a>
                            </td>
                            <td>{$row['page_likes']}</td>
                            <td>
                                {if $row['page_verified']}
                                <span class="label label-success">{__("Yes")}</span>
                                {else}
                                <span class="label label-danger">{__("No")}</span>
                                {/if}
                            </td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="page" data-id="{$row['page_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/pages/edit/{$row['page_id']}" class="btn btn-xs btn-primary">
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
                    <img class="img-responsive img-thumbnail" src="{$data['page_picture']}">
                </div>
                <div class="col-xs-12 col-sm-10 mb10">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <span class="badge">{$data['page_id']}</span>
                            {__("Page ID")}
                        </li>
                        <li class="list-group-item">
                            <span class="badge">{$data['page_likes']}</span>
                            {__("Likes")}
                        </li>
                    </ul>
                </div>
            </div>
            <!-- tabs nav -->
            <ul class="nav nav-tabs mb20">
                <li class="active">
                    <a href="#basic" data-toggle="tab">
                        <strong class="pr5">{__("Page Info")}</strong>
                    </a>
                </li>
            </ul>
            <!-- tabs nav -->

            <!-- tabs content -->
            <div class="tab-content">
                <!-- basic tab -->
                <div class="tab-pane active" id="basic">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/page.php?id={$data['page_id']}">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Verified Page")}
                            </label>
                            <div class="col-sm-9">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="page_verified" class="onoffswitch-checkbox" id="page_verified" {if $data['page_verified']}checked{/if}>
                                    <label class="onoffswitch-label" for="page_verified"></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Category")}
                            </label>
                            <div class="col-sm-9">
                                <select class="form-control" name="page_category">
                                    {foreach $data['categories'] as $category}
                                        <option {if $data['page_category'] == $category['category_id']}selected{/if} value="{$category['category_id']}">{$category['category_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Title")}
                            </label>
                            <div class="col-sm-9">
                                <input class="form-control" name="page_title" value="{$data['page_title']}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Username")}
                            </label>
                            <div class="col-sm-9">
                                <input class="form-control" name="page_name" value="{$data['page_name']}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Username")}
                            </label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="page_description">{$data['page_description']}</textarea>
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