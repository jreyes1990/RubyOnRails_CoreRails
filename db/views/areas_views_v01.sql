select areas.*, 
empresas.codigo_empresa, empresas.nombre as nombre_empresa, (empresas.codigo_empresa||': '||empresas.nombre) as codigo_nombre_empresa 
from areas
inner join empresas on(areas.empresa_id=empresas.id);