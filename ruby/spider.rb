# encoding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http' 

$dir = "luxst111"  
Dir.mkdir $dir if !File.directory?$dir
url="http://www.luxst.com/cate-23-b0-min0-max0-2-0-0-%E8%BF%9E%E8%A1%A3%E8%A3%99-.html" 

def get_images_perpage(url)
  page = Nokogiri::HTML(open(url))   
  page.css('div.bblist img').each do |img|
    puts img["src"]
    data=open(img["src"]){|f|f.read}
    open($dir+'/'+Time.now.strftime("%Y-%m-%d_%H:%M:%S_")+img["src"].split('/')[-1],"wb"){|f|f.write(data)}
  end
  if page.css('div.right_page a')[-1].text.include?('下一页')
    nextpage = 'http://www.luxst.com'+page.css('div.right_page a')[-1]["href"]
    puts 'NEW PAGE:'+nextpage
    get_images_perpage(nextpage)
  end  
end

get_images_perpage(url)




