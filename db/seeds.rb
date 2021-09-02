User.create!(name: 'Admin',
             email: 'koala.admin@food.org',
             password: 'hardtoguesspassword',
             password_confirmation: 'hardtoguesspassword',
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

User.create!(name: 'User',
             email: 'koala@food.org',
             password: 'easytoguesspassword',
             password_confirmation: 'easytoguesspassword',
             activated: true,
             activated_at: Time.zone.now)