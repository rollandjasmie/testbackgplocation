FactoryBot.define do
    marque = Faker::Vehicle.make
    model = Faker::Vehicle.model(make_of_model: marque)
    factory :voiture do
        marque { marque }
        model { model }
    end
end