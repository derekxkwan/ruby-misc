require 'json'

if ARGV.size >= 2
  json_file = ARGV.shift
  file_match = /([^\s]+)\.([^\.]+)/.match(json_file).to_a
  file_ext = file_match.fetch(2,"txt")
  file_name = file_match.fetch(1,"")
  out_name = file_name + "_proc." + file_ext
  json_key = ARGV.shift
  json_data = JSON.parse(IO.readlines(json_file).join())
  json_data = json_data[json_key].map do |cur|
    cur_vals  = /([^-]+)-([^-]+)/.match(cur["name"]).to_a
    cur_artist = cur_vals.fetch(1, "").strip()
    cur_title = cur_vals.fetch(2, "").strip()
    cur.delete("name")
    cur.merge!({"artist" => cur_artist, "title" => cur_title})
  end
  json_out = JSON.generate(json_data)
  File.open(out_name, "w"){|file| file.puts(json_out)}
end
  
  
    
    
