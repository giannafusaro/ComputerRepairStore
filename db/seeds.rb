# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vito = Employee.create({name: 'Vito', rating: 4.5})
aj = Employee.create({name: 'AJ', rating: 1.7})
finn = Employee.create({name: 'Finn', rating: 2.2})
carmela = Employee.create({name: 'Carmela', rating: 4.9})
meadow = Employee.create({name: 'Meadow', rating: 3.3})

tony = Customer.create({ name: 'Tony', phone: '123-456-7890', email: 'tony@badabing.com' })
paulie = Customer.create({ name: 'Paulie', phone: '456-789-0123', email: 'paulie@badabing.com' })
silvio = Customer.create({ name: 'Silvio', phone: '789-012-3456', email: 'silvio@badabing.com' })
christopher = Customer.create({ name: 'Christophor', phone: '123-456-7890', email: 'christopher@badabing.com' })

comp1 = Laptop.create({ customer: tony, model: 'Macbook Pro 15"', serial: '342342342345', purchased_at: 2.years.ago })
comp2 = Desktop.create({ customer: tony, model: 'Mac Pro', serial: '8483663832', purchased_at: 1.month.ago })
comp3 = Laptop.create({ customer: paulie, model: 'Asus Netbook', serial: '124123699044', purchased_at: 6.months.ago })
comp4 = Desktop.create({ customer: silvio, model: 'Dell Inspiron', serial: '124123699044', purchased_at: 3.days.ago })
comp5 = Laptop.create({ customer: christopher, model: 'Macbook ', serial: '124123699044', purchased_at: 1.years.ago })

repair1 = Repair.create({ customer: tony, employee: carmela, computer: comp1, description: "It doesn't turn on, okay?", labor_cost: 0, total_cost: 0, status: 'requested' })
repair2 = Repair.create({ customer: paulie, employee: carmela, computer: comp3, description: "Windows shattered.", labor_cost: 220, total_cost: 500, status: 'in progress' })
repair3 = Repair.create({ customer: silvio, employee: vito, computer: comp4, description: "I don't know. That's your job.", labor_cost: 400, total_cost: 400, status: 'completed' })
repair4 = Repair.create({ customer: christopher, employee: meadow, computer: comp5, description: "You tell Tony and you're dead!", labor_cost: 400, total_cost: 400, status: 'completed' })
repair5 = Repair.create({ customer: paulie, employee: vito, computer: comp3, description: "You didn't fix my windows, doc.", labor_cost: 100, total_cost: 200, status: 'in progress' })

keyboard = Part.create({repair: repair2, model: 'Logitech', serial: 87493927364937, cost: 44.99, quantity: 2})
hard_drive = Part.create({repair: repair2, model: 'Rugged', serial: 76438593820217, cost: 300.00, quantity: 1})
ram = Part.create({repair: repair2, model: '4GB DDR3', serial: 92892772384347, cost: 60.00, quantity: 3})
motherboard = Part.create({repair: repair5, model: 'ASUS P99-X ATX', serial: 27192937402298, cost: 300.99, quantity: 2})
cpu = Part.create({repair: repair3, model: 'Intel i7', serial: 29238297279834, cost: 400.77, quantity: 1})
