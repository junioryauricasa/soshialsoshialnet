<div class="panel panel-default">
    <div class="panel-heading with-icon">
        <i class="material-icons panel-icon">report</i>
        <strong>{__("Reports")}</strong>
    </div>
    <div class="panel-body with-table">
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover js_dataTable">
                <thead>
                    <tr>
                        <th>{__("ID")}</th>
                        <th>{__("Reporter Picture")}</th>
                        <th>{__("Reporter Name")}</th>
                        <th>{__("Node")}</th>
                        <th>{__("Time")}</th>
                        <th>{__("Actions")}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $rows as $row}
                    <tr>
                        <td>{$row['report_id']}</td>
                        <td>
                            <a target="_blank" class="x-image sm" href="{$system['system_url']}/{$row['user_name']}" style="background-image:url({$row['user_picture']});">
                            </a>
                        </td>
                        <td>
                            <a href="{$system['system_url']}/{$row['user_name']}" target="_blank">
                                {$row['user_fullname']}
                            </a>
                        </td>
                        <td>
                            {$row['node_type']|capitalize}<br>
                        </td>
                        <td>{$row['time']|date_format:"%e %B %Y"}</td>
                        <td>
                            {if $row['node_type'] == "user"}
                                <a href="{$system['system_url']}/admin/users/edit/{$row.user_id}" class="btn btn-xs btn-primary">
                                    <i class="fa fa-pencil"></i>
                                </a>
                            {elseif $row['node_type'] == "post"}
                                <a class="btn btn-xs btn-info js_open_window" href="{$system['system_url']}/posts/{$row['node_id']}" target="_blank">
                                    <i class="fa fa-search"></i>
                                </a>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="post" data-node="{$row['node_id']}" data-id="{$row['report_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                            {elseif $row['node_type'] == "comment"}
                                <a class="btn btn-xs btn-info js_open_window" href="{$row['url']}" target="_blank">
                                    <i class="fa fa-search"></i>
                                </a>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="comment" data-node="{$row['node_id']}" data-id="{$row['report_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                            {/if}
                            <button class="btn btn-xs btn-warning js_admin-deleter" data-handle="report" data-id="{$row['report_id']}">
                                <i class="fa fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>