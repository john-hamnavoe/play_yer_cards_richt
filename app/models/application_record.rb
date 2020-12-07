class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.import(file, user_id)
    import_errors = []
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      record = find_by(id: row["id"]) || new
      begin
        record.attributes = row.to_hash
      rescue ActiveModel::UnknownAttributeError => e
        import_errors.push({ row: i, error: e.message })
      end
      record.user_id = user_id
      record.save! if record.valid?
      import_errors.push({ row: i, error: record.errors.full_messages.join(",") }) unless record.valid?
    end

    import_errors
  end
end
