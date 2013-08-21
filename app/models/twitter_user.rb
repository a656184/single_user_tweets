class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def check_tweets(tweet)
    return false if tweets.first.nil?
    tweets.last.content == tweet.text
  end

  def fetch_tweets!

    new_tweets = []

    Client.user_timeline(username).each do |tweet|  
      unless check_tweets(tweet)
        new_tweets << tweet.text
      else
        break
      end
    end
    
    new_tweets.reverse.each do |tweet_text|
      tweets.create(content: tweet_text)
    end

  end
  

  def tweets_stale?
    unless self.tweets.first.nil?
      Time.now - (tweets.first.updated_at) > (20)
    else
      true
    end
  end


end
