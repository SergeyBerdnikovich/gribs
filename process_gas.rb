#!/usr/bin/env ruby
# encoding: UTF-8
require 'fileutils'
require 'yaml'
require 'mysql2'
require 'active_support/all'
require "eventmachine"
require "em-http-request"
require "em_mysql2_connection_pool"

load "download_and_parse.rb"




$env = 'production'
config = YAML.load_file('config/database.yml')

$sqlconf = {
    :host => "localhost",
    :database => config[$env]['database'],
    :reconnect => true,  # make sure you have correct credentials
    :username => config[$env]['username'],
    :password => config[$env]['password'],
    #:size => 30,
    :reconnect => true#,
    #:connections => 50
}

$catalog_parsed = false

$sql = Mysql2::Client.new($sqlconf)



def escape(text)

    return "" if text.nil?

    return $sql.escape(text)

end


def process_catalog

    $sql.query("SELECT * FROM gas_catalog_standards").each do |product|
        check = $sql.query("SELECT id FROM products WHERE item_id = '#{product['item_id']}' AND source_id = 2").to_a
        if check.size == 0
            manufacturer_id = $sql.query("SELECT id FROM manufacturers WHERE name LIKE '#{escape(product['manufacturer'])}'").to_a
            if manufacturer_id.size == 0
                $sql.query("INSERT INTO manufacturers (name) VALUES ('#{escape(product['manufacturer'])}')")
                manufacturer_id = $sql.last_id
            else
                manufacturer_id = manufacturer_id[0]["id"]
            end
            p manufacturer_id

            req = "INSERT INTO products (item_id, manufacturer_item_id, upc_or_ean_id, manufacturer_id, product_name, short_description, extended_description, images, weight, length, width, height,source_id) VALUES ('#{escape(product["item_id"])}', '#{escape(product["manufacturer_item_id"])}', '#{escape(product["upc_or_ean_id"])}', #{manufacturer_id}, '#{escape(product["product_name"])}', '#{escape(product["short_description"])}', '#{escape(product["extended_description"])}', '#{escape(product["images"])}', '#{product["weight"]}', '#{product["length"]}', '#{product["width"]}', '#{product["height"]}',1)"
            t = $sql.query(req)

        end



    end
    $sql.query("DELETE FROM gas_catalog_standards ")
    $catalog_parsed = true
end

#process_catalog()

def process_inventory(date = Time.now.strftime("%Y%m%d"))

$sql.query("SELECT * FROM rsr_inventories").each do |rsr|

        product_id = $sql.query("SELECT id FROM products WHERE item_id = '#{rsr["RSRStockNumber"]}' AND source_id = 2").to_a

        if product_id.size == 0
            manufacturer_id = $sql.query("SELECT id FROM manufacturers WHERE name LIKE '#{escape(rsr['FullManufacturerName'])}'").to_a
            if manufacturer_id.size == 0
                $sql.query("INSERT INTO manufacturers (name) VALUES ('#{escape(rsr['FullManufacturerName'])}')")
                manufacturer_id = $sql.last_id
            else
                manufacturer_id = manufacturer_id[0]["id"]
            end            


           req = "INSERT INTO products (item_id, manufacturer_item_id, upc_or_ean_id, manufacturer_id, product_name, short_description, extended_description, images, weight, length, width, height, cost, source_id) VALUES ('#{escape(rsr["RSRStockNumber"])}', '#{escape(rsr["ManufacturerPartNumber"])}', '#{escape(rsr["UPCCode"])}', #{manufacturer_id}, '#{escape(rsr["Model"])}', '#{escape(rsr["ProductDescription"])}', '#{escape(rsr["ExpandedProductDescription"])}', '#{escape(rsr["Imagename"])}', '#{rsr["ProductWeight"]}', '0', '0', '0', '#{rsr["RetailPrice"]}',2)"
            t = $sql.query(req)
            product_id = $sql.last_id
        else
            product_id = product_id[0]["id"]
        end


        if product_id != nil
            check = $sql.query("SELECT id FROM rsr WHERE date = #{date} AND product_id = #{product_id}").to_a
            if check.size == 0


                req = "INSERT INTO rsr (product_id, date, qty) VALUES ( #{product_id}, #{date}, #{rsr["InventoryQuantity"]})"
                t = $sql.query(req)

            end
        end 
        $sql.query("DELETE FROM rsr_inventories WHERE id = #{rsr['id']}")   
    end

    exit!

    $sql.query("SELECT * FROM gas_inventory_standards").each do |gas|

        product_id = $sql.query("SELECT id FROM products WHERE item_id = '#{gas["item_id"]}'").to_a
        if product_id.size == 0
            p "absense"
            p gas
            process_catalog() if $catalog_parsed == false
            #exit!
            product_id = nil
        else
            product_id = product_id[0]["id"]
        end
        #p product_id


        if product_id != nil
            check = $sql.query("SELECT id FROM gas WHERE date = #{date} AND product_id = #{product_id}").to_a
            if check.size == 0


                req = "INSERT INTO gas (product_id, date, qty) VALUES ( #{product_id}, #{date}, #{gas["qty_available"]})"
                t = $sql.query(req)

            end
        end 
        $sql.query("DELETE FROM gas_inventory_standards WHERE id = #{gas['id']}")
    end


    $sql.query("SELECT * FROM gas_cost_standards").each do |gas|
        product_id = $sql.query("SELECT id FROM products WHERE item_id = '#{gas["item_id"].strip}'").to_a
        if product_id.size == 0
            p "absense"
            p gas
            process_catalog() if $catalog_parsed == false
            #exit!
        else
            product_id = product_id[0]["id"]
            $sql.query("UPDATE products SET cost = #{gas['cost']} WHERE id = #{product_id}")

        end
        $sql.query("DELETE FROM gas_cost_standards WHERE id = #{gas['id']}")
    end



end




EM.run do

    download_and_rename
    process_files
    process_inventory
    exit!
    processing = false
    EM.add_periodic_timer(1) do
        if processing == false
            processing = true
            last_time = $sql.query("SELECT date FROM gas ORDER BY date ASC LIMIT 1").to_a[0]["date"]
            date =  DateTime.strptime(last_time.to_s,"%Y%m%d") - 1.day
            date = date.strftime("%Y%m%d")
            p date
            process_files("old/catalog_standard_#{date}.txt","old/inventory_standard_#{date}.csv" )

            process_inventory(date)
            processing = false
        end


    end

end