User.destroy_all
Photo.destroy_all

demo = User.create!(user_id: "user", password: "password")
puts "Created user_id: user / password: password"

2.times do |i|
  photo = demo.photos.create!(title: "sample #{i + 1}")
  photo.image.attach(
    io: File.open(Rails.root.join("public", "sample#{i + 1}.jpg")),
    filename: "sample#{i + 1}.jpg",
    content_type: "image/jpg"
  )
end
puts "Created 2 sample photos"