# encoding: utf-8
namespace :vcc do
  namespace :lt13 do
    desc "import vcc data from 2013"
    task :import => :environment do
      ActiveRecord::Base.transaction do
        conference = Conference.new( 
          acronym: "lt2013", 
          title: "LinuxTag 2013", 
          timezone: "Berlin", 
          timeslot_duration: 15, 
          default_timeslots: 4, 
          max_timeslots: 20, 
          feedback_enabled: false, 
          created_at: "2012-08-03 14:35:49", 
          email: "info@linuxtag.org", 
          program_export_base_url: "http://conference.linuxtag.org",
          schedule_version: "1",
          schedule_public: false,
          color: "1926e3", 
          ticket_type: nil )
        (LinuxTag::VccEvent.order(:date).first.date .. LinuxTag::VccEvent.order(:date).last.date).each do |vccday|
          conference.days << Day.new(
            start_date: vccday.to_datetime.change(hour: 6, minute: 0), # UTC
            end_date:   vccday.to_datetime.change(hour: 20, minute: 0) # UTC
          )
        end
        conference.save!

        cfp = CallForPapers.new( 
          start_date: "2013-01-01", 
          end_date: "2013-03-01", 
          hard_deadline: "2013-04-01", 
          welcome_text: "Call for Papers", 
          conference: conference, 
          info_url: "http://conference.linuxtag.org", 
          contact_email: "conference@linuxtag.org"
        )
        cfp.save!

        puts 'import people'
        frab_people = Hash.new
        LinuxTag::VccPerson.find_each(:batch_size => 1000) do |vcc_person|
          frab_person = vcc_person.frab_person
          # Todo: what to do with vcc people without email?
          frab_person.email = 'help_i_have_no_mail@linuxtag.org' if vcc_person.email.blank?
          frab_person.save!
          frab_people[vcc_person] = frab_person
          print frab_person.persisted? ? '.' : 'F'
        end

        puts
        puts 'import rooms'
        LinuxTag::VccRoom.all.each do |r| 
          Room.create(r.frab_room_attributes(conference))
          print '.'
        end

        puts
        puts 'import papers'
        LinuxTag::VccPaper.find_each(:batch_size => 1000) do |e|
          e.frab_event(conference)
          print '.'
        end

        puts
        puts 'add role coordinator to vcc-sessionchairs '
        frab_people.each_key do |vcc_person| 
          begin 
            if vcc_person.sessions.any?
              frab_person = Person.find_by_public_name(vcc_person.username)
              frab_person.user.role = "coordinator"
              frab_person.user.save!
              print '+'
            else
              print '.'
            end
          rescue
            print 'F'
            #puts vcc_person.to_yaml
            #puts frab_person.to_yaml
            #puts frab_person.try(:user).to_yaml
          end
        end
      end
    end
  end
end

