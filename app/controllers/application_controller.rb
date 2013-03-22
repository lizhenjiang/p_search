class ApplicationController < ActionController::Base
  protect_from_forgery
  def uploadFile(file)
    if !file.original_filename.empty?
      @filename=getFileName(file.original_filename)
      File.open("#{Rails.root}/public/images/upload/#{@filename}", "wb") do |f|
        f.write(file.read)
      end
      return "#{Rails.root}/public/images/upload/#{@filename}"
    end
  end
  
  def getFileName(filename)
    if !filename.nil?
      return filename
    end
  end
  
  def get_file_list(path, fingerprint, limit = 15) 
    similars = []
    Dir.entries(path).each do |sub|         
      if sub != '.' && sub != '..'  
        if File.directory?("#{path}/#{sub}")    
          #get_file_list("#{path}/#{sub}")  
        else 
          file = File.open("#{path}/#{sub}",'r') 
          file.each_line do |line|
            fingerprint2 = line.split('----------')[-1].to_i
            if Phashion.hamming_distance(fingerprint, fingerprint2) < limit
              similar = OpenStruct.new
              similar.picture = line.split('----------')[0]
              similar.distance = Phashion.hamming_distance(fingerprint, fingerprint2)
              similars << similar
            end
          end
          file.close
        end  
      end  
    end
    return sort_by_distance(similars)
  end
  
  def sort_by_distance(similars)
    len=similars.length  
    for i in 0..len-1  
        t=similars[i]  
        for j in 0..i  
            if similars[j].distance > t.distance  
                similars[j],t=t,similars[j]  
            end
        end
        similars[i]=t  
    end  
    return similars 
  end
end
