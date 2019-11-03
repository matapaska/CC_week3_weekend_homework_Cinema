require_relative('../models/ticket')
require_relative('../models/film')
require_relative('../models/customer')

require('pry-byebug')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => 'Tom Cat',
  'funds' => '100'})
customer2 = Customer.new({'name' => 'Lion King',
  'funds' => '80'})
  customer1.save()
  customer2.save()
  customers = Customer.all

film1 = Film.new({'title' => 'About Cats',
  'price' => '10'})
film2 = Film.new({'title' => 'About Lions',
  'price' => '20'})
film1.save
film2.save
films = Film.all

ticket1 = Ticket.new({'customer_id' => customer1.id,
  'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id,
  'film_id' => film2.id})
ticket1.save()
ticket2.save()

tickets = Ticket.all


binding.pry

nil
