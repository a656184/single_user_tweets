get '/' do
  erb :index
end

get '/:username' do
	refresh_tweets_for_user(params[:username])
	erb :index
end

post '/:username' do
	Client.update(params[:tweet])
	refresh_tweets_for_user(params[:username])
  erb :tweet_list, layout: false
end


def refresh_tweets_for_user(username)
	@user = TwitterUser.find_or_create_by_username(username)

	@time_past = @user.tweets_stale?

	if @time_past  
		@user.fetch_tweets!
	end

	@tweets = @user.tweets(10).reorder('updated_at').reverse_order
end