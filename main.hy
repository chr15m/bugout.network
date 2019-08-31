(import
  [time [mktime]]
  [datetime [datetime]]
  [feedparser [parse]]
  [jinja2 [Environment FileSystemLoader]]
  [markdown [markdown]]
  [pprint [pprint]])

(require [hy.contrib.walk [let]])

(let [feed (parse "feed.rss")
      entries (map (fn [e]
                     (let [date (-> e (.get "published_parsed") (mktime) (datetime.fromtimestamp) (.strftime "%Y-%m-%d"))
                           url (-> e (.get "link"))
                           title (-> e (.get "title_detail") (.get "value"))
                           summary (-> e (.get "summary") (.split "\n") (cut 0 2))
                           summary (.join "" summary)
                           summary (.replace summary "=\"/" "=\"https://mccormick.cx/")]
                       {"title" title
                        "date" date
                        "url" url
                        "summary" summary}))
                   (.get feed "entries" []))
      template (.get_template (Environment :loader (FileSystemLoader ".")) "index.template.html")
      readme (markdown (-> (open "about.md") (.read)))
      technology (markdown (-> (open "technology.md") (.read)))]
  (print (.render template :entries entries :readme readme :technology technology)))
