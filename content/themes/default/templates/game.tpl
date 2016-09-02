{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20">
	<div class="row">

		<!-- left panel -->
		<div class="col-sm-12">
			<div class="post">
				<div class="post-body">
					<div class="post-header mb0">
						<div class="post-avatar">
							<div class="post-avatar-picture" style="background-image:url({$game['thumbnail']});">
							</div>
						</div>
						<div class="post-meta">
							<!-- game name -->
							<h3 style="margin-top: 5px; margin-bottom: 0;">{$game['title']}</h3>
							<!-- game name -->
						</div>
					</div>
				</div>
			</div>
			<div class="table-responsive">
				<iframe frameborder="0" src="{$game['source']}" width="940" height="560"></iframe>
			</div>

		</div>
		<!-- left panel -->

		

	</div>
</div>
<!-- page content -->

{include file='_footer.tpl'}