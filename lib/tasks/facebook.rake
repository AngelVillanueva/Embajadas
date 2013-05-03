namespace :facebook do
  desc "Off-dyno tasks related with Facebook"

  @koala = Koala::Facebook::TestUsers.new({app_id: FACEBOOK_CONFIG['app_id'], secret: FACEBOOK_CONFIG['app_secret']})

  task create_users: :environment do
    10.times do
      name = Faker::Name.name
      email = Faker::Internet.email name
      new = @koala.create( true, "email, read_stream", {name: name, email: email, password: "foobar"} )
      puts new
    end
  end

  task create_test_ambassadors: :environment do
    list = @koala.list
    create_ambassadors list
    puts "First page ready, go to the next one"
    create_ambassadors list.next_page 
    puts "Second page also ready. Done!"
  end

  task delete_users: :environment do
    @koala.delete_all
  end


  task make_friends: :environment do
    ambassadors = Ambassador.where("provider = :provider and oauth_expires_at > :expires", provider: "facebook", expires: Time.now  )
    ambassadors.each do |ambassador|
      random_ambassador = Ambassador.offset(rand(Ambassador.count)).where("provider = :provider and oauth_expires_at > :expires", provider: "facebook", expires: Time.now  ).each do |potential_friend|
        friends = @koala.befriend( {id: ambassador.uid, access_token: ambassador.oauth_token}, {id: potential_friend.uid, access_token: potential_friend.oauth_token} )
      end
    end
  end

  task update_friends: :environment do
    ambassadors = Ambassador.where("provider = :provider and oauth_expires_at > :expires", provider: "facebook", expires: Time.now  )
    ambassadors.each do |ambassador|
      puts "#{ambassador.name} tiene: #{ambassador.fb_friends_count} amigos"
    end
  end

  task fb_all: [:update_friends]

  desc 'Alias'
  task update: 'fb_all'

  


  def create_ambassadors list
    users = list
    users.each_with_index do |user, index|
      @k = Koala::Facebook::API.new user["access_token"]
      me = @k.get_object "me"
      ambassador = Ambassador.new
      ambassador.name = me["name"]
      ambassador.email = me["email"]
      ambassador.provider = "facebook"
      ambassador.uid = me["id"]
      ambassador.oauth_token = user["access_token"]
      ambassador.save!
      ambassador.extend_fb_token
      puts "#{index} created"
    end
  end
end