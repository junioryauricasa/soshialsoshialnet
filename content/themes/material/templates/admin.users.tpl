<div class="panel panel-default">
    <div class="panel-heading with-icon">
        {if $sub_view == "edit"}
            <div class="pull-right flip">
                <a target="_blank" href="{$system['system_url']}/{$data['user_name']}" class="btn btn-info">
                    {__("Go to this profile")}
                </a>
            </div>
        {/if}
        <i class="material-icons panel-icon">person</i>
        <strong>{__("Users")}</strong>
        {if $sub_view != "" && $sub_view != "edit"} &rsaquo; <strong>{__($sub_view|capitalize)}</strong>{/if}
        {if $sub_view == "edit"} &rsaquo; <strong>{$data['user_fullname']}</strong>{/if}
    </div>
    {if $sub_view != "edit"}
        <div class="panel-body with-table">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover js_dataTable">
                    <thead>
                        <tr>
                            <th>{__("ID")}</th>
                            <th>{__("Picture")}</th>
                            <th>{__("Username")}</th>
                            <th>{__("Name")}</th>
                            <th>{__("IP")}</th>
                            <th>{__("Joined")}</th>
                            <th>{__("Activated")}</th>
                            <th>{__("Actions")}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $rows as $row}
                        <tr>
                            <td><a href="{$system['system_url']}/{$row['user_name']}" target="_blank">{$row['user_id']}</a></td>
                            <td>
                                <a target="_blank" class="x-image sm" href="{$system['system_url']}/{$row['user_name']}" style="background-image:url({$row['user_picture']});">
                                </a>
                            </td>
                            <td>
                                <a href="{$system['system_url']}/{$row['user_name']}" target="_blank">
                                    {$row['user_name']}
                                </a>
                            </td>
                            <td>
                                <a href="{$system['system_url']}/{$row['user_name']}" target="_blank">
                                    {$row['user_fullname']}
                                </a>
                            </td>
                            <td>{$row['user_ip']}</td>
                            <td>{$row['user_registered']|date_format:"%e %B %Y"}</td>
                            <td>
                                {if $row['user_activated']}
                                <span class="label label-success">{__("Yes")}</span>
                                {else}
                                <span class="label label-danger">{__("No")}</span>
                                {/if}
                            </td>
                            <td>
                                <button class="btn btn-xs btn-danger js_admin-deleter" data-handle="user" data-id="{$row['user_id']}">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <a href="{$system['system_url']}/admin/users/edit/{$row['user_id']}" class="btn btn-xs btn-primary">
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
            <div class="row">
                <div class="col-xs-offset-3 col-xs-6 col-sm-offset-0 col-sm-2 mb10">
                    <img class="img-responsive img-thumbnail" src="{$data['user_picture']}">
                </div>
                <div class="col-xs-12 col-sm-5 mb10">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <span class="badge">{$data['user_id']}</span>
                            {__("User ID")}
                        </li>
                        <li class="list-group-item">
                            <span class="badge">{$data['user_registered']|date_format:"%e %B %Y"}</span>
                            {__("Joined")}
                        </li>
                        <li class="list-group-item">
                            <span class="badge">{$data['user_last_login']|date_format:"%e %B %Y"}</span>
                            {__("Last Login")}
                        </li>
                    </ul>
                </div>
                <div class="col-xs-12 col-sm-5 mb10">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <span class="badge">{$data['friends']}</span>
                            {__("Friends")}
                        </li>
                        <li class="list-group-item">
                            <span class="badge">{$data['followings']}</span>
                            {__("Followings")}
                        </li>
                        <li class="list-group-item">
                            <span class="badge">{$data['followers']}</span>
                            {__("Followers")}
                        </li>
                    </ul>
                </div>
            </div>
            <!-- tabs nav -->
            <ul class="nav nav-tabs mb20">
                <li class="active">
                    <a href="#basic" data-toggle="tab">
                        <strong class="pr5">{__("Basic Info")}</strong>
                    </a>
                </li>
                <li>
                    <a href="#profile" data-toggle="tab">
                        <strong class="pr5">{__("Profile")}</strong>
                    </a>
                </li>
                <li>
                    <a href="#username" data-toggle="tab">
                        <strong class="pr5">{__("Username")}</strong>
                    </a>
                </li>
                <li>
                    <a href="#email" data-toggle="tab">
                        <strong class="pr5">{__("Email")}</strong>
                    </a>
                </li>
                <li>
                    <a href="#password" data-toggle="tab">
                        <strong class="pr5">{__("Password")}</strong>
                    </a>
                </li>
                <li>
                    <a href="#privacy" data-toggle="tab">
                        <strong class="pr5">{__("Privacy")}</strong>
                    </a>
                </li>
            </ul>
            <!-- tabs nav -->

            <!-- tabs content -->
            <div class="tab-content">
                <!-- basic tab -->
                <div class="tab-pane active" id="basic">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/user.php?id={$data['user_id']}&edit=basic">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Verified User")}
                            </label>
                            <div class="col-sm-9">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="user_verified" class="onoffswitch-checkbox" id="user_verified" {if $data['user_verified']}checked{/if}>
                                    <label class="onoffswitch-label" for="user_verified"></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Banned")}
                            </label>
                            <div class="col-sm-9">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="user_blocked" class="onoffswitch-checkbox" id="user_blocked" {if $data['user_blocked']}checked{/if}>
                                    <label class="onoffswitch-label" for="user_blocked"></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Email Activated")}
                            </label>
                            <div class="col-sm-9">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="user_activated" class="onoffswitch-checkbox" id="user_activated" {if $data['user_activated']}checked{/if}>
                                    <label class="onoffswitch-label" for="user_activated"></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Password Rested")}
                            </label>
                            <div class="col-sm-9">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="user_reseted" class="onoffswitch-checkbox" id="user_reseted" {if $data['user_reseted']}checked{/if}>
                                    <label class="onoffswitch-label" for="user_reseted"></label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("User Group")}
                            </label>
                            <div class="col-sm-9">
                                <select class="form-control" name="user_group">
                                    <option value="1" {if $data['user_group'] == '1'}selected{/if}>
                                        {__("Admins")}
                                    </option>
                                    <option value="2" {if $data['user_group'] == '2'}selected{/if}>
                                        {__("Moderators")}
                                    </option>
                                    <option value="3" {if $data['user_group'] == '3'}selected{/if}>
                                        {__("Users")}
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("IP")}
                            </label>
                            <div class="col-sm-9">
                                <input class="form-control" name="user_ip" value="{$data['user_ip']}">
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
                <!-- basic tab -->

                <!-- profile tab -->
                <div class="tab-pane" id="profile">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/user.php?id={$data['user_id']}&edit=profile">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Full Name")}
                            </label>
                            <div class="col-sm-9">
                                <input class="form-control" name="user_fullname" value="{$data['user_fullname']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Gender")}
                            </label>
                            <div class="col-sm-9">
                                <select class="form-control" name="user_gender">
                                    <option value="none">{__("Select Sex")}:</option>
                                    <option {if $data['user_gender'] == "M"}selected{/if} value="M">
                                        {__("Male")}
                                    </option>
                                    <option {if $data['user_gender'] == "F"}selected{/if} value="F">
                                        {__("Female")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Birthdate")}
                            </label>
                            <div class="col-sm-9">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <select class="form-control" name="birth_month">
                                            <option value="none">{__("Select Month")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '1'}selected{/if} value="1">{__("Jan")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '2'}selected{/if} value="2">{__("Feb")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '3'}selected{/if} value="3">{__("Mar")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '4'}selected{/if} value="4">{__("Apr")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '5'}selected{/if} value="5">{__("May")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '6'}selected{/if} value="6">{__("Jun")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '7'}selected{/if} value="7">{__("Jul")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '8'}selected{/if} value="8">{__("Aug")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '9'}selected{/if} value="9">{__("Sep")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '10'}selected{/if} value="10">{__("Oct")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '11'}selected{/if} value="11">{__("Nov")}</option>
                                            <option {if $data['user_birthdate_parsed']['month'] == '12'}selected{/if} value="12">{__("Dec")}</option>
                                        </select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" name="birth_day">
                                            <option value="none">{__("Select Day")}</option>
                                            {for $i=1 to 31}
                                            <option {if $data['user_birthdate_parsed']['day'] == $i}selected{/if} value="{$i}">{$i}</option>
                                            {/for}
                                        </select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" name="birth_year">
                                            <option value="none">{__("Select Year")}</option>
                                            {for $i=1905 to 2015}
                                            <option {if $data['user_birthdate_parsed']['year'] == $i}selected{/if} value="{$i}">{$i}</option>
                                            {/for}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="divider"></div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Work Title")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_work_title" value="{$data['user_work_title']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Work Place")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_work_place" value="{$data['user_work_place']}">
                            </div>
                        </div>
                        <div class="divider"></div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Current City")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_current_city" value="{$data['user_current_city']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Hometown")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_hometown" value="{$data['user_hometown']}">
                            </div>
                        </div>
                        <div class="divider"></div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Major")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_edu_major" value="{$data['user_edu_major']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("School")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_edu_school" value="{$data['user_edu_school']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Class")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_edu_class" value="{$data['user_edu_class']}">
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
                <!-- profile tab -->

                <!-- username tab -->
                <div class="tab-pane" id="username">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/user.php?id={$data['user_id']}&edit=username&username={$data['user_name']}">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Username")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_name" value="{$data['user_name']}">
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
                <!-- username tab -->

                <!-- email tab -->
                <div class="tab-pane" id="email">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/user.php?id={$data['user_id']}&edit=email&email={$data['user_email']}">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Email address")}
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_email" value="{$data['user_email']}">
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
                <!-- email tab -->

                <!-- password tab -->
                <div class="tab-pane" id="password">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/user.php?id={$data['user_id']}&edit=password">
                        <div class="form-group">
                            <label class="col-sm-3 control-label text-left">
                                {__("Password")}
                            </label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" name="user_password">
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
                <!-- password tab -->

                <!-- privacy tab -->
                <div class="tab-pane" id="privacy">
                    <form class="js_ajax-forms form-horizontal" data-url="admin/user.php?id={$data['user_id']}&edit=privacy">
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Chat")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_chat_enabled">
                                    <option {if $data['user_chat_enabled'] == 0}selected{/if} value="0">
                                        {__("Offline")}
                                    </option>
                                    <option {if $data['user_chat_enabled'] == 1}selected{/if} value="1">
                                        {__("Online")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("birthdate")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_birthdate">
                                    <option {if $data['user_privacy_birthdate'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_birthdate'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("work info")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_work">
                                    <option {if $data['user_privacy_work'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_work'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("location info")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_location">
                                    <option {if $data['user_privacy_location'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_location'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("education info")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_education">
                                    <option {if $data['user_privacy_education'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_education'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("friends")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_friends">
                                    <option {if $data['user_privacy_friends'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_friends'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                    <option {if $data['user_privacy_friends'] == "me"}selected{/if} value="me">
                                        {__("Just Me")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("liked pages")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_pages">
                                    <option {if $data['user_privacy_pages'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_pages'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                    <option {if $data['user_privacy_pages'] == "me"}selected{/if} value="me">
                                        {__("Just Me")}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 control-label">
                                {__("Who can see your")} {__("joined groups")}
                            </label>
                            <div class="col-sm-3">
                                <select class="form-control" name="user_privacy_groups">
                                    <option {if $data['user_privacy_groups'] == "public"}selected{/if} value="public">
                                        {__("Everyone")}
                                    </option>
                                    <option {if $data['user_privacy_groups'] == "friends"}selected{/if} value="friends">
                                        {__("Friends")}
                                    </option>
                                    <option {if $data['user_privacy_groups'] == "me"}selected{/if} value="me">
                                        {__("Just Me")}
                                    </option>
                                </select>
                            </div>
                        </div>

                        <!-- success -->
                        <div class="alert alert-success mb0 mt10 x-hidden" role="alert"></div>
                        <!-- success -->

                        <!-- error -->
                        <div class="alert alert-danger mb0 mt10 x-hidden" role="alert"></div>
                        <!-- error -->

                        <div class="form-group">
                            <div class="col-sm-7 col-sm-offset-5">
                                <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- privacy tab -->
            </div>
            <!-- tabs content -->
        </div>

    {/if}
</div>