PHOTOS_FULL = $(shell find photos/full -name '*.jpg')
PHOTOS_HD = $(PHOTOS_FULL:photos/full/%=photos/hd/%)
PHOTOS_THUMB = $(PHOTOS_FULL:photos/full/%=photos/thumb/%)
PHOTOS_MD = $(PHOTOS_FULL:photos/full/%.jpg=photos/%.md)
MD = $(shell find . -not -path './photos/*' -name '*.md')

build: $(PHOTOS_HD) $(PHOTOS_THUMB) $(PHOTOS_MD)

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
	convert $< -resize 1920x $@

photos/thumb/%.jpg: photos/full/%.jpg
	convert $< -resize 200x133^ -gravity center -crop 200x133+0+0 $@

photos/%.md: photos/full/%.jpg
	$(PROGDIR)/genmd $< > $@
