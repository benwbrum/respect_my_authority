class Analysis < ActiveRecord::Base
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

end
