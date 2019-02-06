PHOTOS_FULL = $(shell find photos/full -name '*.jpg')
PHOTOS_HD = $(PHOTOS_FULL:photos/full/%=photos/hd/%)
PHOTOS_THUMB = $(PHOTOS_FULL:photos/full/%=photos/thumb/%)
PHOTOS_HTML = $(PHOTOS_FULL:photos/full/%.jpg=photos/%.html)
MD = $(shell find . -not -path './photos/*' -name '*.md')
HTML = $(MD:%.md=%.html)
ASSETS = css/normalize.css css/github-markdown.css css/main.css js/main.js

build: $(PHOTOS_HD) $(PHOTOS_THUMB) $(PHOTOS_HTML) $(HTML) $(ASSETS)

orphans: .photos .references
	@comm -23 .photos .references
	@rm .photos .references

missing: .photos .references
	@comm -13 .photos .references
	@rm .photos .references

.photos: $(PHOTOS_FULL)
	@printf '%s\n' $(^:photos/full/%=%) | sort | uniq > $@

.references: $(MD)
	@grep --no-filename -o '[^/]*\.jpg' $^ | sort | uniq > $@

photos/hd/%.jpg: photos/full/%.jpg
	convert $< -resize 1920x1080^ $@

photos/thumb/%.jpg: photos/full/%.jpg
	convert $< -resize 200x133^ -gravity center -crop 200x133+0+0 $@

photos/%.html: photos/full/%.jpg
	$(PROGDIR)/genphotopage $< > $@

%.html: %.md
	$(PROGDIR)/render $< > $@

css/normalize.css: $(PROGDIR)/node_modules/normalize.css/normalize.css
	cp $< $@

css/github-markdown.css: $(PROGDIR)/node_modules/github-markdown-css/github-markdown.css
	cp $< $@

css/main.css: $(PROGDIR)/main.css
	cp $< $@

js/main.js: $(PROGDIR)/main.js
	cp $< $@
