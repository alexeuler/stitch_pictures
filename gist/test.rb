require_relative "../lib/enums"

items = Enums::Items.new("cuffs")
items.each {|item| p item}
