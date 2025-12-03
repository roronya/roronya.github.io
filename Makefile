all: entries top articles

top:
	pandoc --template templates/top.html entries.md -o docs/index.html

# usage: make article slug=202501011525
# slugに指定した記事のhtmlを作り直す。templateのhtmlに変更が入ったときに使う。
article:
	pandoc --template=templates/article.html --filter=pandoc/filter.py markdown/${slug}.md -o docs/${slug}.html

# usage: make articles
# markdown配下のすべての記事を作り直す。
articles:
	ls -1 markdown | xargs -P4 -I {} basename {} .md | xargs -P4 -I {} make article slug={}

INPUT_DIR=markdown
OUTPUT_FILE=entries.md
entries:
	@echo "---" > "$(OUTPUT_FILE)"
	@echo "entries:" >> "$(OUTPUT_FILE)"
	@{ \
	  for file in $(INPUT_DIR)/*.md; do \
	    slug=$$(awk -F': ' '/^slug:/ {print $$2}' $$file); \
	    title=$$(awk '/^# / {sub("^# ", ""); print; exit}' $$file | sed 's/"/\\"/g'); \
	    year=$$(echo $$slug | cut -c1-4); \
	    month=$$(echo $$slug | cut -c5-6); \
	    day=$$(echo $$slug | cut -c7-8); \
	    createdAt="$$year-$$month-$$day"; \
	    echo "$$createdAt|./$$slug.html|$$title"; \
	  done | sort -r | \
	  awk -F'|' '{printf "  - {createdAt: \"%s\", path: \"%s\", title: \"%s\"}\n", $$1, $$2, $$3}' >> "$(OUTPUT_FILE)"; \
	}
	@echo "---" >> "$(OUTPUT_FILE)"

