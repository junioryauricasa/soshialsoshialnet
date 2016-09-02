<body 
{if !$user->_logged_in}
    class="visitor"
{elseif $system['email_send_activation'] && !$user->_data['user_activated']}
    class="n_activated"
{elseif !$system['system_live']}
    class="n_live"
{/if}
{if $user->_logged_in}
    data-chat-enabled={$user->_data['user_chat_enabled']}
{/if}
>
    
    <!-- main wrapper -->
    <div class="main-wrapper">
        
        {if $user->_logged_in && $system['email_send_activation'] && !$user->_data['user_activated']}
        <!-- top-bar -->
        <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-7 hidden-xs">
                        {__("Please go to")} <span class="text-primary">{$user->_data['user_email']}</span> {__("to complete the sign-up process")}.
                    </div>
                    <div class="col-xs-12 col-sm-5">
                        <span class="text-link" data-toggle="modal" data-url="core/activation_email_resend.php">
                            {__("Resend Activation Email")}
                        </span>
                         - 
                        <span class="text-link" data-toggle="modal" data-url="#activation-email-reset">
                            {__("Change Email")}
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- top-bar -->
        {/if}

        {if !$system['system_live']}
        <!-- top-bar alert-->
        <div class="top-bar alert-bar">
            <div class="container">
                <i class="fa fa-exclamation-triangle fa-lg pr5"></i>
                <span class="hidden-xs">{__("The system has been shuttd down")}.</span>
                <span>{__("Turn it on from")}</span> <a href="{$system['system_url']}/admin/settings">{__("Admin Panel")}</a>
            </div>
        </div>
        <!-- top-bar alert-->
        {/if}

        <div class="main-header">
            <div class="container header-container">
                
                <div class="brand-container {if $user->_logged_in}hidden-xs{/if}">
                    <!-- brand -->
                    <a href="{$system['system_url']}" class="brand">
                        {if $system['system_logo']}
                            <img width="60" src="{$system['system_uploads']}/{$system['system_logo']}" alt="{$system['system_title']}" title="{$system['system_title']}">
                        {else}
                            {$system['system_title']}
                        {/if}
                    </a>
                    <!-- brand -->
                </div>

                <!-- navbar-collapse -->
                <div>
                    {if $user->_logged_in}
                        
                        <!-- search -->
                        {include file='_header.search.tpl'}
                        <!-- search -->

                        <!-- navbar-container -->
                        <div class="navbar-container">
                            <ul class="nav navbar-nav">
                                
                                {if $user->_is_admin}
                                <!-- admin panel -->
                                <li class="is-admin">
                                    <a href="{$system['system_url']}/admin">
                                        <i class="fa fa-tachometer fa-lg"></i>
                                    </a>
                                </li>
                                <!-- admin panel -->
                                {/if}

                                <!-- home -->
                                <li {if $user->_is_admin}class="is-admin"{/if}>
                                    <a href="{$system['system_url']}">
                                        <i class="fa fa-home fa-lg"></i>
                                    </a>
                                </li>
                                <!-- home -->
                                
                                <!-- friend requests -->
                                {include file='_header.friend_requests.tpl'}
                                <!-- friend requests -->

                                <!-- messages -->
                                {include file='_header.messages.tpl'}
                                <!-- messages -->

                                <!-- notifications -->
                                {include file='_header.notifications.tpl'}
                                <!-- notifications -->

                                <!-- search -->
                                <li class="visible-xs-block {if $user->_is_admin}is-admin{/if}">
                                    <a href="{$system['system_url']}/search">
                                        <i class="fa fa-search fa-lg"></i>
                                    </a>
                                </li>
                                <!-- search -->

                                <!-- user-menu -->
                                <li class="dropdown {if $user->_is_admin}is-admin{/if}">
                                    <a href="{$system['system_url']}/{$user->_data['user_name']}" class="dropdown-toggle user-menu" data-toggle="dropdown">
                                        <img src="{$user->_data['user_picture']}" alt="">
                                        <span class="hidden-xs">{$user->_data['user_fullname']}</span>
                                        <i class="caret"></i>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="{$system['system_url']}/{$user->_data['user_name']}">{__("Profile")}</a>
                                        </li>
                                        <li>
                                            <a href="{$system['system_url']}/settings">{__("Settings")}</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="{$system['system_url']}/create/page">{__("Create Page")}</a>
                                        </li>
                                        <li>
                                            <a href="{$system['system_url']}/pages">{__("Manage Pages")}</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="{$system['system_url']}/create/group">{__("Create Group")}</a>
                                        </li>
                                        <li>
                                            <a href="{$system['system_url']}/groups">{__("Manage Groups")}</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="{$system['system_url']}/signout">{__("Log Out")}</a>
                                        </li>
                                    </ul>
                                </li>
                                <!-- user-menu -->
                            </ul>
                        </div>
                        <!-- navbar-container -->
                        
                    {/if}
                </div>
                <!-- navbar-collapse -->

            </div>
        </div>