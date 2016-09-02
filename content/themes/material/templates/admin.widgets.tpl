<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == ""}
            <div class="pull-right flip">
                <a href="{$system['system_url']}/admin/widgets/add" class="btn btn-primary">
                    <i class="fa fa-plus"></i> {__("Add New widget")}
                </a>
            </div>
        {/if}
        <i class="material-icons panel-icon">extension</i>
        <strong>{__("Widgets")}</strong>
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['title']}</strong>{/if}
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
                            <th>{__("Place")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td>{$row['widget_id']}</td>
                            <td>{$row['title']}</td>
                            <td>
                                {if $row['place'] == "home"}{__("Home Page")}{/if}
                                {if $row['place'] == "requests"}{__("Friends Requests Page")}{/if}
                                {if $row['place'] == "notifications"}{__("Notifications Page")}{/if}
                                {if $row['place'] == "post"}{__("Post Page")}{/if}
                                {if $row['place'] == "photo"}{__("Photo Page")}{/if}
                            </td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="widget" data-id="{$row['widget_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/widgets/edit/{$row['widget_id']}" class="btn btn-xs btn-primary">
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/widgets.php?do=edit&id={$data['widget_id']}">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Title")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="title" value="{$data['title']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Place")}
                    </label>
                    <div class="col-sm-9">
                        <select class="form-control" name="place">
                            <option {if $data['place'] == "home"}selected{/if} value="home">{__("Home Page")}</option>
                            <option {if $data['place'] == "requests"}selected{/if} value="requests">{__("Friends Requests Page")}</option>
                            <option {if $data['place'] == "notifications"}selected{/if} value="notifications">{__("Notifications Page")}</option>
                            <option {if $data['place'] == "post"}selected{/if} value="post">{__("Post Page")}</option>
                            <option {if $data['place'] == "photo"}selected{/if} value="photo">{__("Photo Page")}</option>
                        </select>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("HTML")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="code" rows="8">{$data['code']}</textarea>
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
            <div class="alert alert-warning">
                <i class="fa fa-exclamation-triangle fa-lg"></i>
                {__("When you add mutiple widgets at the samle location, they will be displayed randomly")}
            </div>
            <form class="js_ajax-forms form-horizontal" data-url="admin/widgets.php?do=add">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Title")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="title">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Place")}
                    </label>
                    <div class="col-sm-9">
                        <select class="form-control" name="place">
                            <option value="home">{__("Home Page")}</option>
                            <option value="requests">{__("Friends Requests Page")}</option>
                            <option value="notifications">{__("Notifications Page")}</option>
                            <option value="post">{__("Post Page")}</option>
                            <option value="photo">{__("Photo Page")}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("HTML")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="code" rows="8"></textarea>
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