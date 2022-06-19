# Create a main sample user.
User.create!(name: "Souparno Bhattacharya",
             email: "sou24par08no1999@gmail.com",
             password:              "123456",
             password_confirmation: "123456",admin:true)



user=User.first
50.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    dob="1960-08-08"
    
    description= Faker::Lorem.sentence(word_count: 15)
    
    location="Kalyani"
    url="DmUO-w5ToVM"

    user.posts.create!(name:name,email:email,dob:dob,description:description,location:location,url:url)
end