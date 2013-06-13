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


p "checking quantity table"
lastdate = 0
res = $sql.query("SELECT date FROM quantities ORDER BY date DESC LIMIT 1") #trying to define a date we want to get quantities for
lastdate = res.to_a[0]['date'] if res.to_a[0] != nil

p lastdate

res = $sql.query("SELECT date FROM products WHERE date > #{lastdate} ORDER BY date ASC LIMIT 1") #to scan only absent day, first from the past
scandate = res.to_a[0]['date'] if res.to_a[0] != nil

p scandate

if scandate != nil
	req = "SELECT item_id, qty_available FROM products WHERE date = #{scandate}"
	p req
	res = $sql.query(req)
	res.to_a.each do |item|
		p item
		res1 = $sql.query("SELECT * FROM quantities WHERE item_id = '#{item['item_id']}' AND date = #{scandate}")
		id = 0
		if res1.to_a.size == 0
			begin
			$sql.query("INSERT INTO quantities (item_id, qty, date) VALUES (#{item['item_id']}, #{item['qty_available']} , #{scandate} )")
			p "INSERT INTO quantities (item_id, qty, date) VALUES (#{item['item_id']}, #{item['qty_available']} , #{scandate} )"
			id = $sql.last_id
			p id
			rescue Exception => e
			p e
			p e.backtrace
			p item
			end
		else
			p "double! #{scandate}"
			p item
		end 

		#$sql.query("UPDATE products SET item_id = #{id} WHERE id = #{item['id']}")
	end
end


exit!


p "checking itemids"
begin
	#req = "UPDATE products SET #{headers[1][0]} = '#{dat1}',  #{headers[3][0]} = '#{dat3}' WHERE #{headers[0][0]} = '#{dat0}' AND date = #{Time.now.strftime("%Y%m%d")}"
	req = "SELECT id, itemid FROM products WHERE item_id IS NULL"
	res = $sql.query(req)
	res.to_a.each do |item|
		p item
		res1 = $sql.query("SELECT * FROM items WHERE itemid = '#{item['itemid']}'")
		id = 0
		if res1.to_a.size == 0
			$sql.query("INSERT INTO items (itemid) VALUES ('#{item['itemid']}')")
			id = $sql.last_id
		else
			id = res1.to_a[0]['id']
		end 

		$sql.query("UPDATE products SET item_id = #{id} WHERE id = #{item['id']}")
	end


rescue Exception => e
	p e
	p e.backtrace
end








