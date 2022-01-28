admin = User.create!(email: 'admin@admin.com', name: 'Admin',
                     password: '12345678',
                     role: :admin)

user = User.create!(email: 'user@user.com', name: 'User', password: '12345678')

course = Course.create!(title: 'Health Science 101',
               description: 'Et sit officiis eaque.')
Course.create!(title: 'Engineering 101',
               description: 'Voluptates atque eos voluptate.')

content = Content.create!(name: 'A video', user: admin, course: course)
content.file.attach(
  io: File.open(Rails.root.join('spec/fixtures/files/dramatic_chipmunk.mp4')),
  filename: 'dramatic_chipmunk.mp4',
  content_type: 'video/mp4'
)
content = Content.create!(name: 'Another video', user: admin, course: course)
content.file.attach(
  io: File.open(Rails.root.join('spec/fixtures/files/dramatic_chipmunk.mp4')),
  filename: 'dramatic_chipmunk.mp4',
  content_type: 'video/mp4'
)

Audience.create!(user: user, course: course)
