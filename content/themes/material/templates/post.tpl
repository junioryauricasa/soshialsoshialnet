{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20">
	<div class="row">

		<!-- left panel -->
		<div class="col-sm-8">
		{include file='__feeds_post.tpl' single=true}
		</div>
		<!-- left panel -->

		<!-- right panel -->
		<div class="col-sm-4">
		{include file='__ads.tpl'}
		{include file='__widget.tpl'}
		</div>
		<!-- right panel -->

	</div>
</div>
<!-- page content -->

{include file='_footer.tpl'}