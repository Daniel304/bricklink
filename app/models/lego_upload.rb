#require 'httparty_with_cookies'

#Login.new.post lets us log in. Everything works up to the subreddits method.

class LegoUpload
  include HTTParty_with_cookies
  base_uri 'www.bricklink.com'

  def post(username, password)
    options = {:body => {:frmUsername => username, :frmPassword => password, :a => "a", :logFrmFlag => "Y" },
               :headers => {"User-Agent" => "Bricklink api custom browser"}
              }
    self.class.post("/login.asp?logInTo=&logFolder=p&logSub=w", options)
  end

  def sublinks(headers)
    self.class.get("orderSummary.asp?a=p", headers)
  end

  def cli_user_login(user, password)
    a = LegoUpload.new.post(user, password);
    return a.cookies
    b = LegoUpload.new.sublinks("headers" => {"reddit_session" => bricklink_session})
    return b
  end

end
