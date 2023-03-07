select opcion_cas.*,
opciones.menu_id, menus.nombre as nombre_menu, menus.icono as icono_menu, menus.codigo_hex as codigo_hex_menu,
opciones.nombre as nombre_opcion, opciones.icono as icono_opcion, opciones.codigo_hex as codigo_hex_opcion,
componentes.nombre as nombre_componente,
atributos.nombre as nombre_atributo
from opcion_cas 
inner join opciones on(opcion_cas.opcion_id=opciones.id)
inner join componentes on(opcion_cas.componente_id=componentes.id)
inner join atributos on(opcion_cas.atributo_id=atributos.id)
inner join menus on(opciones.menu_id=menus.id);