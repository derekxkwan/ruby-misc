require 'json'

def fill_layers(my_dict, headers)
  (1..headers.size).each do |num|
    if num == 1
      my_dict.merge!({ headers[num-1] => {:data => []}}) unless my_dict.include?(headers[num-1])
    else
      cur_lvl = my_dict.dig(*headers.slice(0,num-1))
      cur_lvl&.merge!({ headers[num-1] => {:data => []}}) unless cur_lvl&.include?(headers[num-1])
    end
  end
end

if ARGV.size > 0
  my_dict = {}
  org_file = ARGV.shift
  file = File.open(org_file, "r")
  file_name = /([^\s]+)\.org/.match(org_file).to_a.fetch(1)
  headers = []
  entering_data = true # if entering data the first time (or in headers)
  while !file.eof?
    line = file.readline.strip
    parse_header = /(^\*+)\s*([a-zA-Z0-9\s]+)/.match(line).to_a || []
    header_depth = parse_header&.fetch(1, "").length
    if header_depth > 0
      entering_data = true
      headers = headers.slice(0,header_depth -1) + [parse_header&.fetch(2, "").strip.to_s || ""]
    else
      parse_data = /[\+\-]+\s*([^\+\-]*)/.match(line).to_a
      if entering_data
        fill_layers(my_dict, headers)
        entering_data = false
      end
      my_dict.dig(*headers, :data)&.push(parse_data&.fetch(1, ""))
    end
  end
  fill_layers(my_dict, headers) if entering_data # go ahead and fill in headers even if last line had no children
  my_json = JSON.generate(my_dict)
  File.open(file_name + ".txt", "w"){|file| file.puts(my_json)}
end
