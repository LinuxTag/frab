class LinuxTag::VccPerson < VccDatabase

  establish_connection("lt13_development")
  self.table_name = 'person'

  has_many :authorships, class_name: "LinuxTag::VccAuthorship", foreign_key: "author"
  has_many :papers, through: :authorships
  has_and_belongs_to_many :sessions, class_name: "LinuxTag::VccTrack",
    association_foreign_key: "track", join_table: "sessionchair", foreign_key: "person"

  def frab_person(conference = nil)
    p = Person.new(
      first_name:            firstname, 
      last_name:             lastname, 
      public_name:           username,
      user:                  User.new( email: email ),
      email:                 email, 
      abstract:              bio, 
    )
    if conference
      p.user.role = "coordinator"
    end
    p
    #@user.call_for_papers = @conference.call_for_papers
  end
  
end

