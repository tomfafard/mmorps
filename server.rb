require "sinatra"
require 'pry'

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}


get '/index' do


  if session[:visit_count].nil?
    session[:user_score] = 0
    session[:computer_score] = 0
    session[:visit_count] = 1
  else
    session[:visit_count] += 1
  end

  erb :index
end

post '/choice' do

  comp_choices = ["Rock","Paper","Scissors"]
  @comp_selection = comp_choices.sample

  @user_selection = params[:choice]

  #Tie
  if @user_selection == @comp_selection
    @result = "Tie!"

  #Paper Wins
  elsif @user_selection == "Rock" && @comp_selection == "Paper"
    @result = "Computer Scored!"
    session[:computer_score] += 1
  elsif @user_selection == "Paper" && @comp_selection == "Rock"
    @result = "You Scored!"
    session[:user_score] += 1

  #Rock Wins
  elsif @user_selection == "Scissors" && @comp_selection == "Rock"
    @result = "Computer Scored!"
    session[:computer_score] += 1
  elsif @user_selection == "Rock" && @comp_selection == "Scissors"
    @result = "You Scored!"
    session[:user_score] += 1

  #Scissors Wins
  elsif @user_selection == "Paper" && @comp_selection == "Scissors"
    @result = "Computer Scored!"
    session[:computer_score] += 1
  elsif @user_selection == "Scissors" && @comp_selection == "Paper"
    @result = "You Scored!"
    session[:user_score] += 1
  end

  session[:result] = @result
  session[:comp_selection] = @comp_selection
  session[:user_selection] = @user_selection

  redirect '/index'
end

get '/play_again' do
  session.clear
  redirect '/index'
end
