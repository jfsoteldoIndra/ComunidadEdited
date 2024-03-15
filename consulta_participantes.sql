select distinct CODIGO_EIC, 
						       STATUS STATUS, 
						       DISPLAY_NAME, 
						       FECHA_SOLICITUD, 
						       FECHA_DESACTIVACION, 
						       EIC_PARENT, 
						       EIC_RESPONSIBLE_PARTY, 
						       NOMBRE_LARGO, 
						       DESCRIPCION, 
						       ID_FUNCION, 
						       CODIGO_ACER, 
						       CODIGO_VAT from 
 						       (select cod.CODIGO_EIC, 
                                    cod.STATUS STATUS, 
                                    cod.DISPLAY_NAME, 
                                    cod.FECHA_SOLICITUD, 
                                    cod.FECHA_DESACTIVACION, 
                                    cod.EIC_PARENT, 
                                    cod.EIC_RESPONSIBLE_PARTY, 
                                    cod.NOMBRE_LARGO, 
                                    cod.DESCRIPCION, 
                                    rf.ID_FUNCION, 
                                    emp.CODIGO_ACER, 
                                    emp.CODIGO_VAT 
                               from CODIGOS_EIC_LOCAL cod, RELACION_FUNCION_EIC_CODE rf, EMPRESAS emp 
                              where cod.TIPO_EIC = 'X' 
                                and rf.CODIGO_EIC(+) = cod.CODIGO_EIC 
                                and emp.CODIGO_EIC = cod.CODIGO_EIC 
                                 union 
							   select cen.EIC_CODE AS CODIGO_EIC, 
							       cen.STATUS, 
							       cen.DISPLAY_NAME, 
							       cen.last_request_date AS FECHA_SOLICITUD, 
							       cen.FECHA_DESACTIVACION, 
							       cen.EIC_PARENT, 
							       cen.EIC_RESPONSIBLE_PARTY, 
							       cen.eic_name as NOMBRE_LARGO, 
							       cen.DESCRIPCION, 
							       rf.ID_FUNCION, 
							       emp.CODIGO_ACER, 
							       emp.CODIGO_VAT 
							  from CODIGOS_EIC_CENTRAL cen, Relacion_Usuarios_Empresas rup, RELACION_FUNCION_EIC_CODE rf, EMPRESAS emp 
							 where cen.eic_type = 'X' 
							   and rf.CODIGO_EIC(+) = cen.eic_code 
							   and emp.CODIGO_EIC = cen.eic_code 
							   and cen.eic_code = rup.CODIGO_EIC 
							   and cen.eic_code not like '18X%') 
                           order by CODIGO_EIC
