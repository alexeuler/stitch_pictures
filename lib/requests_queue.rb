require 'thread'
require_relative "enums"

class RequestsQueue

  PREFIX = "http://originalstitch.com/shirt/low/"
  POSTFIX = ".png?v=8"

  def initialize
    @queue = Queue.new
    Enums::VIEWS.each do |view|
      Enums::FABRICS.each do |fabric|
        Enums::ITEMS.keys.each do |key|
          items = Enums::Items.new(key)
          items.each do |item|
            @queue.push queue_item(fabric: fabric, view: view, item: item)
          end
        end
      end
    end

  end

  def queue_item(args = {})
    args[:fabric] + "/" + args[:view] + "/" + args[:item]
  end

  def pop
    item = @queue.pop
    {url: PREFIX + item + POSTFIX, filename: item.gsub("/", "_")+".png"}
  end

  def empty?
    @queue.empty?
  end

end