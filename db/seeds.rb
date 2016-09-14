Brand.find_or_create_by(name: "Petron")
Brand.find_or_create_by(name: "Petronas")

State.find_or_create_by(state: "pending")
State.find_or_create_by(state: "confirmed")
State.find_or_create_by(state: "assigned")
State.find_or_create_by(state: "in_transit")
State.find_or_create_by(state: "delivered")

Delivery.find_or_create_by(name: "Petron Lady", phone_number: "5559876")
Delivery.find_or_create_by(name: "Petronas Guy", phone_number: "5551234")
