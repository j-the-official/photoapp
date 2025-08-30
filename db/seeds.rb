User.destroy_all
Photo.destroy_all

demo = User.create!(user_id: "user", password: "1234")
puts "Created user_id: user / password: 1234"

2.times do |i|
  photo = demo.photos.build(title: "sample #{i + 1}")
  photo.image.attach(
    io: File.open(Rails.root.join("public", "sample#{i + 1}.jpg")),
    filename: "sample#{i + 1}.jpg",
    content_type: "image/jpg"
  )
  photo.save!
end
puts "Created 2 sample photos"
