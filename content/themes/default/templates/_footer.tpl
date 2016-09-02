
<!-- footer -->
<div class="container">
	<div class="row footer">
		<div class="col-lg-6 col-md-6 col-sm-6">
			&copy; {'Y'|date} {$system['system_title']} · <span class="text-link" data-toggle="modal" data-url="#translator">{$system['language']['title']}</span>
		</div>

		<div class="col-lg-6 col-md-6 col-sm-6 links">
			{if count($static_pages) > 0}
				{foreach $static_pages as $static_page}
					<a href="{$system['system_url']}/static/{$static_page['page_url']}">
						{$static_page['page_title']}
					</a>{if !$static_page@last} · {/if}
				{/foreach}
			{/if}
		</div>
	</div>
</div>
<!-- footer -->

</div>
<!-- main wrapper -->

<!-- JS Templates -->
{include file='_js_templates.tpl'}
<!-- JS Templates -->

<!-- Google Analytics -->
{if $system['google_analytics']}
{html_entity_decode($system['google_analytics'], ENT_QUOTES)}
{/if}
<!-- Google Analytics -->

<!-- Chat Audio -->
<audio id="chat_audio">
	<source src="{$system['system_url']}/includes/sounds/notify.ogg" type="audio/ogg">
	<source src="{$system['system_url']}/includes/sounds/notify.mp3" type="audio/mpeg">
	<source src="{$system['system_url']}/includes/sounds/notify.wav" type="audio/wav">
</audio>
<!-- Chat Audio -->

</body>
</html>