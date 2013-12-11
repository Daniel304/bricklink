require 'active_model'
require 'mechanize'

class LegoInvoices
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  require 'nokogiri'
  require 'open-uri'

  attr_accessor :id, :link, :date, :invoice, :buyer, :total, :status, :details

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def find_invoices(username,password)
    a = Mechanize.new { |agent|
     agent.follow_meta_refresh = true
    }
    a.get('http://www.bricklink.com/') do |page|
      # Click the login link
      login_page = a.click(page.link_with(:text => /Login/))
      # Submit the login form
      my_page = login_page.form_with(:action => '/login.asp?logInTo=&logFolder=p&logSub=w') do |f|
        f.frmUsername  = username
        f.frmPassword  = password
        f.a            = "a"
        f.logFrmFlag   = "Y"
      end.click_button

      order_page = a.click(my_page.link_with(:text => /Orders/))
      order_received_page = a.click(order_page.link_with(:text => /My Orders Received/))
      rows = order_received_page.parser.xpath('//table[@class="tableT1"]/tr')

      rows.pop
      self.details = rows.drop(1).collect do |row|
        detail = {}
        [
          [:id,           "td[1]/a/text()"],
          [:link,         "td[1]/a/@href"],
          [:date,         "td[3]/text()"],
          [:invoice,      "td[6]/a/@href"],
          [:buyer,        "td[8]/a/text()"],
          [:total,        "td[13]/text()"],
          [:status,       "td[14]/select[@class='mfB']/option[@selected='selected']/text()"],
        ].each do |name, xpath|
          detail[name] = row.at_xpath(xpath).to_s.strip
        end
        detail
      end

      return details
    end
  end
end

