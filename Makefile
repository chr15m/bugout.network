index.html: index.template.html *.md main.hy feed.rss
	curl -s https://mccormick.cx/news/tags/cryptography.rss > feed-incoming.rss && mv feed-incoming.rss feed.rss || echo "Skip RSS"
	hy main.hy > $@

