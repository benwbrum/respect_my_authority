json.array!(@analyses) do |analysis|
  json.extract! analysis, :id, :data_provider, :subject, :q, :status, :result_count
  json.url analysis_url(analysis, format: :json)
end
