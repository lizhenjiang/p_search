require 'rubygems'
require 'phashion' 
require 'pathname'
@path = Pathname.new(File.dirname(__FILE__)).realpath
@path_images = @path.to_s+'/images'
puts @path_images
def get_file_list(path)  
  Dir.entries(path).each do |sub|         
    if sub != '.' && sub != '..'  
      if File.directory?("#{path}/#{sub}") 
        @file_dir = sub   
        get_file_list("#{path}/#{sub}")  
      else 
        file = File.open("#{@path}/fingers/#{@file_dir}.txt",'a+') 
        puts "images/#{@file_dir}/#{sub}"+'----------'+Phashion::Image.new("#{path}/#{sub}").fingerprint.to_s
        file.puts "images/#{@file_dir}/#{sub}"+'----------'+Phashion::Image.new("#{path}/#{sub}").fingerprint.to_s
        file.close
      end  
    end  
  end  
end 

get_file_list(@path_images)

