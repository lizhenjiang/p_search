require 'rubygems'
require 'phashion' 
require 'pathname'
require 'open-uri'
require 'net/http'
require 'ostruct' 
class MyPhashController < ApplicationController
  def index
  end

  def search
    @similars = []
    if params[:image_url].to_s.include?(".jpg") || params[:image_url].to_s.include?(".png")
      image_name = params[:image_url].split('/')[-1]
      @image = "#{Rails.root}/public/images/upload/#{image_name}"
      data=open(params[:image_url]){|f|f.read}
      open("#{Rails.root}/public/images/upload/#{image_name}","wb"){|f|f.write(data)}
      fingerprint = Phashion::Image.new("#{Rails.root}/public/images/upload/#{image_name}").fingerprint
      @similars = get_file_list("#{Rails.root}/public/fingers", fingerprint)
    end

    if params[:image] != nil
      @image = uploadFile(params[:image]['image'])
      fingerprint = Phashion::Image.new(@image).fingerprint
      @similars = get_file_list("#{Rails.root}/public/fingers", fingerprint)
    end
  end
  
end
