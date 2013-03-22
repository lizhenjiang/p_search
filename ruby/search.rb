require 'rubygems'
require 'phashion' 
require 'pathname'
@path = Pathname.new(File.dirname(__FILE__)).realpath
@path_images = @path.to_s+'/fingers'
@fingerprint1 = Phashion::Image.new("1.jpg").fingerprint

def get_file_list(path) 
  Dir.entries(path).each do |sub|         
    if sub != '.' && sub != '..'  
      if File.directory?("#{path}/#{sub}")    
        #get_file_list("#{path}/#{sub}")  
      else 
        file = File.open("#{path}/#{sub}",'r') 
        file.each_line do |line|
          fingerprint2 = line.split('----------')[-1].to_i
          puts line.split('----------')[-1] if Phashion.hamming_distance(@fingerprint1, fingerprint2) < 15
        end
        file.close
      end  
    end  
  end  
end 

get_file_list(@path_images)

