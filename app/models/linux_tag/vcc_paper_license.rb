class LinuxTag::VccPaperLicense < VccDatabase

  self.table_name = 'type_licenses'

  has_and_belongs_to_many :papers, class_name: "LinuxTag::VccPaper", 
    association_foreign_key: "paper", join_table: "licenses", foreign_key: "license" 
end

