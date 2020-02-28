class Api::V1::UserDetailsController < ApplicationController
  skip_before_action :authorized

  def get_details

    user_id = params[:userId]
    @user_details = UserDetail.find_by(user_id: user_id)
    @user = User.find(user_id)

    user_json = {
      user: @user,
      user_details: @user_details
    }

    render json: user_json


  end

  def update_details


    user_id = params[:userId]
    description = params[:description]
    birthday = params[:birthday]
    marital_status = params[:maritalStatus]
    height = params[:height]
    hair = params[:hair]
    eye = params[:eye]
    smoker = params[:smoker]
    exciting = params[:exciting]
    long = params[:long]
    anything = params[:anything]
    short = params[:short]
    undecided = params[:undecided]
    virtual = params[:virtual]
    anything_goes = params[:anythingGoes]
    being_dominated = params[:beingDominated]
    dominating = params[:dominating]
    normal = params[:normal]
    threesome = params[:threesome]
    secret = params[:secret]
    active = params[:active]
    shy = params[:shy]
    sociable = params[:sociable]
    modest = params[:modest]
    fun = params[:fun]
    generous = params[:generous]
    spiritual = params[:spiritual]
    moody = params[:moody]
    relaxed = params[:relaxed]
    sensitive = params[:sensitive]
    aerobics = params[:aerobics]
    golf = params[:golf]
    martial_arts = params[:martialArts]
    soccer = params[:soccer]
    walking = params[:walking]
    rugby = params[:rugby]
    swimming = params[:swimming]
    baseball = params[:baseball]
    cycling = params[:cycling]
    running = params[:running]
    tennis = params[:tennis]
    weight = params[:weight]
    basketball = params[:basketball]
    dance = params[:dance]
    skiing = params[:skiing]
    volleyball = params[:volleyball]
    bowling = params[:bowling]
    arts = params[:arts]
    cooking = params[:cooking]
    hiking = params[:hiking]
    networking = params[:networking]
    video_games = params[:videoGames]
    book = params[:book]
    dining_out = params[:diningOut]
    movies = params[:movies]
    nightclubs = params[:nightclubs]
    religion = params[:religion]
    charities = params[:charities]
    museums = params[:museums]
    shopping = params[:shopping]
    wine = params[:wine]
    coffee = params[:coffee]
    gardening = params[:gardening]
    pets = params[:pets]
    music = params[:music]
    hockey = params[:hockey]
    being_blinded = params[:beingBlind]
    costume = params[:costume]
    role_playing = params[:rolePlaying]
    using_sex_toys = params[:usingSexToys]
    unusual_places = params[:unusualPlaces]
    being_watched = params[:beingWatched]
    willing_experiment = params[:willingExperiment]
    cultivated = params[:cultivated]
    imaginative = params[:imaginative]
    independent = params[:independent]
    mature = params[:mature]
    outgoing = params[:outgoing]
    self_confident = params[:selfConfident]
    reliable = params[:reliable]
    sophisticated = params[:sophisticated]
    feet = params[:feet]
    inches = params[:inches]

    if UserDetail.where(user_id: user_id).length == 0
      UserDetail.create(user_id: user_id)
    end

    user = UserDetail.where(user_id: user_id).last

    user_instance = User.find(user_id)

    if description
      user.update(description: description)
    elsif inches
      user.update(inches: inches)
    elsif feet
      user.update(feet: feet)
    elsif sophisticated
      user.update(sophisticated: sophisticated)
    elsif reliable
      user.update(reliable: reliable)
    elsif self_confident
      user.update(self_confident: self_confident)
    elsif outgoing
      user.update(outgoing: outgoing)
    elsif mature
      user.update(mature: mature)
    elsif independent
      user.update(independent: independent)
    elsif imaginative
      user.update(imaginative: imaginative)
    elsif cultivated
      user.update(cultivated: cultivated)
    elsif willing_experiment
      user.update(willing_experiment: willing_experiment)
    elsif being_watched
      user.update(being_watched: being_watched)
    elsif unusual_places
      user.update(unusual_places: unusual_places)
    elsif role_playing
      user.update(role_playing: role_playing)
    elsif costume
      user.update(costume: costume)
    elsif being_blinded
      user.update(being_blinded: being_blinded)
    elsif music
      user.update(music: music)
    elsif pets
      user.update(pets: pets)
    elsif gardening
      user.update(gardening: gardening)
    elsif coffee
      user.update(coffee: coffee)
    elsif wine
      user.update(wine: wine)
    elsif shopping
      user.update(shopping: shopping)
    elsif museums
      user.update(museums: museums)
    elsif charities
      user.update(charities: charities)
    elsif religion
      user.update(religion: religion)
    elsif nightclubs
      user.update(nightclubs: nightclubs)
    elsif movies
      user.update(movies: movies)
    elsif dining_out
      user.update(dining_out: dining_out)
    elsif book
      user.update(book: book)
    elsif video_games
      user.update(video_games: video_games)
    elsif networking
      user.update(networking: networking)
    elsif hiking
      user.update(hiking: hiking)
    elsif cooking
      user.update(cooking: cooking)
    elsif arts
      user.update(arts: arts)
    elsif rugby
      user.update(rugby: rugby)
    elsif hockey
      user.update(hockey: hockey)
    elsif bowling
      user.update(bowling: bowling)
    elsif volleyball
      user.update(volleyball: volleyball)
    elsif skiing
      user.update(skiing: skiing)
    elsif dance
      user.update(dance: dance)
    elsif basketball
      user.update(basketball: basketball)
    elsif weight
      user.update(weight: weight)
    elsif tennis
      user.update(tennis: tennis)
    elsif running
      user.update(running: running)
    elsif cycling
      user.update(cycling: cycling)
    elsif baseball
      user.update(baseball: baseball)
    elsif swimming
      user.update(swimming: swimming)
    elsif rugby
      user.update(rugby: rugby)
    elsif walking
      user.update(walking: walking)
    elsif soccer
      user.update(soccer: soccer)
    elsif golf
      user.update(golf: golf)
    elsif sensitive
      user.update(sensitive: sensitive)
    elsif martial_arts
      user.update(martial_arts: martial_arts)
    elsif aerobics
      user.update(aerobics: aerobics)
    elsif relaxed
      user.update(relaxed: relaxed)
    elsif moody
      user.update(moody: moody)
    elsif spiritual
      user.update(spiritual: spiritual)
    elsif generous
      user.update(generous: generous)
    elsif fun
      user.update(fun: fun)
    elsif modest
      user.update(modest: modest)
    elsif sociable
      user.update(sociable: sociable)
    elsif shy
      user.update(shy: shy)
    elsif active
      user.update(active: active)
    elsif secret
      user.update(secret: secret)
    elsif threesome
      user.update(threesome: threesome)
    elsif normal
      user.update(normal: normal)
    elsif dominating
      user.update(dominating: dominating)
    elsif being_dominated
      user.update(being_dominated: being_dominated)
    elsif anything_goes
      user.update(anything_goes: anything_goes)
    elsif birthday
      user.update(birthday: birthday)
      user_instance.update(birthdate: birthday)
    elsif marital_status
      user.update(marital_status: marital_status)
    elsif height
      user.update(height: height)
    elsif hair
      user.update(hair_color: hair)
    elsif eye
      user.update(eye_color: eye)
    elsif smoker
      user.update(smoker: smoker)
    elsif exciting
      user.update(looking_exciting: exciting)
    elsif long
      user.update(looking_long: long)
    elsif anything
      user.update(looking_anything: anything)
    elsif short
      user.update(looking_short: short)
    elsif undecided
      user.update(looking_undecided: undecided)
    elsif virtual
      user.update(looking_virtual: virtual)
    end


    render json: {user_details: user}
  end
end
