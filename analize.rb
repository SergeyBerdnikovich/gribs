#!/usr/bin/env ruby
# encoding: UTF-8
require 'fileutils'
require 'yaml'
require 'mysql2'

$env = 'production'
config = YAML.load_file('config/database.yml')

  sqlconf = {
        :host => "localhost",
        :database => config[$env]['database'],
        :reconnect => true,  # make sure you have correct credentials
        :username => config[$env]['username'],
        :password => config[$env]['password'],
        :size => 30,
        :reconnect => true,
        :connections => 50
      }



$sql = Mysql2::Client.new(sqlconf)

def parse_csv_string(text, delimiter)
matches = text.scan(/(?:["']{0,1})(.*?)(?:["']{0,1}#{delimiter}|$|"$)/i)
matches[0,matches.length - 1]
end

begin
File.rename("catalog_standard.txt", "catalog_standard_"+Time.now.strftime("%Y%m%d") +".txt")
FileUtils.mv "catalog_standard_"+Time.now.strftime("%Y%m%d") +".txt", "old"
rescue Exception => e
	p e
	p e.backtrace
end

begin
File.rename("inventory_standard.csv", "inventory_standard_"+Time.now.strftime("%Y%m%d") +".csv")
FileUtils.mv "inventory_standard_"+Time.now.strftime("%Y%m%d") +".csv", "old"
rescue Exception => e
	p e
	p e.backtrace
end


require 'net/ftp'
ftp=Net::FTP.new
ftp.connect("71.6.90.37","21")
ftp.login("103779","weby331!")
ftp.chdir("standard")
ftp.gettextfile("catalog_standard.txt","catalog_standard.txt")
ftp.gettextfile("inventory_standard.csv","inventory_standard.csv")
ftp.close







text = File.read('catalog_standard.txt')
text = text.unpack('C*').pack('U*')
text.encode!('UTF-8', 'UTF-8', :invalid => :replace)

rows = text.scan(/.*/iu)  #separate by lines
headers = parse_csv_string(rows[0], "	")

for i in 1..(rows.count - 1)
if rows[i].length > 10  #to not try to parse empy data
data = parse_csv_string(rows[i], "	")
insert =  "" + headers.join(" , ") + ""


values = ""
data.each{|dat|
	if dat != nil
values +=  "'" + $sql.escape(dat[0]) + "' , "
else
	values +=  "'" + "' , "
end
}

values = values[0,values.length - 2]

begin
req = "INSERT INTO products (date, #{insert}) VALUES (#{Time.now.strftime("%Y%m%d")}, #{values})"
p req

$sql.query(req)
rescue Exception => e
	p e
	p e.backtrace
end


end

end



text = File.read('inventory_standard.csv')
text = text.unpack('C*').pack('U*')
text.encode!('UTF-8', 'UTF-8', :invalid => :replace)



rows = text.scan(/.*/i)  #separate by lines
headers = parse_csv_string(rows[0], ",")

for i in 1..(rows.count - 1)
if rows[i].length > 10  #to not try to parse empy data
data = parse_csv_string(rows[i], ",")


begin
dat0 = data[0][0]
rescue
dat0 = ""
end

begin
dat1 = data[1][0]
rescue
dat1 = ""
end

begin
dat3 = data[3][0]
rescue
	dat3 = ""
end

begin
req = "UPDATE products SET #{headers[1][0]} = '#{dat1}',  #{headers[3][0]} = '#{dat3}' WHERE #{headers[0][0]} = '#{dat0}' AND date = #{Time.now.strftime("%Y%m%d")}"
p req
$sql.query(req)

rescue Exception => e
	p e
	p e.backtrace
end

end

end


