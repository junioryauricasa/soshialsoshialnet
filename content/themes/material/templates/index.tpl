{include file='_head.tpl'}
{include file='_header.tpl'}

{if !$user->_logged_in}

<!-- page content -->
<div class="container index-container">
    <div class="panel panel-default">
        <div class="panel-body">
            <h1>{$system.system_title}</h1>
            <form class="js_ajax-forms" data-url="core/signin.php">
                <div class="form-group">
                    <input name="username_email" type="text" class="form-control" placeholder="{__("Email")} {__("or")} {__("Username")}" required>
                </div>
                <div class="form-group">
                    <input name="password" type="password" class="form-control" placeholder="{__("Password")}" required>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> {__("Remember me")}
                    </label>
                    | <a href="{$system['system_url']}/reset">{__("Forget your password?")}</a>
                </div>
                <button type="submit" class="btn btn-block btn-primary">{__("Login")}</button>
                
                <!-- error -->
                <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                <!-- error -->
            </form>
            <hr>
            <button type="button" class="btn btn-block btn-success" data-toggle="modal" data-target="#signupModal">{__("New to")} {$system.system_title}! {__("Sign up")}</button>
            {if $system['social_login_enabled']}
                {if $system['facebook_login_enabled'] || $system['twitter_login_enabled'] || $system['google_login_enabled']}
                    <div class="hr-heading mt5 mb10">
                        <div class="hr-heading-text">
                            {__("or")} {__("login with")}
                        </div>
                    </div>
                    <div class="text-center">
                        {if $system['facebook_login_enabled']}
                        <a href="{$system['system_url']}/connect/facebook" class="btn btn-social-icon btn-facebook">
                            <i class="fa fa-facebook"></i>
                        </a>
                        {/if}
                        {if $system['twitter_login_enabled']}
                        <a href="{$system['system_url']}/connect/twitter" class="btn btn-social-icon btn-twitter">
                            <i class="fa fa-twitter"></i>
                        </a>
                        {/if}
                        {if $system['google_login_enabled']}
                        <a href="{$system['system_url']}/connect/google" class="btn btn-social-icon btn-google">
                            <i class="fa fa-google"></i>
                        </a>
                        {/if}
                    </div>
                {/if}
            {/if}
        </div>
    </div>
</div>

<div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Cancelar"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">{$system.system_title}! {__("Sign up")}</h4>
      </div>
      <form class="js_ajax-forms" data-url="core/signup.php">
        <div class="modal-body">
        
            <div class="form-group">
                <input name="full_name" type="text" class="form-control" placeholder="{__("Full name")}" required>
            </div>
            <div class="form-group">
                <input name="username" type="text" class="form-control" placeholder="{__("Username")}" required>
            </div>
            <div class="form-group">
                <input name="email" type="email" class="form-control" placeholder="{__("Email")}" required>
            </div>
            <div class="form-group">
                <input name="password" type="password" class="form-control" placeholder="{__("Password")}" required>
            </div>
            <div class="js_hidden-section x-hidden">
                <div class="form-group">
                    <label for="gender">{__("I am")}</label>
                    <select name="gender" id="gender" class="form-control" required>
                        <option value="none">{__("Select Sex")}:</option>
                        <option value="Male">{__("Male")}</option>
                        <option value="Female">{__("Female")}</option>
                    </select>
                </div>
                {if $system.reCAPTCHA_enabled}
                <div class="form-group">
                    <!-- reCAPTCHA -->
                    <script src='https://www.google.com/recaptcha/api.js'></script>
                    <div class="g-recaptcha" data-sitekey="{$system.reCAPTCHA_site_key}"></div>
                    <!-- reCAPTCHA -->
                </div>
                {/if}
                <p class="text-muted">
                    {__("By clicking Sign Up, you agree to our")} <a href="#">{__("Terms")}</a>
                </p>
            </div>

            <!-- error -->
            <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
            <!-- error -->
            
        
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-success">{__("Sign Up")}</button>
          </div>
      </form>
    </div>
  </div>
</div>

<!-- page content -->

{else}

<!-- page content -->
<div class="container mt20">
    <div class="row">

        <!-- left panel -->
        <div class="col-sm-2">
            <ul class="nav nav-pills nav-stacked nav-home hidden-xs">

                <!-- basic -->
                <li>
                    <a href="{$system['system_url']}/{$user->_data['user_name']}">
                        <img src="{$user->_data.user_picture}" alt="{$user->_data['user_fullname']}">
                        <span>{$user->_data['user_fullname']}</span>
                    </a>
                </li>
                <li>
                    <a href="{$system['system_url']}/settings/profile">
                        <i class="material-icons">border_color</i> {__("Edit Profile")}
                    </a>
                </li>
                {if $user->_data['user_group'] == 1}
                <li>
                    <a href="{$system['system_url']}/admin">
                        <i class="material-icons">cloud</i> {__("Admin Panel")}
                    </a>
                </li>
                {/if}
                <!-- basic -->

                <!-- favorites -->
                <li class="ptb5">
                    <small class="text-muted">{__("favorites")|upper}</small>
                </li>

                <li {if $view == ""}class="active"{/if}>
                    <a href="{$system['system_url']}"><i class="material-icons">style</i> {__("News Feed")}</a>
                </li>
                <li>
                    <a href="{$system['system_url']}/messages"><i class="material-icons">forum</i> {__("Messages")}</a>
                </li>
                {if $system['games_enabled']}
                <li {if $view == "games"}class="active"{/if}>
                    <a href="{$system['system_url']}/games"><i class="material-icons">videogame_asset</i> {__("Games")}</a>
                </li>
                {/if}
                <!-- favorites -->

                <!-- pages -->
                <li class="ptb5">
                    <small class="text-muted">{__("pages")|upper}</small>
                </li>

                {if count($pages) > 0}
                    {foreach $pages as $page}
                        <li>
                            <a href="{$system['system_url']}/pages/{$page['page_name']}">
                                <img src="{$page['page_picture']}" alt="">
                                <span>{$page['page_title']}</span>
                            </a>
                        </li>
                    {/foreach}
                {/if}
                        
                <li {if $view == "create_page"}class="active"{/if}>
                    <a href="{$system['system_url']}/create/page"><i class="material-icons">pages</i> {__("Create Page")}</a>
                </li>
                <li {if $view == "pages"}class="active"{/if}>
                    <a href="{$system['system_url']}/pages"><i class="material-icons">collections_bookmark</i> {__("Manage Pages")}</a>
                </li>
                <!-- pages -->

                <!-- groups -->
                <li class="ptb5">
                    <small class="text-muted">{__("groups")|upper}</small>
                </li>

                {if count($groups) > 0}
                    {foreach $groups as $group}
                        <li>
                            <a href="{$system['system_url']}/groups/{$group['group_name']}">
                                <img src="{$group['group_picture']}" alt="">
                                <span>{$group['group_title']}</span>
                            </a>
                        </li>
                    {/foreach}
                {/if}

                <li {if $view == "create_group"}class="active"{/if}>
                    <a href="{$system['system_url']}/create/group"><i class="material-icons">group_work</i> {__("Create Group")}</a>
                </li>
                <li {if $view == "groups"}class="active"{/if}>
                    <a href="{$system['system_url']}/groups"><i class="material-icons">collections_bookmark</i> {__("Manage Groups")}</a>
                </li>
                <!-- groups -->
            </ul>
        </div>
        <!-- left panel -->
        
        <!-- center panel -->
        {if $view == ""}
            <div class="col-sm-6">
                <!-- publisher -->
                {include file='_publisher.tpl' _handle="user" _privacy=true}
                <!-- publisher -->

                <!-- posts -->
                {include file='_posts.tpl' _get="newsfeed"}
                <!-- posts -->
            </div>

        {elseif $view == "search"}
            <div class="col-sm-6">
                <!-- search form -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="mt5">
                            <i class="material-icons">search</i>
                            <strong>{__("Search")}</strong>
                        </div>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal js_search-form">
                            <div class="form-group">
                                <div class="col-sm-10 mb5">
                                    <input type="text" name="query" class="form-control" placeholder="{__("Search for people, pages and #hashtags")}" required>
                                </div>
                                <div class="col-sm-2">
                                    <button type="submit" name="submit" class="btn btn-primary">{__("Search")}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- search form -->

                {if $query}
                <!-- search results -->
                <div id="search-full-results" class="panel panel-default">
                    <div class="panel-heading with-icon with-nav">
                        <!-- panel title -->
                        <div class="mb20">
                        <i class="material-icons panel-icon">line_weight</i>
                            <strong>{__("Search Results")}</strong>
                        </div>
                        <!-- panel title -->

                        <!-- panel nav -->
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#posts" data-toggle="tab">
                                    <strong class="pr5">{__("Posts")}</strong>
                                </a>
                            </li>
                            <li>
                                <a href="#users" data-toggle="tab">
                                    <strong class="pr5">{__("Users")}</strong>
                                </a>
                            </li>
                            <li>
                                <a href="#pages" data-toggle="tab">
                                    <strong class="pr5">{__("Pages")}</strong>
                                </a>
                            </li>
                            <li>
                                <a href="#groups" data-toggle="tab">
                                    <strong class="pr5">{__("Groups")}</strong>
                                </a>
                            </li>
                        </ul>
                        <!-- panel nav -->
                    </div>
                    <div class="panel-body tab-content">
                        <div class="tab-pane active" id="posts">
                            {if count($results['posts']) > 0}
                                <ul>
                                    {foreach $results['posts'] as $post}
                                    {include file='__feeds_post.tpl'}
                                    {/foreach}
                                </ul>
                            {else}
                                <div class="text-center x-muted mtb10">
                                    <i class="material-icons material-icons--large">line_weight</i>
                                    <p class="mt10 mb10"><strong>{__("No results to show")}</strong></p>
                                </div>
                            {/if}
                        </div>
                        <div class="tab-pane" id="users">
                            {if count($results['users']) > 0}
                                <ul>
                                    {foreach $results['users'] as $_user}
                                    {include file='__feeds_user.tpl' _connection=$_user['connection']}
                                    {/foreach}
                                </ul>
                            {else}
                                <div class="text-center x-muted mtb10">
                                    <i class="material-icons material-icons--large">line_weight</i>
                                    <p class="mt10 mb10"><strong>{__("No results to show")}</strong></p>
                                </div>
                            {/if}
                        </div>
                        <div class="tab-pane" id="pages">
                            {if count($results['pages']) > 0}
                                <ul>
                                    {foreach $results['pages'] as $_page}
                                    {include file='__feeds_page.tpl'}
                                    {/foreach}
                                </ul>
                            {else}
                                <div class="text-center x-muted mtb10">
                                    <i class="material-icons material-icons--large">line_weight</i>
                                    <p class="mt10 mb10"><strong>{__("No results to show")}</strong></p>
                                </div>
                            {/if}
                        </div>
                        <div class="tab-pane" id="groups">
                            {if count($results['groups']) > 0}
                                <ul>
                                    {foreach $results['groups'] as $_group}
                                    {include file='__feeds_group.tpl'}
                                    {/foreach}
                                </ul>
                            {else}
                                <div class="text-center x-muted mtb10">
                                    <i class="material-icons material-icons--large">line_weight</i>
                                    <p class="mt10 mb10"><strong>{__("No results to show")}</strong></p>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
                <!-- search results -->
                {/if}

            </div>

        {elseif $view == "pages"}
            <div class="col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading light clearfix">
                        <div class="pull-right flip">
                            <a href="{$system['system_url']}/create/page" class="btn btn-default btn-sm">
                                <i class="fa fa-flag fa-fw pr10"></i> {__("Create Page")}
                            </a>
                        </div>
                        <div class="mt5">
                            <strong>{__("Your Pages")}</strong>
                        </div>
                    </div>
                    <div class="panel-body">

                        {if count($pages) > 0}
                            <ul>
                                {foreach $pages as $_page}
                                {include file='__feeds_page.tpl'}
                                {/foreach}
                            </ul>
                        {else}
                            <p class="text-center text-muted">
                                {__("No pages available")}
                            </p>
                        {/if}

                        {if count($pages) >= $system['max_results']}
                        <!-- see-more -->
                        <div class="alert alert-info see-more js_see-more" data-get="pages">
                            <span>{__("See More")}</span>
                            <div class="loader loader_small x-hidden"></div>
                        </div>
                        <!-- see-more -->
                        {/if}

                    </div>
                </div>
            </div>

        {elseif $view == "groups"}
            <div class="col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading light clearfix">
                        <div class="pull-right flip">
                            <a href="{$system['system_url']}/create/group" class="btn btn-default btn-sm">
                                <i class="fa fa-flag fa-fw pr10"></i> {__("Create Group")}
                            </a>
                        </div>
                        <div class="mt5">
                            <strong>{__("Your Groups")}</strong>
                        </div>
                    </div>
                    <div class="panel-body">

                        {if count($groups) > 0}
                            <ul>
                                {foreach $groups as $_group}
                                    {include file='__feeds_group.tpl'}
                                {/foreach}
                            </ul>
                        {else}
                            <p class="text-center text-muted">
                                {__("No groups available")}
                            </p>
                        {/if}

                        {if count($groups) >= $system['max_results']}
                        <!-- see-more -->
                        <div class="alert alert-info see-more js_see-more" data-get="groups">
                            <span>{__("See More")}</span>
                            <div class="loader loader_small x-hidden"></div>
                        </div>
                        <!-- see-more -->
                        {/if}

                    </div>
                </div>
            </div>

        {elseif $view == "create_page"}
            <div class="col-sm-6">
                <!-- create page -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="mt5">
                            <strong>{__("Create Page")}</strong>
                        </div>
                    </div>
                    <div class="panel-body">
                        <form class="js_ajax-forms" data-url="data/create.php?type=page&amp;do=create">
                            <div class="form-group">
                                <label for="category">{__("Category")}:</label>
                                <select class="form-control" name="category" id="category">
                                    {foreach $categories as $category}
                                    <option value="{$category['category_id']}">{$category['category_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="title">{__("Title")}:</label>
                                <input type="text" class="form-control" name="title" id="title" placeholder="{__("Título de la página")}">
                            </div>
                            <div class="form-group">
                                <label for="username">{__("Username")}:</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="{__("Usuario, Ej. YouTube oficial")}">
                            </div>
                            <div class="form-group">
                                <label for="description">{__("Description")}:</label>
                                <textarea class="form-control" name="description" name="description"  placeholder="{__("Escribe acerca de tu página...")}"></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">{__("Create")}</button>

                            <!-- error -->
                            <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                            <!-- error -->
                        </form>
                    </div>
                </div>
                <!-- create page -->
            </div>

        {elseif $view == "create_group"}
            <div class="col-sm-6">
                <!-- create group -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="mt5">
                            <strong>{__("Create Group")}</strong>
                        </div>
                    </div>
                    <div class="panel-body">
                        <form class="js_ajax-forms" data-url="data/create.php?type=group&amp;do=create">
                            <div class="form-group">
                                <label for="title">{__("Title")}:</label>
                                <input type="text" class="form-control" name="title" id="title" placeholder="{__("Título de la grupo")}">
                            </div>
                            <div class="form-group">
                                <label for="username">{__("Username")}:</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="{__("Usuario, Ej. Grupo de Desarrolladores")}">
                            </div>
                            <div class="form-group">
                                <label for="description">{__("Description")}:</label>
                                <textarea class="form-control" name="description" placeholder="{__("Escribe acerca de tu grupo...")}"></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">{__("Create")}</button>

                            <!-- error -->
                            <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                            <!-- error -->
                        </form>
                    </div>
                </div>
                <!-- create group -->
            </div>

        {elseif $view == "games"}
            <div class="col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading light clearfix">
                        <div class="mt5">
                            <strong>{__("Games")}</strong>
                        </div>
                    </div>
                    <div class="panel-body">

                        {if count($games) > 0}
                            <ul>
                                {foreach $games as $_game}
                                {include file='__feeds_game.tpl'}
                                {/foreach}
                            </ul>
                        {else}
                            <p class="text-center text-muted">
                                {__("No games available")}
                            </p>
                        {/if}

                        {if count($games) >= $system['max_results']}
                        <!-- see-more -->
                        <div class="alert alert-info see-more js_see-more" data-get="games">
                            <span>{__("See More")}</span>
                            <div class="loader loader_small x-hidden"></div>
                        </div>
                        <!-- see-more -->
                        {/if}

                    </div>
                </div>
            </div>

        {/if}
        <!-- center panel -->

        <!-- right panel -->
        <div class="col-sm-4">

            {include file='__ads.tpl'}
            {include file='__widget.tpl'}

            <!-- New People -->
            {if count($new_people) > 0}
                <div class="panel panel-default panel-widget">
                    <div class="panel-heading">
                        <div class="pull-right flip">
                            <small><a href="{$system['system_url']}/friends/requests">{__("See All")}</a></small>
                        </div>
                        <strong>{__("People you may know")}</strong>
                    </div>
                    <div class="panel-body">
                        <ul>
                            {foreach $new_people as $_user}
                            {include file='__feeds_user.tpl' _connection="add" _small=true}
                            {/foreach}
                        </ul>
                    </div>
                </div>
            {/if}
            <!-- New People -->

            <!-- Suggested Pages -->
            {if count($new_pages) > 0}
                <div class="panel panel-default panel-widget">
                    <div class="panel-heading">
                        <strong>{__("Suggested Pages")}</strong>
                    </div>
                    <div class="panel-body">
                        <ul>
                            {foreach $new_pages as $_page}
                            {include file='__feeds_page.tpl'}
                            {/foreach}
                        </ul>
                    </div>
                </div>
            {/if}
            <!-- Suggested Pages -->

            <!-- Suggested Groups -->
            {if count($new_groups) > 0}
                <div class="panel panel-default panel-widget">
                    <div class="panel-heading">
                        <strong>{__("Suggested Groups")}</strong>
                    </div>
                    <div class="panel-body">
                        <ul>
                            {foreach $new_groups as $_group}
                            {include file='__feeds_group.tpl'}
                            {/foreach}
                        </ul>
                    </div>
                </div>
            {/if}
            <!-- Suggested Groups -->

        </div>
        <!-- right panel -->

    </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}
{/if}

