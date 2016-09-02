<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == ""}
            <div class="pull-right flip">
                <a href="{$system['system_url']}/admin/themes/add" class="btn btn-primary">
                    <i class="fa fa-plus"></i> {__("Add New Theme")}
                </a>
            </div>
        {/if}
        <i class="material-icons panel-icon">palette</i>
        <strong>{__("Themes")}</strong>
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['name']}</strong>{/if}
        {if $sub_view == "add"} &rsaquo; <strong>{__('Add New')}</strong>{/if}
    </div>
    {if $sub_view == ""}
        <div class="panel-body with-table">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover js_dataTable">
                    <thead>
                        <tr>
                            <th>{__("ID")}</th>
                            <th>{__("Thumbnail")}</th>
                            <th>{__("Name")}</th>
                            <th>{__("Default")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td>{$row['theme_id']}</td>
                            <td>
                                <img width="210" src="{$system['system_url']}/content/themes/{$row['name']}/thumbnail.png">
                            </td>
                            <td>{$row['name']}</td>
                            <td>
                                {if $row['default']}
                                    <span class="label label-success">{__("Yes")}</span>
                                {else}
                                    <span class="label label-danger">{__("No")}</span>
                                {/if}
                            </td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="theme" data-id="{$row['theme_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/themes/edit/{$row['theme_id']}" class="btn btn-xs btn-primary">
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/theme.php?do=edit&id={$data['theme_id']}">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Default")}
                    </label>
                    <div class="col-sm-9">
                        <div class="onoffswitch">
                            <input type="checkbox" name="default" class="onoffswitch-checkbox" id="default" {if $data['default']}checked{/if}>
                            <label class="onoffswitch-label" for="default"></label>
                        </div>
                        <span class="help-block">
                            {__("Make it the default theme of the site")}
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Name")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="name" value="{$data['name']}">
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
    {elseif $sub_view == "add"}
        <div class="panel-body">
            <form class="js_ajax-forms form-horizontal" data-url="admin/theme.php?do=add">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Default")}
                    </label>
                    <div class="col-sm-9">
                        <div class="onoffswitch">
                            <input type="checkbox" name="default" class="onoffswitch-checkbox" id="default">
                            <label class="onoffswitch-label" for="default"></label>
                        </div>
                        <span class="help-block">
                            {__("Make it the default theme of the site")}
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Name")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="name">
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
    {/if}
</div>