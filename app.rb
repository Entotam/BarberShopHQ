#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: 'barbershop.db' }

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3 }
	validates :phone, presence: true, numericality: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact <ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	
	erb :index
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do
	@c = Client.new params[:client]
	if @c.save
		erb "Вы записались!"
	else
		@error = @c.errors.full_messages.first
	end

	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message_contacts]

	contact = Contact.new
		contact.email = @email
		contact.message = @message
	contact.save

	erb :contacts
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/booking' do
	@clients = Client.all
	erb :booking
end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
end
