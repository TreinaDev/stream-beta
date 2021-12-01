module Utils
  def self.concat_search(records)
    records.flatten.reject(&:inactive?).uniq
  end
end
