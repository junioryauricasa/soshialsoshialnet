<!DOCTYPE html>

<!--[if IE 8]><html class="ie8"> <![endif]-->
<!--[if IE 9]><html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--><html class="gt-ie8 gt-ie9 not-ie" dir="{$system['language']['dir']}"><!--<![endif]-->

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <!-- Title -->
    <title>{$page_title}</title>
    
    <!-- Meta -->
    <meta name="keywords" content="">
    <meta name="description" content="{$system['system_description']}">

    <!-- Favicon -->
    <link rel="shortcut icon" href="{$system['system_url']}/content/themes/{$system['theme']}/images/favicon.png" />
    
    <!-- Fonts -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&amp;subset=latin" rel="stylesheet" type="text/css">
    <link rel="stylesheet prefetch" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Font-Awesome -->
    <link rel="stylesheet" href="{$system['system_url']}/content/themes/{$system['theme']}/css/font-awesome/css/font-awesome.min.css">

    <!-- Twemoji-Awesome -->
    <link rel="stylesheet" href="{$system['system_url']}/content/themes/{$system['theme']}/css/twemoji-awesome/twemoji-awesome.min.css">

    <!-- Flag-Icon -->
    <link rel="stylesheet" href="{$system['system_url']}/content/themes/{$system['theme']}/css/flag-icon/flag-icon.min.css">
    
    <!-- Bootstrap -->
    <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/bootstrap/css/bootstrap-social.min.css">

    {if $system['language']['dir'] == "RTL"}
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/bootstrap/css/bootstrap-rtl.min.css">
    {/if}

    <!-- Styles -->
    {if $system['language']['dir'] == "LTR"}
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.css">
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.responsive.480.css">
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.responsive.768.css">
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.material.css">
    {else}
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.rtl.css">
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.responsive.480.rtl.css">
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.responsive.768.rtl.css">
        <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.material.rtl.css">
    {/if}
    
    <!-- JS Files -->
    {include file='_js_files.tpl'}
    <!-- JS Files -->
    
</head>