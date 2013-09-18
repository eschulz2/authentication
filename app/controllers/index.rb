
enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/private' do
  if session[:message] == "logged_in"
    erb :private
  else
    redirect to('/')
  end

end


post '/login' do
  # receive the user's input
  # if valid
  # => create user session
  # => redirect to /private
  # else
  # => send them back home, saying they had an invalid login
  if User.authenticate(params[:email], params[:password])
    session[:message] = "logged_in"
    redirect to('/private')
  else
    @message = "Email or Password invalid"
    erb :index
  end
end

post '/create' do
  if User.create(params[:info]).valid?
    # create a user session
    # then send them to the private page
    session[:message] = "logged_in"
    redirect to('/private')
  else
    @message = "That email already exists"
    erb :index
  end

end
