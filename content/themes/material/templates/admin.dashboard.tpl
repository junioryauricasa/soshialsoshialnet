<div class="panel panel-default">
    <div class="panel-heading with-icon">
        <i class="material-icons panel-icon">cloud</i>
        <strong>{__("Dashboard")}</strong>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-7">
                <div class="panel panel-primary">
                    <div class="panel-heading text-center"><strong>{__("Usuarios nuevos de la semana pasada")}</strong></div>
                    <div class="panel-body">
                        <div>
                            <canvas class="dashboard-status" id="dashboard-users"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-5">
                <div class="panel panel-primary">
                    <div class="panel-heading text-center"><strong>{__("Estatus de los usuarios")}</strong></div>
                    <div class="list-group">
                        <a class="list-group-item" href="{$system.system_url}/admin/users/online">
                            <span class="badge dashboard-user-status-online">{$insights['online']}</span>
                            <i class="fa fa-wifi"></i> {__("Online")}
                        </a>
                        <a class="list-group-item" href="{$system.system_url}/admin/users">
                            <span class="badge dashboard-user-status-users">{$insights['users']}</span>
                            <i class="fa fa-user"></i> {__("Users")}
                        </a>
                        <a class="list-group-item">
                            <span class="badge dashboard-user-status-males">{$insights['males']}</span>
                            <i class="fa fa-male"></i> {__("Males")}
                        </a>
                        <a class="list-group-item">
                            <span class="badge dashboard-user-status-females">{$insights['females']}</span>
                            <i class="fa fa-female"></i> {__("Females")}
                        </a>
                        <a class="list-group-item" href="{$system.system_url}/admin/users/banned">
                            <span class="badge dashboard-user-status-baned">{$insights['banned']}</span>
                            <i class="fa fa-minus-circle"></i> {__("Banned")}
                        </a>
                        <a class="list-group-item" href="{$system.system_url}/admin/users">
                            <span class="badge dashboard-user-status-not_activate">{$insights['not_activated']}</span>
                            <i class="fa fa-envelope"></i> {__("Not Activated")}
                        </a>
                    </div>
                </div>
                
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6">
                <div class="stat-panel success">
                    <div class="stat-cell">
                        <i class="fa fa-newspaper-o bg-icon"></i>
                        <span class="text-xlg dashboard-user-status-posts">{$insights['posts']}</span><br>
                        <span class="text-bg">{__("Posts")}</span><br>
                        <a href="{$system.system_url}/admin/reports">{__("Manage Reports")}</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="stat-panel success">
                    <div class="stat-cell">
                        <i class="fa fa-comments bg-icon"></i>
                        <span class="text-xlg dashboard-user-status-comments">{$insights['comments']}</span><br>
                        <span class="text-bg">{__("Comments")}</span><br>
                        <a href="{$system.system_url}/admin/reports">{__("Manage Reports")}</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="stat-panel">
                    <div class="stat-cell">
                        <i class="fa fa-flag bg-icon"></i>
                        <span class="text-xlg dashboard-user-status-pages">{$insights['pages']}</span><br>
                        <span class="text-bg">{__("Pages")}</span><br>
                        <a href="{$system.system_url}/admin/pages">{__("Manage Pages")}</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="stat-panel">
                    <div class="stat-cell">
                        <i class="fa fa-users bg-icon"></i>
                        <span class="text-xlg dashboard-user-status-groups">{$insights['groups']}</span><br>
                        <span class="text-bg">{__("Groups")}</span><br>
                        <a href="{$system.system_url}/admin/groups">{__("Manage Groups")}</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="stat-panel info">
                    <div class="stat-cell">
                        <i class="fa fa-comments-o bg-icon"></i>
                        <span class="text-xlg dashboard-user-status-messages">{$insights['messages']}</span><br>
                        <span class="text-bg">{__("Messages")}</span><br>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="stat-panel info">
                    <div class="stat-cell">
                        <i class="fa fa-globe bg-icon"></i>
                        <span class="text-xlg dashboard-user-status-notifications">{$insights['notifications']}</span><br>
                        <span class="text-bg">{__("Notifications")}</span><br>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>