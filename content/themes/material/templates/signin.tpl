{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <h3 class="mb20 text-center">{__("Login")}</h3>

            {if $highlight}
            <div class="alert alert-warning" role="alert">{$highlight}</div>
            {/if}
            
            {if $system['social_login_enabled']}
                {if $system['facebook_login_enabled'] || $system['twitter_login_enabled'] || $system['google_login_enabled']}
                    <div class="mb20">
                        {if $system['facebook_login_enabled']}
                        <a href="{$system['system_url']}/connect/facebook" class="btn btn-block btn-social btn-facebook">
                            <i class="fa fa-facebook"></i> {__("Login with")} {__("Facebook")}
                        </a>
                        {/if}
                        {if $system['twitter_login_enabled']}
                        <a href="{$system['system_url']}/connect/twitter" class="btn btn-block btn-social btn-twitter">
                            <i class="fa fa-twitter"></i> {__("Login with")} {__("Twitter")}
                        </a>
                        {/if}
                        {if $system['google_login_enabled']}
                        <a href="{$system['system_url']}/connect/google" class="btn btn-block btn-social btn-google">
                            <i class="fa fa-google"></i> {__("Login with")} {__("Google")}
                        </a>
                        {/if}
                    </div>
                    <div class="hr-heading mb10">
                        <div class="hr-heading-text">
                            {__("or")}
                        </div>
                    </div>
                {/if}
            {/if}

            <form class="js_ajax-forms" data-url="core/signin.php">
                <div class="form-group">
                    <label for="username_email">{__("Email")} {__("or")} {__("Username")}</label>
                    <input name="username_email" id="username_email" value="{$username_email}" type="text" class="form-control" required autofocus>
                </div>
                <div class="form-group">
                    <label for="password">{__("Password")}</label>
                    <input name="password" id="password" type="password" class="form-control" required>
                </div>
                <div class="checkbox clearfix">
                    <label>
                        <input name="remember" type="checkbox"> {__("Remember me")}
                    </label>
                </div>
                <button name="submit" type="submit" class="btn btn-lg btn-primary btn-block">{__("Login")}</button>

                <!-- error -->
                <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                <!-- error -->
            </form>
            
            <div class="mt20">
                <a href="{$system.system_url}/reset">{__("Forget your password?")}</a>
            </div>

        </div>
    </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}