# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.destroy_all
Customer.destroy_all
Computer.destroy_all
Part.destroy_all
Repair.destroy_all

vito = Employee.create({name: 'Vito', email: 'vito@satriales.com', rating: 4.5, password: 'test', password_confirmation: 'test'})
aj = Employee.create({name: 'AJ', email: 'aj@satriales.com', rating: 1.7, password: 'test', password_confirmation: 'test'})
finn = Employee.create({name: 'Finn', email: 'finn@satriales.com', rating: 2.2, password: 'test', password_confirmation: 'test'})
carmela = Employee.create({name: 'Carmela', email: 'carmela@satriales.com', rating: 4.9, password: 'test', password_confirmation: 'test'})
meadow = Employee.create({name: 'Meadow', email: 'meadow@satriales.com', rating: 3.3, password: 'test', password_confirmation: 'test'})
test1 = Employee.create({name: 'test', email: 'test@test.com', rating: 4.5, password: 'test', password_confirmation: 'test'})

tony = Customer.create({ name: 'Tony', phone: '123-456-7890', email: 'tony@badabing.com', password: 'test', password_confirmation: 'test' })
paulie = Customer.create({ name: 'Paulie', phone: '456-789-0123', email: 'paulie@badabing.com', password: 'test', password_confirmation: 'test' })
silvio = Customer.create({ name: 'Silvio', phone: '789-012-3456', email: 'silvio@badabing.com', password: 'test', password_confirmation: 'test' })
christopher = Customer.create({ name: 'Christophor', phone: '123-456-7890', email: 'christopher@badabing.com', password: 'test', password_confirmation: 'test' })
test2 = Customer.create({name: 'test', email: 'test@test.com', phone: '123-456-7890', password: 'test', password_confirmation: 'test'})

comp1 = Laptop.create({ customer: tony, model: 'Macbook Pro 15"', serial: '342342342345', purchased_at: 2.years.ago.strftime('%m/%d/%Y %l:%M %p')})
comp2 = Desktop.create({ customer: tony, model: 'Mac Pro', serial: '8483663832', purchased_at: 1.month.ago.strftime('%m/%d/%Y %l:%M %p') })
comp3 = Laptop.create({ customer: paulie, model: 'Asus Netbook', serial: '124123699044', purchased_at: 6.months.ago.strftime('%m/%d/%Y %l:%M %p') })
comp4 = Desktop.create({ customer: silvio, model: 'Dell Inspiron', serial: '124123699044', purchased_at: 3.days.ago.strftime('%m/%d/%Y %l:%M %p') })
comp5 = Laptop.create({ customer: christopher, model: 'Macbook ', serial: '124123699044', purchased_at: 1.years.ago.strftime('%m/%d/%Y %l:%M %p') })
comp6 = Laptop.create({ customer: test2, model: 'Macbook Air ', serial: '789738294732', purchased_at: 1.years.ago.strftime('%m/%d/%Y %l:%M %p') })

repair1 = Repair.create({ customer: tony, employee: carmela, computer: comp1, description: "It doesn't turn on, okay?", labor_cost: 0, total_cost: 0, requested_for: Time.now.strftime('%m/%d/%Y %l:%M %p'), completed_at: 2.day.from_now.strftime('%m/%d/%Y %l:%M %p') })
repair2 = Repair.create({ customer: paulie, employee: carmela, computer: comp3, description: "Windows shattered.", labor_cost: 220, total_cost: 500, requested_for: 4.days.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 2.minutes.from_now.strftime('%m/%d/%Y %l:%M %p')})
repair3 = Repair.create({ customer: silvio, employee: vito, computer: comp4, description: "I don't know. That's your job.", labor_cost: 400, total_cost: 400, requested_for: 10.days.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 5.hours.from_now.strftime('%m/%d/%Y %l:%M %p')})
repair4 = Repair.create({ customer: christopher, employee: meadow, computer: comp5, description: "You tell Tony and you're dead!", labor_cost: 400, total_cost: 400,requested_for: 3.weeks.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 2.weeks.from_now.strftime('%m/%d/%Y %l:%M %p')})
repair5 = Repair.create({ customer: paulie, employee: vito, computer: comp3, description: "You didn't fix my windows, doc.", labor_cost: 100, total_cost: 200, requested_for: 55.days.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 3.weeks.ago.strftime('%m/%d/%Y %l:%M %p')})

repair6 = Repair.create({ customer: test2, employee: test1, computer: comp6, description: "This is past repair example 1.", labor_cost: 75, requested_for: 55.days.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 3.weeks.ago.strftime('%m/%d/%Y %l:%M %p')})
repair7 = Repair.create({ customer: test2, employee: test1, computer: comp6, description: "This is past repair example 2.", labor_cost: 400, requested_for: 55.days.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 3.weeks.ago.strftime('%m/%d/%Y %l:%M %p')})
repair8 = Repair.create({ customer: test2, employee: test1, computer: comp6, description: "This is past repair example 3.", labor_cost: 50, requested_for: 55.days.ago.strftime('%m/%d/%Y %l:%M %p'),  completed_at: 3.weeks.ago.strftime('%m/%d/%Y %l:%M %p')})


keyboard = Part.create({repair: repair2, model: 'Logitech', serial: 87493927364937, cost: 44.99, quantity: 2})
hard_drive = Part.create({repair: repair2, model: 'Rugged', serial: 76438593820217, cost: 300.00, quantity: 1})
ram = Part.create({repair: repair2, model: '4GB DDR3', serial: 92892772384347, cost: 60.00, quantity: 3})
motherboard = Part.create({repair: repair5, model: 'ASUS P99-X ATX', serial: 27192937402298, cost: 300.99, quantity: 2})
cpu = Part.create({repair: repair3, model: 'Intel i7', serial: 29238297279834, cost: 400.77, quantity: 1})
