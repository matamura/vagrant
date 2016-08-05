
file_name=ARGV[0]
# e.g. [node-id]@[ip-addr]:[port], [node-id]@[ip-addr]:[port]
replace_list=ARGV[1]

replace_target = {}
unless replace_list.nil?
  replace_rows = replace_list.split(",")
  replace_rows.each do |row|
    cols = row.split("@")
    replace_target[cols[0]] = cols[1]
  end
end

contents = File.read(file_name).split("\n")

puts "before"
contents.each do |row|
  puts row

  cols = row.split(" ")
  replace_ip = replace_target[cols[0]]
  next if replace_ip.nil?

  regexp = "#{cols[0]} #{cols[1]}"
  row.gsub!(/#{regexp}/, "#{cols[0]} #{replace_ip}")
end

puts "after"
write_text = ""
contents.each do |row|
  write_text += row + "\n"
  puts row
end

File.write(file_name, write_text)
