{include file='_head.tpl'}
{include file='_header.tpl'}


<!-- page content -->
<div class="container mt20">
    <div class="row">

        <div class="col-md-3 col-sm-3">
            <div class="panel panel-default">
                <div class="panel-body with-nav">
                    <ul class="side-nav metismenu js_metisMenu">

                        <!-- Dashboard -->
                        <li {if $view == ""}class="active selected"{/if}>
                            <a href="{$system['system_url']}/admin">
                                <i class="material-icons">cloud</i> {__("Dashboard")}
                            </a>
                        </li>
                        <!-- Dashboard -->

                        <!-- Settings -->
                        <li {if $view == "settings"}class="active selected"{/if}>
                            <a href="{$system['system_url']}/admin/settings">
                                <i class="material-icons">settings</i> {__("Settings")}
                            </a>
                        </li>
                        <!-- Settings -->

                        <!-- Languages -->
                        <li {if $view == "languages"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/languages">
                                <i class="material-icons">language</i> {__("Languages")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "languages" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/languages">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "languages" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/languages/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Languages -->

                        <!-- Themes -->
                        <li {if $view == "themes"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/themes">
                                <i class="material-icons">palette</i> {__("Themes")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "themes" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/themes">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "themes" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/themes/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Themes -->
                        
                        <!-- Users -->
                        <li {if $view == "users"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/users">
                                <i class="material-icons">person</i> {__("Users")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "users" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/users">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Show All Users")}
                                    </a>
                                </li>
                                <li {if $view == "users" && $sub_view == "admins"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/users/admins">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("List Admins")}
                                    </a>
                                </li>
                                <li {if $view == "users" && $sub_view == "moderators"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/users/moderators">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("List Moderators")}
                                    </a>
                                </li>
                                <li {if $view == "users" && $sub_view == "online"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/users/online">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("List Online")}
                                    </a>
                                </li>
                                <li {if $view == "users" && $sub_view == "banned"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/users/banned">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("List Banned")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Users -->

                        <!-- Pages -->
                        <li {if $view == "pages"}class="active selected"{/if}>
                            <a href="{$system['system_url']}/admin/pages">
                                <i class="material-icons">pages</i> {__("Pages")}
                            </a>
                        </li>
                        <!-- Pages -->

                        <!-- Pages Categories -->
                        <li {if $view == "categories"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/categories">
                                <i class="material-icons">dvr</i> {__("Pages Categories")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "categories" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/categories">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "categories" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/categories/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Pages Categories -->

                        <!-- Groups -->
                        <li {if $view == "groups"}class="active selected"{/if}>
                            <a href="{$system['system_url']}/admin/groups">
                                <i class="material-icons">group_work</i> {__("Groups")}
                            </a>
                        </li>
                        <!-- Groups -->

                        <!-- Verify Badge -->
                        <li {if $view == "verified"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/verified/users">
                                <i class="material-icons">check_circle</i> {__("Verify Badge")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "verified" && $sub_view == "users"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/verified/users">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("List Users")}
                                    </a>
                                </li>
                                <li {if $view == "verified" && $sub_view == "pages"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/verified/pages">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("List Pages")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Verify Badge -->
                        
                        <!-- Reports -->
                        <li {if $view == "reports"}class="active selected"{/if}>
                            <a href="{$system['system_url']}/admin/reports">
                                <i class="material-icons">report</i> {__("Reports")}
                            </a>
                        </li>
                        <!-- Reports -->

                        <!-- Static Pages -->
                        <li {if $view == "static"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/static">
                                <i class="material-icons">description</i> {__("Static Pages")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "static" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/static">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "static" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/static/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Static Pages -->
                        
                        <!-- Ads -->
                        <li {if $view == "ads"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/ads">
                                <i class="material-icons">attach_money</i> {__("Ads")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "ads" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/ads">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "ads" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/ads/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Ads -->

                        <!-- Widgets -->
                        <li {if $view == "widgets"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/widgets">
                                <i class="material-icons">extension</i> {__("Widgets")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "widgets" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/widgets">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "widgets" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/widgets/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Widgets -->

                        <!-- Games -->
                        <li {if $view == "games"}class="active"{/if}>
                            <a href="{$system['system_url']}/admin/games">
                                <i class="material-icons">videogame_asset</i> {__("games")}
                                <span class="fa arrow"></span>
                            </a>
                            <ul>
                                <li {if $view == "games" && $sub_view == ""}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/games">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Lists")}
                                    </a>
                                </li>
                                <li {if $view == "games" && $sub_view == "add"}class="active selected"{/if}>
                                    <a href="{$system['system_url']}/admin/games/add">
                                        <i class="fa fa-caret-right fa-fw pr10"></i>{__("Add New")}
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Games -->

                        <!-- Newsletter -->
                        <!--<li {if $view == "newsletter"}class="active selected"{/if}>
                            <a href="{$system['system_url']}/admin/newsletter">
                                <i class="fa fa-envelope fa-fw fa-lg pr10"></i>{__("Newsletter")}
                            </a>
                        </li>-->
                        <!-- Newsletter -->
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-9 col-sm-9">

            {if $view == ""}
            {include file='admin.dashboard.tpl'}

            {elseif $view == "settings"}
            {include file='admin.settings.tpl'}

            {elseif $view == "languages"}
            {include file='admin.languages.tpl'}

            {elseif $view == "themes"}
            {include file='admin.themes.tpl'}

            {elseif $view == "users"}
            {include file='admin.users.tpl'}

            {elseif $view == "pages"}
            {include file='admin.pages.tpl'}
            
            {elseif $view == "categories"}
            {include file='admin.categories.tpl'}

            {elseif $view == "groups"}
            {include file='admin.groups.tpl'}

            {elseif $view == "verified"}
            {include file='admin.verified.tpl'}
            
            {elseif $view == "reports"}
            {include file='admin.reports.tpl'}

            {elseif $view == "static"}
            {include file='admin.static.tpl'}

            {elseif $view == "ads"}
            {include file='admin.ads.tpl'}

            {elseif $view == "widgets"}
            {include file='admin.widgets.tpl'}

            {elseif $view == "games"}
            {include file='admin.games.tpl'}
                
            {/if}

        </div>
        
    </div>
</div>
<!-- page content -->


{include file='_footer.tpl'}