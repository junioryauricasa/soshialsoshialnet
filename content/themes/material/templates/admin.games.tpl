<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == ""}
            <div class="pull-right flip">
                <a href="{$system['system_url']}/admin/games/add" class="btn btn-primary">
                    <i class="fa fa-plus"></i> {__("Add New game")}
                </a>
            </div>
        {/if}
        <i class="material-icons panel-icon">videogame_asset</i>
        <strong>{__("Games")}</strong>
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
                            <th>{__("Thumbnail")}</th>
                            <th>{__("Name")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td>{$row['game_id']}</td>
                            <td>
                                <a target="_blank" class="x-image sm" href="{$system['system_url']}/games/{$row['game_id']}" style="background-image:url({$row['thumbnail']});">
                                </a>
                            </td>
                            <td>
                                <a target="_blank"href="{$system['system_url']}/games/{$row['game_id']}">
                                    {$row['title']}
                                </a>
                            </td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="game" data-id="{$row['game_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/games/edit/{$row['game_id']}" class="btn btn-xs btn-primary">
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/games.php?do=edit&id={$data['game_id']}">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Name")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="title" value="{$data['title']}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Description")}
                    </label>
                    <div class="col-sm-9">
                        <textarea rows="5" class="form-control" name="description">{$data['description']}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Game Source")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="source">{$data['source']}</textarea>
                        <span class="help-block">
                        {__("The source link of your embedded game")}
                    </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Thumbnail")}
                    </label>
                    <div class="col-sm-9">
                        {if $data['thumbnail'] == ''}
                            <div class="x-image">
                                <button type="button" class="close x-hidden js_x-image-remover" title="{__("Remove")}">
                                    <span>×</span>
                                </button>
                                <div class="loader loader_small x-hidden"></div>
                                <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                                <input type="hidden" class="js_x-image-input" name="thumbnail" value="">
                            </div>
                        {else}
                            <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$data['thumbnail']}')">
                                <button type="button" class="close js_x-image-remover" title="{__("Remove")}">
                                    <span>×</span>
                                </button>
                                <div class="loader loader_small x-hidden"></div>
                                <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                                <input type="hidden" class="js_x-image-input" name="thumbnail" value="{$data['thumbnail']}">
                            </div>
                        {/if}
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
            <form class="js_ajax-forms form-horizontal" data-url="admin/games.php?do=add">
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Name")}
                    </label>
                    <div class="col-sm-9">
                        <input class="form-control" name="title">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Description")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="description"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Game Source")}
                    </label>
                    <div class="col-sm-9">
                        <textarea class="form-control" name="source"></textarea>
                        <span class="help-block">
                        {__("The source link of your embedded game")}
                    </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label text-left">
                        {__("Thumbnail")}
                    </label>
                    <div class="col-sm-9">
                        <div class="x-image">
                            <button type="button" class="close x-hidden js_x-image-remover" title="{__("Remove")}">
                                <span>×</span>
                            </button>
                            <div class="loader loader_small x-hidden"></div>
                            <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                            <input type="hidden" class="js_x-image-input" name="thumbnail" value="">
                        </div>
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