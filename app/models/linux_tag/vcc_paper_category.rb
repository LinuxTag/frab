class LinuxTag::VccPaperCategory < VccDatabase

  self.table_name = 'category'

  has_many :papers, class_name: "LinuxTag::VccPaper", foreign_key: "category"

end

