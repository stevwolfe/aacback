require "net/http"
require "json"
require "openssl"

class User < ApplicationRecord
  # before_save :downcase_email
  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :messages
  has_secure_password
  has_many :crushes
  has_many :photos
  has_one :relationship_sought
  has_one :physical_information
  has_many :smileys
  has_many :visitors
  has_many :smileys
  has_many :favorites
  has_many :blockeds
  after_create :send_message_new_user, if: :is_real?
  after_create :welcoming_email, if: :is_real?
  after_create :create_members, if: :is_real?
  after_create :new_online_users, if: :is_real?
  geocoded_by :city
  after_validation :geocode




  # def age
  #   # Source http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  #   return nil if birthdate.nil?
  #   now = Time.now.utc.to_date
  #   now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  # end



  def is_real?
    real?
  end


  def create_members
    min_age = self.min_age
    response = HTTParty.post("https://aacdb.herokuapp.com/memberslist?zipcode=#{self.zip_code}&age_range=#{min_age}")

    response.each{|member|
      @user = User.create(real: false, password: '141614', city: member["city"])
      user_details = UserDetail.create(description: member["description"],marital_status: member["marital_status"],
          looking_exciting: member["anything_exciting"], looking_long: member["long_term"], looking_anything: member["open_anything"],
          looking_short: member["short_term"], looking_undecided: member["undecided"], looking_virtual: member["virtual"],
          hair_color: member["hair_color"], eye_color: member["eye_color"], smoker: member["smoker"], user_id: @user.id,
          anything_goes: member["anything_goes"], being_dominated: member["dominated"], dominating: member["dominate"],
          normal: member["normal"], threesome: member["threesome"], secret: member["secret"], active: member["active"],
          shy: member["shy"], sociable: member["sociable"], modest: member["modest"], fun: member["fun"], generous: member["generous"],
          spiritual: member["spiritual"], moody: member["moody"], relaxed: member["relaxed"], sensitive: member["sensitive"],
          aerobics: member["aerobics"], golf: member["golf"], martial_arts: member["martial_arts"], soccer: member["soccer"],
          walking: member["walking"], rugby: member["rugby"], swimming: member["swimming"], baseball: member["baseball"],
          cycling: member["cycling"], running: member["running"], tennis: member["tennis"], weight: member["weight"], basketball: member["basketball"],
          skiing: member["skiing"], volleyball: member["volleyball"], arts: member["arts"], cooking: member["cooking"], hiking: member["hiking"],
          networking: member["networking"], video_games: member["video_games"], book: member["book"], dining_out: member["dining_out"],
          movies: member["movies"], nightclubs: member["nightclubs"], religion: member["religion"], charities: member["charity"], museums: member["museum"],
          shopping: member["shopping"], wine: member["wine"], coffee: member["coffee"], gardening: member["gardening"],
          pets: member["pets"], being_blinded: member["being_blinded"], costume: member["costume"], role_playing: member["role_playing"],
          using_sex_toys: member["using_sex_toys"], unusual_places: member["unusual_places"], being_watched: member["being_watched"],
          willing_experiment: member["willing_experiment"], cultivated: member["cultivated"], imaginative: member["imaginative"], independent: member["independent"],
          mature: member["mature"], outgoing: member["outgoing"], self_confident: member["self_confident"], reliable: member["reliable"], sophisticated: member["sophisticated"],
          )
      @user.update(fake_users_id: self.id, username:member["username"],
                   user_details_id: user_details.id, photo: member["photos"][0],
                   age: member["age"], member_gender: self.gender_interest)
      if member["photos"].length > 0
        member["photos"].each {|photo|
          Photo.create(user_id: @user.id, remote_url: photo)
        }
      end
      @user.save
    }
  end
  handle_asynchronously :create_members, :priority => 20


  def welcoming_email
      #UserMailer.delay.welcome_email(self)
  end
  handle_asynchronously :welcoming_email, :priority => 40, :run_at => Proc.new { 30.seconds.from_now }

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def generate_email_token!
    self.reset_email_token = generate_token
    self.reset_email_sent_at = Time.now.utc
    save!
  end

  def send_message_new_user
    random_fake = User.where(fake_users_id: self.id ).order('RANDOM()').first
    #create conversation
    @user = self
    master = User.find_by(username: "admin")
    @conversation = Conversation.new()
    @conversation.users.push(@user, random_fake)
    @conversation.save
    initial_message = Conversation.new()
    initial_message.users.push(master)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ConversationSerializer.new(@conversation)
      ).serializable_hash
    NewConversationChannel.broadcast_to(@user, serialized_data)
    
    sleep 3
    @message = Message.new({text: "hello new user", user_id: random_fake.id, conversation_id: @conversation.id})
    @message.save()
    ConversationChannel.broadcast_to(@conversation, {message: @message})
    NewConversationAllChannel.broadcast_to(master, {
      type: "new_conversation",
      payload: {
        id: @conversation.id,
        title: @conversation.title,
        latest_message: @message,
        last_viewed: nil,
        new: true,
        users: @conversation.users.map do |u|
        {
        id: u.id,
        username: u.username,
        photo: u.photo
      }

    end
    },
    message: @message,
    new_fake: random_fake
  })


  end
  handle_asynchronously :send_message_new_user, :run_at => Proc.new { 70.seconds.from_now }



 def new_online_users

    fakes_created_today = User.where(real:false, fake_users_id: self.id).where("created_at >= ?",Date.today)
    all_fakes = User.where(real:false, fake_users_id: self.id).where("updated_at >= ?",Date.today)
    if fakes_created_today.length > 1
      @all_fakes = fakes_created_today
      @n_users = @all_fakes.length
      arr_rand_users = []
      randomn_users = (1 * @n_users).to_i.times{
        offset = rand(@n_users)
        @fake_user = @all_fakes.offset(offset).first
        arr_rand_users << @fake_user
      }
      arr_rand_users.uniq.each{|fake|
        today = Date.today.to_time
        tomorrow = Date.tomorrow.to_time
        log_in = Time.at((tomorrow.to_f - today.to_f)*rand + today.to_f)
        time_online = rand(120..360)
        log_out = log_in + (time_online * 60)

        fake.update(scheduled_log_in:log_in, scheduled_log_out: log_out)

        if log_in < Time.now && log_out > Time.now
          fake.update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_in > Time.now
          fake.delay(run_at: log_in).update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        end
      }
    elsif all_fakes.length > 1 && fakes_created_today.length == 0
      all_fakes.each{|fake|
        log_in = fake.scheduled_log_in ||  Date.today.beginning_of_day
        log_out = fake.scheduled_log_out ||  Date.today.beginning_of_day
        if log_in < Time.now && log_out > Time.now
          fake.update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_in > Time.now
          fake.delay(run_at: log_in).update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_out < Time.now && fake.online
          fake.update(online: false)
        end
      }
    else
      @all_fakes = User.where(real: false, fake_users_id: self.id)
      @n_users = @all_fakes.length
      arr_rand_users = []
      randomn_users = (1 * @n_users).to_i.times{
        offset = rand(@n_users)
        @fake_user = all_fakes.offset(offset).first
        arr_rand_users << @fake_user
      }
      arr_rand_users.uniq.each{|fake|
        today = Date.today.to_time
        tomorrow = Date.tomorrow.to_time
        log_in = Time.at((tomorrow.to_f - today.to_f)*rand + today.to_f)
        time_online = rand(60..260)
        log_out = log_in + (time_online * 60)

        fake.update(scheduled_log_in:log_in, scheduled_log_out: log_out)

        if log_in < Time.now && log_out > Time.now
          fake.update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_in > Time.now
          fake.delay(run_at: log_in).update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        end
      }
    end
  end
  handle_asynchronously :new_online_users, :priority => 50, :run_at => Proc.new { 40.seconds.from_now }



  def online_users

    fakes_created_today = User.where(real:false, fake_users_id: self.id).where("created_at >= ?",Date.today)
    all_fakes = User.where(real:false, fake_users_id: self.id).where("updated_at >= ?",Date.today)
    if fakes_created_today.length > 1
      @all_fakes = fakes_created_today
      @n_users = @all_fakes.length
      arr_rand_users = []
      randomn_users = (1 * @n_users).to_i.times{
        offset = rand(@n_users)
        @fake_user = @all_fakes.offset(offset).first
        arr_rand_users << @fake_user
      }
      arr_rand_users.uniq.each{|fake|
        today = Date.today.to_time
        tomorrow = Date.tomorrow.to_time
        log_in = Time.at((tomorrow.to_f - today.to_f)*rand + today.to_f)
        time_online = rand(60..260)
        log_out = log_in + (time_online * 60)

        fake.update(scheduled_log_in:log_in, scheduled_log_out: log_out)

        if log_in < Time.now && log_out > Time.now
          fake.update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_in > Time.now
          fake.delay(run_at: log_in).update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        end
      }
    elsif all_fakes.length > 100 && fakes_created_today.length == 0
      all_fakes.each{|fake|
        log_in = fake.scheduled_log_in ||  Date.today.beginning_of_day
        log_out = fake.scheduled_log_out ||  Date.today.beginning_of_day
        if log_in < Time.now && log_out > Time.now
          fake.update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_in > Time.now
          fake.delay(run_at: log_in).update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_out < Time.now && fake.online
          fake.update(online: false)
        end
      }
    else
      @all_fakes = User.where(real: false, fake_users_id: self.id)
      @n_users = @all_fakes.length
      arr_rand_users = []
      randomn_users = (1 * @n_users).to_i.times{
        offset = rand(@n_users)
        @fake_user = @all_fakes.offset(offset).first
        arr_rand_users << @fake_user
      }
      print "arr_rand_users.uniq"
      arr_rand_users.uniq.each{|fake|
        print "fake.id #{fake}"
        today = Date.today.to_time
        tomorrow = Date.tomorrow.to_time
        log_in = Time.at((tomorrow.to_f - today.to_f)*rand + today.to_f)
        time_online = rand(120..360)
        log_out = log_in + (time_online * 60)

        fake.update(scheduled_log_in:log_in, scheduled_log_out: log_out)

        if log_in < Time.now && log_out > Time.now
          fake.update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        elsif log_in > Time.now
          fake.delay(run_at: log_in).update(online: true)
          fake.delay(run_at: log_out).update(online: false)
        end
      }
    end
  end
  # handle_asynchronously :online_users, :priority => 50

  def update_new_email!(email)
    self.unconfirmed_email = email
    save
  end

  def self.email_used?(email)
    existing_user = find_by("email = ?", email)

    if existing_user.present?
      return true
    # else
    #   waiting_for_confirmation = find_by("unconfirmed_email = ?", email)
    #   return waiting_for_confirmation.present? && waiting_for_confirmation.confirmation_token_valid?
    end
  end


  def generate_token
    SecureRandom.hex(10)
  end

  # User.where(real: false).each {|user|
  #   p "User: #{user.username}: scheduled log in #{user.scheduled_log_in} and scheduled log out #{user.scheduled_log_out}"
  # }

end
