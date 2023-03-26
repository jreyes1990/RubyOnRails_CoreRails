=begin
u = User.new({email: "sistemas@madretierra.com.gt", encrypted_password: "$2a$12$XM9n0jp/ut8OJ5fD5Gamo.4o/OMc4UgKYrq7EQ.3hLGxSpb2P/cqW", reset_password_token: "2d26e6612f4eaecec1c0baa7f7a4a71801ffb12d64b864aff3173a4eea0896aa", reset_password_sent_at: "2021-11-11 22:48:09", remember_created_at: nil, estado: "A", user_created_id: nil, user_updated_id: nil})
u.save!(validate: false)

persona = Persona.find(1)
persona.nombre = "Super"
persona.apellido = "Administrador"
persona.direccion = "Guatemala"
persona.estado = "A"
persona.telefono = "66854900"
persona.save

Empresa.create!([
  {codigo_empresa: 2, nombre: "Ingenio Madre Tierra", descripcion: "Empresa productora de azúcar y sus derivados", estado: "A", user_created_id: nil, user_updated_id: nil}
])

Area.create!([
  {codigo_area: 9, nombre: "Informatica", descripcion: "Departamento de Tecnologia e Información de la empresa Ingenio Madre Tierra.", empresa_id: 1, estado: "A", user_created_id: nil, user_updated_id:nil}
])

Rol.create!([
  {nombre: "SUPER ADMINISTRADOR", descripcion: "Rol para administrar el sistema", estado: "A", user_created_id: 1, user_updated_id: 1}
])

PersonasArea.create!([
  {persona_id: 1, area_id: 1, estado: "A", user_created_id: 1, rol_id: 1, user_updated_id: nil}
])

Atributo.create!([
  {nombre: "VER", descripcion: "Atributo que nos brinda la opción de ver.", estado: "A", user_created_id: 1, user_updated_id: 1},
  {nombre: "ACCESAR", descripcion: "Atributo que nos brinda el permiso de acceso a partes del sistema", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "VER OPCION", descripcion: "Atributo que nos brinda la opción de ver una opción en el Sidebar.", estado: "A", user_created_id: 1, user_updated_id: 1}
])

Componente.create!([
  {nombre: "OPCION", descripcion: "Componente para la validación de permisos a nivel de opciones del sistema.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "BOTON NUEVO REGISTRO", descripcion: "Botón para agregar un nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "BOTON REGISTRAR", descripcion: "Botón para agregar un nuevo registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "BOTON EDITAR REGISTRO", descripcion: "Botón para editar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "BOTON ELIMINAR REGISTRO", descripcion: "Botón para la eliminar un registro.", estado: "A", user_created_id: 1, user_updated_id: nil}
])

Menu.create!([
  {nombre: "Configuración", descripcion: "Menú padre que contendrá las configuraciones del sistema.", icono: "fas fa-fw fa-wrench", estado: "A", user_created_id: 1, user_updated_id: nil},
  {nombre: "Catálogos", descripcion: "Menú padre que tendrá las opciones de los catálogos existentes", icono: "fas fa-fw fa-cog", estado: "A", user_created_id: 1, user_updated_id: nil}
])
=end

Opcion.create!([
  {nombre: "Usuario", descripcion: "Opción del menú para la administración de los usuarios del sistema.", icono: "fas fa-users", path: "usuarios_path", controlador: "usuarios", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Empresas", descripcion: "Opción del menú para la administración de las empresas del sistema.", icono: "fas fa-building", path: "empresas_path", controlador: "empresas", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Área - Empresa", descripcion: "Opción del menú para la administración de las áreas por empresa del sistema.", icono: "fas fa-sitemap", path: "areas_path", controlador: "areas", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Usuario - Área", descripcion: "Opción del menú para la administración de las asignaciones del los usuarios a areas del sistema.", icono: "fas fa-users", path: "personas_areas_path", controlador: "personas_areas", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Rol", descripcion: "Opción del menú para la administración de los roles del sistema.", icono: "fas fa-user-tag", path: "roles_path", controlador: "roles", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Menú", descripcion: "Opción del menú para la administración de los menús del sistema.", icono: "fab fa-elementor", path: "menus_path", controlador: "menus", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Opción - Menú", descripcion: "Opción del menú para la administración de las opciones por menú del sistema.", icono: "fas fa-minus-square", path: "opciones_path", controlador: "opciones", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Menú - Rol", descripcion: "Opción del menú para la administración de los menús por rol del sistema.", icono: "fas fa-user-cog", path: "menu_roles_path", controlador: "menu_roles", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Atributo", descripcion: "Opción del menú para la administración de los atributos del sistema.", icono: "fas fa-atom", path: "atributos_path", controlador: "atributos", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Componente", descripcion: "Opción del menú para la administración de los componentes del sistema.", icono: "fab fa-codepen", path: "componentes_path", controlador: "componentes", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Permisos Formulario", descripcion: "Opción del menú para la administración de los permisos por formulario del sistema.", icono: "fas fa-clipboard-list", path: "opcion_cas_path", controlador: "opcion_cas", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil},
  {nombre: "Permisos Usuario", descripcion: "Opción del menú para la administración de los permisos por usuario del sistema.", icono: "fas fa-clipboard-list", path: "persona_empresa_formularios_path", controlador: "persona_empresa_formularios", estado: "A", menu_id: 1, user_created_id: 1, user_updated_id: nil}
])
