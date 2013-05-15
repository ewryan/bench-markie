class HelloWorld
  include Celluloid

  def initialize opts
    @id = "#{opts["message"]}-#{Random.new.rand(1..10000)}"
  end

  def run
    puts "Hello World #{@id}"
  end

end