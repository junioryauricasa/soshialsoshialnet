<div class="row">
    <div class="col-sm-4">
        <div class="stat-panel">
            <div class="stat-cell">
                <i class="fa fa-user bg-icon"></i>
                <span class="text-xlg">{$insights['users']}</span><br>
                <span class="text-bg">{__("Users")}</span><br>
                <a href="{$system.system_url}/admin/users">{__("Manage Users")}</a>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="stat-panel">
            <div class="stat-cell">
                <i class="fa fa-male bg-icon"></i>
                <span class="text-xlg">{$insights['users_males']}</span><br>
                <span>{$insights['users_males_percent']}%</span><br>
                <span class="text-bg">{__("Males")}</span><br>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="stat-panel">
            <div class="stat-cell">
                <i class="fa fa-female bg-icon"></i>
                <span class="text-xlg">{$insights['users_females']}</span><br>
                <span>{$insights['users_females_percent']}%</span><br>
                <span class="text-bg">{__("Females")}</span><br>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-sm-4">
        <div class="stat-panel danger">
            <div class="stat-cell">
                <i class="fa fa-minus-circle bg-icon"></i>
                <span class="text-xlg">{$insights['banned']}</span><br>
                <span class="text-bg">{__("Banned")}</span><br>
                <a href="{$system.system_url}/admin/users/banned">{__("Manage Banned")}</a>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="stat-panel warning">
            <div class="stat-cell">
                <i class="fa fa-envelope bg-icon"></i>
                <span class="text-xlg">{$insights['not_activated']}</span><br>
                <span class="text-bg">{__("Not Activated")}</span><br>
                <a href="{$system.system_url}/admin/users">{__("Manage Users")}</a>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="stat-panel info">
            <div class="stat-cell">
                <i class="fa fa-clock-o bg-icon"></i>
                <span class="text-xlg">{$insights['online']}</span><br>
                <span class="text-bg">{__("Online")}</span><br>
                <a href="{$system.system_url}/admin/users/online">{__("Manage Online")}</a>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-sm-6">
        <div class="stat-panel success">
            <div class="stat-cell">
                <i class="fa fa-newspaper-o bg-icon"></i>
                <span class="text-xlg">{$insights['posts']}</span><br>
                <span class="text-bg">{__("Posts")}</span><br>
                <a href="{$system.system_url}/admin/reports">{__("Manage Reports")}</a>
            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="stat-panel success">
            <div class="stat-cell">
                <i class="fa fa-comments bg-icon"></i>
                <span class="text-xlg">{$insights['comments']}</span><br>
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
                <span class="text-xlg">{$insights['pages']}</span><br>
                <span class="text-bg">{__("Pages")}</span><br>
                <a href="{$system.system_url}/admin/pages">{__("Manage Pages")}</a>
            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="stat-panel">
            <div class="stat-cell">
                <i class="fa fa-users bg-icon"></i>
                <span class="text-xlg">{$insights['groups']}</span><br>
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
                <span class="text-xlg">{$insights['messages']}</span><br>
                <span class="text-bg">{__("Messages")}</span><br>
            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="stat-panel info">
            <div class="stat-cell">
                <i class="fa fa-globe bg-icon"></i>
                <span class="text-xlg">{$insights['notifications']}</span><br>
                <span class="text-bg">{__("Notifications")}</span><br>
            </div>
        </div>
    </div>
</div>