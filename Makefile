css:
	stylus -I /usr/local/lib/node_modules/nib/lib -o css/ css/stylus/

watch-css:
	stylus -w -I /usr/local/lib/node_modules/nib/lib -o css/ css/stylus/

.PHONY: css
