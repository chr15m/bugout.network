index.html: index.template.html *.md main.hy feed.rss
	hy main.hy > $@

feed.rss:
	curl https://mccormick.cx/news/tags/cryptography.rss > feed-incoming.rss && mv feed-incoming.rss feed.rss
