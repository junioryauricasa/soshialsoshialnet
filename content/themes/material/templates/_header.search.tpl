<form class="navbar-form pull-left flip hidden-xs">
    <input id="search-input" type="text" class="form-control" placeholder="{__("Search for people, pages and #hashtags")}" autocomplete="off">
    <div id="search-results" class="dropdown-menu dropdown-widget dropdown-search">
        <div class="dropdown-widget-header">
            {__("Search Results")}
        </div>
        <div class="dropdown-widget-body">
            <div class="loader loader_small ptb10"></div>
        </div>
        <a class="dropdown-widget-footer" id="search-results-all" href="{$system['system_url']}/search/">{__("See All Results")}</a>
    </div>
</form>