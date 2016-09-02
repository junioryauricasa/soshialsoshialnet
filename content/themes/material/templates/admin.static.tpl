<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == ""}
            <div class="pull-right flip">
                <a href="{$system['system_url']}/admin/static/add" class="btn btn-primary">
                    <i class="fa fa-plus"></i> {__("Add New Page")}
                </a>
            </div>
        {/if}
        <i class="material-icons panel-icon">description</i>
        <strong>{__("Static Pages")}</strong>
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['page_title']}</strong>{/if}
        {if $sub_view == "add"} &rsaquo; <strong>{__('Add New')}</strong>{/if}
    </div>
    {if $sub_view == ""}
        <div class="panel-body with-table">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover js_dataTable">
                    <thead>
                        <tr>
                            <th>{__("ID")}</th>
                            <th>{__("Page URL")}</th>
                            <th>{__("Page Title")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td>{$row['page_id']}</td>
                            <td>
                                <a target="_blank" href="{$system['system_url']}/static/{$row['page_url']}">
                                    {$row['page_url']}
                                </a>
                            </td>
                            <td>{$row['page_title']}</td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="static" data-id="{$row['page_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/static/edit/{$row['page_id']}" class="btn btn-xs btn-primary">
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/static.php?do=edit&id={$data['page_id']}">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("URL")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="page_url" value="{$data['page_url']}">
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
                        {__("HTML")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="page_text" rows="8">{$data['page_text']}</textarea>
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/static.php?do=add">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("URL")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="page_url">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Title")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="page_title">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("HTML")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="page_text" rows="8"></textarea>
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