user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan', 'Vincent Crabbe', 'Gregory Goyle','Lavender Brown','Katie Bell','Parvati Patil','Dennis Creevey','Eloise Midgen','Ritchie Coote','Jack Sloper','Victoria Frobisher','Geoffrey Hooper','Andrew Kirke','Demelza Robins','Cormac McLaggen','Neville Longbottom','Ginny Weasley','Romilda Vane','Natalie McDonald','Jimmy Peakes','Euan Abercrombie','Mary MacDonald','Penelope Clearwater','Roger Davies','Eddie Carmichael','Cho Chang','Marietta Edgecombe','Mandy Brocklehurst','Michael Corner','Stephen Cornfoot','Kevin Entwhistle','Anthony Goldstein','Su Li','Morag McDougal','Padma Patil','Lisa Turpin','Luna Lovegood','Orla Quirke','Stewart Ackerley','Susan Bones','Eleanor Branstone','Owen Cauldwell','Justin Finch-Fletchley','Wayne Hopkins','Megan Jones','Laura Madley','Kevin Whitby','Rose Zeller','Terence Higgs','Adrian Pucey','Tracey Davis','Daphne Greengrass','Theodore Nott','Astoria Greengrass','Malcolm Baddock','Graham Pritchard']
course_names = ['Muggle Studies','Potions','Transfiguration','Defense Against the Dark Arts','Charms','Herbology','Care of Magical Creatures','History of Magic','Divination']

# Generate sample artists
users_count = 0
user_names.each do |user_name|
  User.create! do |a|
    a.name = artist_name
    a.location = location_names.sample
    a.local = [true,false].sample
    a.website = "http://#{artist_name.parameterize}.local"
    a.twitter = artist_name.parameterize
    a.youtube = artist_name.gsub(/\s/,'')
  end
  artists_count += 1
end
puts "Generated #{artists_count} sample artists"

# Generate sample venues
venues_count = 0
venue_names.each do |venue_name|
  Venue.create! do |v|
    v.name = venue_name
    v.website = "http://#{venue_name.parameterize}.local"
    v.address = "123 Main St, #{location_names.sample}"
  end
  venues_count += 1
end
puts "Generated #{venues_count} sample venues"

# Generate sample events
events_count = 0
venues = Venue.all
artists = Artist.all
(1..60).each do |n|
  (1..3).to_a.sample.times do
    starts_at_date = Date.today + n.days
    starts_at_time = (5..11).to_a.sample
    performers = artists.sample(1 + rand(3))
    Event.create! do |e|
      e.venue = venues.sample
      e.performances.new(:artist_id => performers.first.id)
      (performers - [performers.first]).each do |performer|
        e.performances.new(:artist_id => performer.id, :type => Performance::TYPES.sample)
      end
      e.starts_at_date = starts_at_date
      e.doors_open_at_time = "#{starts_at_time - 1} pm" if [true,false].sample
      e.starts_at_time = "#{starts_at_time} pm"
      e.ends_at_time = "#{starts_at_time + (1..3).to_a.sample % 12} pm" if [true,false].sample
      e.reviewed_at = Time.now
      e.age_restriction = Event::AGE_RESTRICTIONS.sample
    end
    events_count += 1
  end
end
puts "Generated #{events_count} sample events"