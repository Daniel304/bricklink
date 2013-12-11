class Lego

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  require 'nokogiri'
  require 'open-uri'

  attr_accessor :sid, :price, :firstname, :lastname, :details

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def get_price (lid)
    doc = Nokogiri::HTML(open('http://www.bricklink.com/catalogPG.asp?S='+ lid))
    price = doc.xpath('//td//b/text()')[-2]
    price.to_s.match( /(\d+.\d+)/ )
    self.send("price=", price.to_s)
  end

  def get_parts (lid)
    doc = Nokogiri::HTML(open('http://www.bricklink.com/catalogItemInv.asp?S='+ lid))
    rows = doc.xpath('//form/table[@class="ta"]/tr')
    details = rows.collect do |row|
      detail = {}
      [
        [:image, 'td[1]/b/a/img/@src'],
        [:qty, 'td[2]/text()'],
        [:bid, 'td[3]/a/text()'],
        [:description, 'td[4]/b/text()'],
      ].each do |name, xpath|
        detail[name] = row.at_xpath(xpath).to_s.strip
      end
      detail
    end
    self.send("details=", details)

#<TR BGCOLOR="#FFFFFF">
#<TD ALIGN="CENTER"><B><A ID='imgLink0' HREF='/catalogItemPic.asp?P=10235stk01' REL='blcatimg'><IMG ALT="Part No: 10235stk01  Name: Sticker for Set 10235 - &#40;14183/6037274&#41;" TITLE="Part No: 10235stk01  Name: Sticker for Set 10235 - &#40;14183/6037274&#41;"  BORDER='0'  WIDTH='80' HEIGHT='60' SRC='http://img.bricklink.com/P/0/10235stk01.jpg' NAME='img0' ID='img0' onError="killImage('img0');"></A><BR><FONT FACE='Tahoma,Arial' SIZE='1'>*</FONT></B></TD>
#<TD ALIGN="RIGHT">&nbsp;1&nbsp;</TD>
#<TD NOWRAP>&nbsp;<A HREF="catalogItem.asp?P=10235stk01">10235stk01</A></TD>
#<TD><B>Sticker for Set 10235 - &#40;14183/6037274&#41; </B></TD>
#<TD ALIGN="RIGHT"></TD></TR>
#    self.send doc.search('a').map{ |a| a.text] }[0, 5]
  end

end
