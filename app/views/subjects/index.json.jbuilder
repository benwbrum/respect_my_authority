json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :items, :has_loc_sh, :loc_sh_alias, :loc_sh_url, :analysis_id
  json.url subject_url(subject, format: :json)
end
