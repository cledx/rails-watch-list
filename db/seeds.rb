
require 'open-uri'
require "stringio"

puts "Cleaning the DB...."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all


# the Le Wagon copy of the API
puts "Creating movies.... \n"
(1..5).to_a.each do |num|
  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{num}"
  response = JSON.parse(URI.open(url).read)
  
  response['results'].each do |movie_hash|
    puts "...creating the movie #{movie_hash['title']}..."
    puts
    # create an instance with the hash
    Movie.create!(
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path'],
      rating: movie_hash['vote_average'],
      title: movie_hash['title'],
      overview: movie_hash['overview']
    )
  end
end
puts "... created #{Movie.count} movies."

puts "^v" * 30

puts "Creating lists...\n"

MOVIE_COMMENTS = ["Absolutely loved it from start to finish.",
  "The visuals were stunning but the story felt thin.",
  "One of the best movies I’ve seen this year.",
  "Way too long for what it was trying to say.",
  "The acting saved an otherwise boring plot.",
  "Couldn’t take my eyes off the screen.",
  "I almost walked out halfway through.",
  "Soundtrack was incredible.",
  "Great concept but poorly executed.",
  "Would definitely watch it again.",
  "The ending ruined it for me.",
  "Solid popcorn movie.",
  "Way better than I expected.",
  "Felt like three different movies mashed together.",
  "The villain was fantastic.",
  "Plot holes everywhere.",
  "Beautiful cinematography.",
  "Not worth the ticket price.",
  "Really emotional by the end.",
  "I was bored most of the time.",
  "The pacing was perfect.",
  "Characters were painfully flat.",
  "One of those movies that sticks with you.",
  "Total waste of time.",
  "Surprisingly funny.",
  "Took itself way too seriously.",
  "Great for a lazy Sunday watch.",
  "Dialogue felt unnatural.",
  "Amazing world building.",
  "Could have been much shorter.",
  "The action scenes were top tier.",
  "Story made no sense.",
  "Loved the character development.",
  "Predictable but enjoyable.",
  "Nothing new or exciting.",
  "Kept me hooked throughout.",
  "The twist was obvious.",
  "Fantastic performances all around.",
  "Not as good as the trailer made it seem.",
  "Would recommend to friends.",
  "Fell asleep halfway through.",
  "Really well directed.",
  "The script needed another draft.",
  "Heartwarming and fun.",
  "Too many clichés.",
  "Visually impressive.",
  "Emotionally empty.",
  "Strong start, weak ending.",
  "Great chemistry between the leads.",
  "Overhyped in my opinion.",
  "Loved every minute.",
  "Felt rushed.",
  "Brilliant storytelling.",
  "Confusing but interesting.",
  "A true masterpiece.",
  "Just okay.",
  "Nothing memorable.",
  "Exceeded my expectations.",
  "Dragged on forever.",
  "Funny but forgettable.",
  "Dark and powerful.",
  "Didn’t live up to the reviews.",
  "Compelling from beginning to end.",
  "Messy plot.",
  "Beautifully shot.",
  "The characters felt real.",
  "Too predictable.",
  "Really fun experience.",
  "Disappointing overall.",
  "Great soundtrack and atmosphere.",
  "Couldn’t connect with it.",
  "Very engaging.",
  "Poor character choices.",
  "Loved the message.",
  "Execution was weak.",
  "Solid acting throughout.",
  "Bad editing ruined it.",
  "Kept me entertained.",
  "Not worth rewatching.",
  "Fantastic visuals.",
  "Shallow storytelling.",
  "Great balance of humor and drama.",
  "Overly dramatic.",
  "Really inspiring.",
  "Felt empty.",
  "Loved the cast.",
  "Terrible writing.",
  "Well worth watching.",
  "Painfully slow.",
  "Fun adventure film.",
  "Too many plot conveniences.",
  "Great emotional payoff.",
  "Missed its potential.",
  "Very creative.",
  "Generic story.",
  "Loved the atmosphere.",
  "Hard to follow at times.",
  "Beautiful ending.",
  "Didn’t care about the characters.",
  "Strong performances.",
  "Boring and predictable.",
  "Really enjoyable experience.",
  "Not as smart as it thinks it is.",
  "Amazing direction.",
  "Weak screenplay.",
  "Totally worth it.",
  "Left me disappointed.",
  "A joy to watch.",
  "Forgettable but fine.",
  "Loved the visuals and music.",
  "Story fell apart halfway.",
  "Fantastic character arcs.",
  "Overlong and dull",
  "Great fun from start to finish.",
  "Emotionally gripping.",
  "Poorly paced.",
  "Wouldn’t watch again.",
  "Really memorable scenes.",
  "Too much filler.",
  "Strong story and acting."]


movies = Movie.all
["Greatest Movies", "Mom's Faves", "Worst Movies Ever", "Doug's Secret Gems", "Try to Find the Connection"].each do |list_name| 
  puts "Making #{list_name} list..."
  list = List.new(name: list_name)
  list.save
  rand(3..7).times do
    rand_movie = movies.sample
    puts "    Bookmarking #{rand_movie.title}..."
    rand_comment = MOVIE_COMMENTS.sample
    puts "      with comment: #{rand_comment}"
    Bookmark.create(
      comment: rand_comment,
      list_id: list.id,
      movie_id: rand_movie.id
    )
  end
end
    