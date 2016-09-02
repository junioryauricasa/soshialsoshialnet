{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <h3 class="mb20 text-center">{__("Welcome")} {$user_profile->displayName}</h3>

            <div class="text-center">
                <img class="img-thumbnail" src="{$user_profile->photoURL}" width="99" height="99">
            </div>
            
            <form class="js_ajax-forms" data-url="core/signup_social.php">
                <div class="form-group">
                    <label for="full_name">{__("Full name")}</label>
                    <input value="{$user_profile->displayName}" name="full_name" id="full_name" type="text" class="form-control" required autofocus>
                </div>
                <div class="form-group">
                    <label for="username">{__("Username")}</label>
                    <input name="username" id="username" type="text" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="email">{__("Email")}</label>
                    <input value="{$user_profile->email}" name="email" id="email" type="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">{__("Password")}</label>
                    <input name="password" id="password" type="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="gender">{__("I am")}</label>
                    <select name="gender" id="gender" class="form-control" required>
                        <option value="none">{__("Select Sex")}:</option>
                        <option {if $user_profile->gender == "male"}selected{/if} value="Male">{__("Male")}</option>
                        <option {if $user_profile->gender == "female"}selected{/if} value="Female">{__("Female")}</option>
                    </select>
                </div>
                <p class="text-muted">
                    {__("By clicking Sign Up, you agree to our")} <a href="#">{__("Terms")}</a>
                </p>
                <input value="{$user_profile->photoURL}" name="avatar" type="hidden">
                <input value="{$provider}" name="provider" type="hidden">
                <button type="submit" class="btn btn-lg btn-success btn-block">{__("Sign Up")}</button>

                <!-- error -->
                <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                <!-- error -->
            </form>

        </div>

    </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}