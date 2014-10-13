class UrlShortnerController < ApplicationController

  def index
    @short_url = ShortUrl.new
  end


  def shorten_url

    url = params[:short_url][:original_url]
    @short_url = ShortUrl.find_by_original_url("#{url}") || ShortUrl.new
    if @short_url.new_record?
      @short_url.original_url = url
      @short_url.random_string = random_string
      @short_url.shortend_url = @shortend_url = small_url(random_string)
    else
      @shortend_url = @short_url.shortend_url
    end
    if @short_url.valid?
      @short_url.save
      respond_to do |format|
        format.html {
          render :result
        }
      end
    else
      respond_to do |format|
        format.html {
          render :index
        }
      end
    end

  end

  def original_redirect
    random_string = params[:random]
    short_url = ShortUrl.find_by_random_string("#{random_string}")
    if short_url
      url = short_url.original_url
      respond_to do |format|
        format.html { redirect_to(url)}
        format.js {}
      end
    else
      @error = "Please create a short url first"
      respond_to do |format|
        format.html {
          render :result
        }
      end
    end
  end


  private

  def random_string

    o = [('a'..'z')].map { |i| i.to_a }.flatten
    string = (0...36).map { o[rand(o.length)] }.join
    @random_string ||= string[5..12]
 
  end

  def small_url(random_string)

    credentials + random_string

  end

  def credentials
    @host ||= YAML.load_file("#{::Rails.root}/config/host.yml")[Rails.env]["host"]
  end

end
