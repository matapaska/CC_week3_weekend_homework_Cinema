require_relative("../db/sql_runner")
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers(name, funds)
      VALUES($1, $2)
      RETURNING id"
      values = [@name, @funds]
      customer = SqlRunner.run(sql, values)[0]
      @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds)
    = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_info = SqlRunner.run(sql, values)
    return film_info.map{|film| Film.new(film)}
  end

  def deducting_film_price()
    films = self.films()
    prices = films.map{|film| film.price}
    total_cost = prices.sum
    return @funds - total_cost
  end

  def tickets()
    sql = "SELECT tickets.customer_id FROM tickets
    WHERE customer_id = $1"
    values = [@id]
    ticket_info = SqlRunner.run(sql, values)
    tickets = ticket_info.map{|ticket| Ticket.new(ticket)}
    return tickets.size
  end

  def self.all()
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    return result.map { |customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end


end
