#!/usr/bin/env ruby
# encoding: UTF-8

def parse_csv_string(text, delimiter, limit = nil)
	matches = text.scan(/(?:["']{0,1})(.*?)(?:["']{0,1}#{delimiter}|$|"$)/i)
	if limit
	matches[0,limit]
	else
	matches[0,matches.length - 1]
	end
end

def download_and_rename
	require 'net/ftp'

		begin
		File.rename("rsrinventory-new.txt", "rsrinventory-new_"+Time.now.strftime("%Y%m%d") +".txt")
		FileUtils.mv "rsrinventory-new_"+Time.now.strftime("%Y%m%d") +".txt", "old"
	rescue Exception => e
		p e
		p e.backtrace
	end

	   	ftp=Net::FTP.new
		ftp.connect("ftp.rsrgroup.com","21")
		ftp.login("rsrdealer","429Sg81")
		#ftp.chdir("standard")
		ftp.gettextfile("rsrinventory-new.txt","rsrinventory-new.txt")	

		ftp.close
	
	

	begin
		File.rename("catalog_standard.txt", "catalog_standard_"+Time.now.strftime("%Y%m%d") +".txt")
		FileUtils.mv "catalog_standard_"+Time.now.strftime("%Y%m%d") +".txt", "old"
	rescue Exception => e
		p e
		p e.backtrace
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

	ftp=Net::FTP.new
	ftp.connect("71.6.90.37","21")
	ftp.login("103779","weby331!")
	ftp.chdir("standard")
	ftp.gettextfile("catalog_standard.txt","catalog_standard.txt")
	ftp.gettextfile("cost_standard.csv","cost_standard.csv")
	ftp.gettextfile("inventory_standard.csv","inventory_standard.csv")
	ftp.close





end



def process_files(inv_standard = 'catalog_standard.txt', inventory_standard = 'inventory_standard.csv', cost_standard = 'cost_standard.csv')


	p "Parsing rsrinventory-new.txt"
	text = File.read("rsrinventory-new.txt")
	text = text.unpack('C*').pack('U*')
	text.encode!('UTF-8', 'UTF-8', :invalid => :replace)

	rows = text.scan(/.*/iu)  #separate by lines
	for i in 0..(rows.count - 1)
		if rows[i].length > 10  #to not try to parse empy data
			data = parse_csv_string(rows[i], ";",15)
		


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

				req = "INSERT INTO rsr_inventories VALUES ( DEFAULT, #{values}, NOW(),NOW())"
				#p req

				t = $sql.query(req)
		    rescue Exception => e
				p e
				p e.backtrace
			end


		end

	end



	p "Parsing gas #{inv_standard}"
	text = File.read(inv_standard)
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

				req = "INSERT INTO gas_catalog_standards (#{insert}) VALUES ( #{values})"
				#p req

				t = $sql.query(req)

			rescue Exception => e
				p e
				p e.backtrace
			end


		end

	end



	p "Parsing #{inventory_standard}"

	text = File.read(inventory_standard)
	text = text.unpack('C*').pack('U*')
	text.encode!('UTF-8', 'UTF-8', :invalid => :replace)



	rows = text.scan(/.*/iu)  #separate by lines
	headers = parse_csv_string(rows[0], ",")

	for i in 1..(rows.count - 1)
		if rows[i].length > 10  #to not try to parse empy data
			data = parse_csv_string(rows[i], ",")
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

				req = "INSERT INTO gas_inventory_standards (#{insert}) VALUES ( #{values})"

				$sql.query(req)

			rescue Exception => e
				p e
				p e.backtrace
			end

		end

	end
	p "Parsing #{cost_standard}"

	text = File.read(cost_standard)
	text = text.unpack('C*').pack('U*')
	text.encode!('UTF-8', 'UTF-8', :invalid => :replace)



	rows = text.scan(/.*/iu)  #separate by lines
	headers = parse_csv_string(rows[0], ",")

	for i in 1..(rows.count - 1)
		if rows[i].length > 10  #to not try to parse empy data
			data = parse_csv_string(rows[i], ",")
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

				req = "INSERT INTO gas_cost_standards (#{insert}) VALUES ( #{values})"

				$sql.query(req)

			rescue Exception => e
				p e
				p e.backtrace
			end

		end

	end


end
