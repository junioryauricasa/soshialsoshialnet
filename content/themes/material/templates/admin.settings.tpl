<div class="panel panel-default">
    <div class="panel-heading with-icon">
        <i class="material-icons panel-icon">settings</i>
        <strong>{__("Settings")}</strong>
        <div class="pull-right flip">
            <small>{__("System Version")} ({$system['version']})</small>
        </div>
    </div>
    <div class="panel-body">

        <!-- tabs nav -->
        <ul class="nav nav-tabs mb20">
            <li class="active">
                <a href="#System" data-toggle="tab">
                    <strong class="pr5">{__("System")}</strong>
                </a>
            </li>
            <li>
                <a href="#Registration" data-toggle="tab">
                    <strong class="pr5">{__("Registration")}</strong>
                </a>
            </li>
            <li>
                <a href="#Emails" data-toggle="tab">
                    <strong class="pr5">{__("Emails")}</strong>
                </a>
            </li>
            <li>
                <a href="#Security" data-toggle="tab">
                    <strong class="pr5">{__("Security")}</strong>
                </a>
            </li>
            <li>
                <a href="#Limits" data-toggle="tab">
                    <strong class="pr5">{__("Limits")}</strong>
                </a>
            </li>
            <li>
                <a href="#Analytics" data-toggle="tab">
                    <strong class="pr5">{__("Analytics")}</strong>
                </a>
            </li>
        </ul>
        <!-- tabs nav -->

        <!-- tabs content -->
        <div class="tab-content">
            <!-- System -->
            <div class="tab-pane active" id="System">
                <form class="js_ajax-forms form-horizontal" data-url="admin/settings.php?edit=system">
                    <div class="form-group">
                        <label class="col-sm-3 control-label text-left">
                            {__("Website Live")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="system_live" class="onoffswitch-checkbox" id="system_live" {if $system['system_live']}checked{/if}>
                                <label class="onoffswitch-label" for="system_live"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn the entire website On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Shutdown Message")}
                        </label>
                        <div class="col-sm-9">
                            <textarea class="form-control" name="system_message" rows="3">{$system['system_message']}</textarea>
                            <span class="help-block">
                                {__("The text that is presented when the site is closed")}
                            </span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label text-left">
                            {__("Website Logo")}
                        </label>
                        <div class="col-sm-9">
                            {if $system['system_logo'] == ''}
                            <div class="x-image">
                                <button type="button" class="close x-hidden js_x-image-remover" title="{__("Remove")}">
                                    <span>×</span>
                                </button>
                                <div class="loader loader_small x-hidden"></div>
                                <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                                <input type="hidden" class="js_x-image-input" name="system_logo" value="">
                            </div>
                            {else}
                            <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$system['system_logo']}')">
                                <button type="button" class="close js_x-image-remover" title="{__("Remove")}">
                                    <span>×</span>
                                </button>
                                <div class="loader loader_small x-hidden"></div>
                                <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                                <input type="hidden" class="js_x-image-input" name="system_logo" value="{$system['system_logo']}">
                            </div>
                            {/if}
                            <span class="help-block">
                                {__("The perfect size for your logo should be (wdith: 60px & height: 46px)")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Website Title")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="system_title" value="{$system['system_title']}">
                            <span class="help-block">
                                {__("Title of your website")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Website Description")}
                        </label>
                        <div class="col-sm-9">
                            <textarea class="form-control" name="system_description" rows="3">{$system['system_description']}</textarea>
                            <span class="help-block">
                                {__("Description of your website")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Website Domain")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="system_domain" value="{$system['system_domain']}">
                            <span class="help-block">
                                {__("Like: marsesweb.com (without 'www')")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Website Path")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="system_url" value="{$system['system_url']}">
                            <span class="help-block">
                                {__("The path of your system")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Uploads Directory")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="system_uploads_directory" value="{$system['system_uploads_directory']}">
                            <span class="help-block">
                                {__("The path of uploads directory")}
                            </span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label text-left">
                            {__("Videos Enabled")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="videos_enabled" class="onoffswitch-checkbox" id="videos_enabled" {if $system['videos_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="videos_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn the videos On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label text-left">
                            {__("Games Enabled")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="games_enabled" class="onoffswitch-checkbox" id="games_enabled" {if $system['games_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="games_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn the games On and Off")}
                            </span>
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
            <!-- System -->

            <!-- Registration -->
            <div class="tab-pane" id="Registration">
                <form class="js_ajax-forms form-horizontal" data-url="admin/settings.php?edit=registration">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Registration Enabled")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="users_can_register" class="onoffswitch-checkbox" id="users_can_register" {if $system['users_can_register']}checked{/if}>
                                <label class="onoffswitch-label" for="users_can_register"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn registration On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Send Activation Email")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="email_send_activation" class="onoffswitch-checkbox" id="email_send_activation" {if $system['email_send_activation']}checked{/if}>
                                <label class="onoffswitch-label" for="email_send_activation"></label>
                            </div>
                            <span class="help-block">
                                {__("Enable/Disable activation email after registration")}
                            </span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Social Logins")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="social_login_enabled" class="onoffswitch-checkbox" id="social_login_enabled" {if $system['social_login_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="social_login_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn registration/login via social media (Facebook, Twitter and etc) On and Off")}
                            </span>
                        </div>
                    </div>

                    <!-- facebook -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Facebook Login")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="facebook_login_enabled" class="onoffswitch-checkbox" id="facebook_login_enabled" {if $system['facebook_login_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="facebook_login_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn registration/login via Facebook On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Facebook App ID")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="facebook_appid" value="{$system['facebook_appid']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Facebook App Secret")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="facebook_secret" value="{$system['facebook_secret']}">
                        </div>
                    </div>
                    <!-- facebook -->

                    <!-- twitter -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Twitter Login")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="twitter_login_enabled" class="onoffswitch-checkbox" id="twitter_login_enabled" {if $system['twitter_login_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="twitter_login_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn registration/login via Twitter On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Twitter App ID")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="twitter_appid" value="{$system['twitter_appid']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Twitter App Secret")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="twitter_secret" value="{$system['twitter_secret']}">
                        </div>
                    </div>
                    <!-- twitter -->

                    <!-- google -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Google Login")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="google_login_enabled" class="onoffswitch-checkbox" id="google_login_enabled" {if $system['google_login_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="google_login_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn registration/login via Google On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Google App ID")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="google_appid" value="{$system['google_appid']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Google App Secret")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="google_secret" value="{$system['google_secret']}">
                        </div>
                    </div>
                    <!-- google -->

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
            <!-- Registration -->

            <!-- Emails -->
            <div class="tab-pane" id="Emails">
                <form class="js_ajax-forms form-horizontal" data-url="admin/settings.php?edit=emails">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("SMTP Emails")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="email_smtp_enabled" class="onoffswitch-checkbox" id="email_smtp_enabled" {if $system['email_smtp_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="email_smtp_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Enable/Disable SMTP email system")}<br/>
                                {__("PHP mail() function will be used in case of disabled")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("SMTP Server")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email_smtp_server" value="{$system['email_smtp_server']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("SMTP Require Authentication")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="email_smtp_authentication" class="onoffswitch-checkbox" id="email_smtp_authentication" {if $system['email_smtp_authentication']}checked{/if}>
                                <label class="onoffswitch-label" for="email_smtp_authentication"></label>
                            </div>
                            <span class="help-block">
                                {__("Enable/Disable SMTP email system")}<br/>
                                {__("PHP mail() function will be used in case of disabled")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("SMTP Port")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email_smtp_port" value="{$system['email_smtp_port']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("SMTP Username")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email_smtp_username" value="{$system['email_smtp_username']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("SMTP Password")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email_smtp_password" value="{$system['email_smtp_password']}">
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
            <!-- Emails -->

            <!-- Security -->
            <div class="tab-pane" id="Security">
                <form class="js_ajax-forms form-horizontal" data-url="admin/settings.php?edit=security">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("reCAPTCHA Enabled")}
                        </label>
                        <div class="col-sm-9">
                            <div class="onoffswitch">
                                <input type="checkbox" name="reCAPTCHA_enabled" class="onoffswitch-checkbox" id="reCAPTCHA_enabled" {if $system['reCAPTCHA_enabled']}checked{/if}>
                                <label class="onoffswitch-label" for="reCAPTCHA_enabled"></label>
                            </div>
                            <span class="help-block">
                                {__("Turn reCAPTCHA On and Off")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("reCAPTCHA Site Key")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="reCAPTCHA_site_key" value="{$system['reCAPTCHA_site_key']}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("reCAPTCHA Secret Key")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="reCAPTCHA_secret_key" value="{$system['reCAPTCHA_secret_key']}">
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
            <!-- Security -->

            <!-- Limits -->
            <div class="tab-pane" id="Limits">
                <form class="js_ajax-forms form-horizontal" data-url="admin/settings.php?edit=limits">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Max profile photo size")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="max_avatar_size" value="{$system['max_avatar_size']}">
                            <span class="help-block">
                                {__("The Maximum size of profile photo")} {__("in kilobytes (1 M = 1024 KB)")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Max cover photo size")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="max_cover_size" value="{$system['max_cover_size']}">
                            <span class="help-block">
                                {__("The Maximum size of cover photo")} {__("in kilobytes (1 M = 1024 KB)")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Max upladed photo size")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="max_photo_size" value="{$system['max_photo_size']}">
                            <span class="help-block">
                                {__("The Maximum size of uploaded photo in posts")} {__("in kilobytes (1 M = 1024 KB)")}
                            </span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Max upladed video size")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="max_video_size" value="{$system['max_video_size']}">
                            <span class="help-block">
                                {__("The Maximum size of uploaded video in posts")} {__("in kilobytes (1 M = 1024 KB)")}
                            </span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Minimum Results")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="min_results" value="{$system['min_results']}">
                            <span class="help-block">
                                {__("The Min number of results per request")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Minimum Even Results")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="min_results_even" value="{$system['min_results_even']}">
                            <span class="help-block">
                                {__("The Min even number of results per request")}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Maximum Results")}
                        </label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="max_results" value="{$system['max_results']}">
                            <span class="help-block">
                                {__("The Max number of results per request")}
                            </span>
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
            <!-- Limits -->

            <!-- Analytics -->
            <div class="tab-pane" id="Analytics">
                <form class="js_ajax-forms form-horizontal" data-url="admin/settings.php?edit=analytics">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            {__("Google Analytics")}
                        </label>
                        <div class="col-sm-9">
                            <textarea class="form-control" name="google_analytics" rows="3">{$system['google_analytics']}</textarea>
                            <span class="help-block">
                                {__("Google Analytics Code")}
                            </span>
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
            <!-- Analytics -->
        </div>
        <!-- tabs content -->
    </div>
</div>