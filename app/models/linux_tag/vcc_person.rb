class LinuxTag::VccPerson < VccDatabase

  self.table_name = 'person'

  has_many :authorships, class_name: "LinuxTag::VccAuthorship", foreign_key: "author"
  has_many :papers, through: :authorships
  has_and_belongs_to_many :sessions, class_name: "LinuxTag::VccTrack",
    association_foreign_key: "track", join_table: "sessionchair", foreign_key: "person"

  def frab_person
    my_user = User.new( 
      email: email 
    )
    #Todo: some/all? users do not save
    my_user.save
    result = Person.new(
      first_name:            firstname, 
      last_name:             lastname, 
      public_name:           username,
      user:                  my_user,
      email:                 email, 
      abstract:              bio, 
    # Todo: only speakers:
      #call_for_papers:       conference.call_for_papers
    )
    return result
  end
  
end

