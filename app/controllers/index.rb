get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  
  @user = TwitterUser.find_or_create_by_username(params[:username])
  
  @time_past = @user.tweets_stale?
  
  if @time_past  
    @user.fetch_tweets!
  end

  @tweets = @user.tweets(10).reorder('updated_at').reverse_order
  erb :index
  
end


