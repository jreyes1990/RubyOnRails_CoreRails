select opciones.*,
menus.nombre as nombre_menu, menus.icono as icono_menu, menus.codigo_hex as codigo_hex_menu
from opciones
inner join menus on(opciones.menu_id=menus.id)