require 'active_model'

class LegoPart
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  require 'nokogiri'
  require 'open-uri'

  attr_accessor :id, :quantity, :item_id, :name, :image, :color_id, :description, :release_year, :weight, :dimensions, :type, :details

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def find_parts(id)
    doc                 = Nokogiri::HTML(open('http://www.bricklink.com/catalogItemInv.asp?S='+ id))
    doc.css('br').each{ |br| br.replace(";") }
    self.id             = id
    rows                = doc.xpath('//center/form/table[@class="ta"]/tr')
    self.details        = []
    rows.drop(3).collect do |row|
      detail = {}
      [
        [:id,           "td[3]/a/text()"],
        [:quantity,     "td[2]/text()"],
        [:item_id,      "td[3]/a/text()"],
        [:type,         "td[4]/font[@class='fv']/a[3]/text()"],
        [:image,        "td[1]/b/a/img/@src"],
        [:color_id,     "td[1]/b/a/img/@src"],
        [:description,  "td[4]/b/text()"],
      ].each do |name, xpath|
        if name == :color_id
          detail[name] = row.at_xpath(xpath).to_s.strip.split("/")[4]
        elsif name == :quantity
          detail[name] = row.at_xpath(xpath).to_s.strip.to_i.to_s
        else
          detail[name] = row.at_xpath(xpath).to_s.strip
        end
      end
      break if row.at_xpath("td/font/b/text()").to_s.strip.match("Extra Items")
      break if row.at_xpath("td/font/b/text()").to_s.strip.match("Counterparts")
      next if row.at_xpath("td[2]/text()").to_s == "" and row.at_xpath("td[3]/a/text()").to_s == ""
      self.details << detail
    end
  end
end

