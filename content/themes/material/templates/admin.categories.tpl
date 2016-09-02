<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == ""}
            <div class="pull-right flip">
                <a href="{$system['system_url']}/admin/categories/add" class="btn btn-primary">
                    <i class="fa fa-plus"></i> {__("Add New category")}
                </a>
            </div>
        {/if}
        <i class="material-icons panel-icon">dvr</i>
        <strong>{__("Categories")}</strong>
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['category_name']}</strong>{/if}
        {if $sub_view == "add"} &rsaquo; <strong>{__('Add New')}</strong>{/if}
    </div>
    {if $sub_view == ""}
        <div class="panel-body with-table">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover js_dataTable">
                    <thead>
                        <tr>
                            <th>{__("ID")}</th>
                            <th>{__("Title")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td>{$row['category_id']}</td>
                            <td>{$row['category_name']}</td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="category" data-id="{$row['category_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/categories/edit/{$row['category_id']}" class="btn btn-xs btn-primary">
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/category.php?do=edit&id={$data['category_id']}">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Name")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="category_name" value="{$data['category_name']}">
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/category.php?do=add">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Name")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="category_name">
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