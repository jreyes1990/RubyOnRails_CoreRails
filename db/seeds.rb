u = User.new({email: "sistemas@madretierra.com.gt", encrypted_password: "$2a$12$XM9n0jp/ut8OJ5fD5Gamo.4o/OMc4UgKYrq7EQ.3hLGxSpb2P/cqW", reset_password_token: "2d26e6612f4eaecec1c0baa7f7a4a71801ffb12d64b864aff3173a4eea0896aa", reset_password_sent_at: "2021-11-11 22:48:09", remember_created_at: nil, estado: "A", user_created_id: nil, user_updated_id: nil})
u.save!(validate: false)

persona = Persona.find(1)
persona.nombre = "Super"
persona.apellido = "Administrador"
persona.direccion = "TI"
persona.estado = "A"
persona.telefono = "11111111"
persona.save