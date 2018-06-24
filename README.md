# ruby-misc
miscellaneous ruby scripts


## org_to_json.rb
- **description** - converts org-files into json
- **args** - org-file to convert (must have extension .org)
- **output** - file-name of org file but with extension .txt
- **notes** - merges repeated headers, headers (entries with *'s) should have children (entries with - or +) to be included in json, this is essentially as a simple parser... 


## json_namesplit.rb
- **description** - reads json in text file and splits the name field with format "artist - title" into separate artist title keys
- **args** - name of file, key containing array of name-containing hashmaps ({"media": [{"name":...}, {"name":...}]})
- **output** - processed file with _proc added to name
- **notes** - i know this is very specialized
