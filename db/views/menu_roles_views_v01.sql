select menu_roles.*,
opciones.nombre as nombre_opcion, 
opciones.icono as icono_opcion, 
opciones.path as path_opcion, 
opciones.controlador as controlador_opcion, 
opciones.codigo_hex as codigo_hex_opcion,
roles.nombre as nombre_rol, 
roles.codigo_hex as codigo_hex_rol,
menus.id as menu_codigo, 
menus.nombre as nombre_menu, 
menus.icono as icono_menu, 
menus.codigo_hex as codigo_hex_menu
from menu_roles
inner join opciones on(menu_roles.opcion_id=opciones.id)
inner join roles on(menu_roles.rol_id=roles.id)
inner join menus on(opciones.menu_id=menus.id);