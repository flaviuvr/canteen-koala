User.create!(name: 'User',
             email: 'koala@food.org',
             password: 'easytoguesspassword',
             password_confirmation: 'easytoguesspassword',
             activated: true,
             activated_at: Time.zone.now)
