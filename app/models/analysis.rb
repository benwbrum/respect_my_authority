class Analysis < ActiveRecord::Base
  require 'open-uri'
  has_many :subjects

  API_KEY = '8961ed330070f6ff31915bf4aafe9eb6'

  def fetch_dpla
    self.status='querying DPLA'
    self.save!

    
    query = DPLA::Query.new(:api_key => API_KEY, 'q' => self.q, 'provider.name' => self.data_provider)
    # try query.next_page
    self.result_count=query.response['count']
    self.status='reading DPLA results'
    self.save!
    
    
    query.each do |results|
      results.each do |result|
        sourceResource = result["sourceResource"]
        if sourceResource
          subject_array = sourceResource["subject"]
          if subject_array
            subject_array.each do |subject_hash|
              subject_name = subject_hash["name"]
              subject = self.subjects.where(:name => subject_name).first || Subject.new(:analysis => self, :name => subject_name)
              subject.items += 1
              subject.save!
            end
              
          end
        end
      end
    end
    
    self.status='processing DPLA results'
    self.save!

  end

  def fetch_loc
    self.subjects.each do |subject|
      # http://id.loc.gov/authorities/label/orchids
      # ERB::Util.url_encode
      subject_name = subject.name
      subject_name = subject.name.split("--")[0] if subject.name.match(/--/)
      url = "http://id.loc.gov/authorities/label/" + ERB::Util.url_encode(subject_name)
      begin
        page = open(url)
        if page
          if page.status[0].to_i == 200
            subject.loc_sh_url = page.meta["x-uri"]
            subject.has_loc_sh = true
          end
        else
          subject.has_loc_sh = false          
        end
      rescue OpenURI::HTTPError 
        subject.has_loc_sh = false        
      end
      subject.save!
#      binding.pry      
    end
  end



end
