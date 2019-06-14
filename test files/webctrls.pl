%
%	$Log:   Q:/prolog/vcsfiles/webctrls.arV  $
%	
%	   Rev 1.148   09 Nov 2006 14:20:50   alevin-Yi
%	- Arreglo en el gen_web_control_routine( edit, ...) para que oculte el span cuando el control tien
%	e
%	  Visible = 0, pero que no lo haga cuando esta con Enabled=0 pero esa propiedad es asignada en
%	  runtime.
%	
%	   Rev 1.147   25 Oct 2006 14:20:36   alevin-Yi
%	- Cambio en el gen_web_control_routine( bitmap, ...) para que haga el submit
%	  con gxSubmit() en lugar de self.document.forms[0].submit().
%	  El gxSubmit ademas de hacer el submit ejecuta la funcion ForceEnableControls
%	  necesaria para que los controles deshabilitados vayan en el post.
%	
%	   Rev 1.146   Oct 06 2006 18:01:16   DMendez-Yi
%	gen_web_control_routine( edit...):-
%	  Se agrego parametro nRTEnabled que indica si la propiedad enabled es asignada en runtime.
%	  De esta forma se puede generar el input y el span para habilitar uno u otro 
%	  segun corresponda desde el codigo clientside.
%	  Corresponde a Rev 1.80 de htmlctrl.ari
%	  sac #20563
%	
%	   Rev 1.145   26 Jul 2006 16:56:42   alevin-Yi
%	- En el predicado gen_web_control_routine grabo el atributo gxevent en
%	  el tag del control.
%	
%	   Rev 1.144   06 Jul 2006 13:30:14   alevin-Yi
%	- En la imagen para bajar un blob le agrego border="0" para que no muestre el
%	  borde, si no se hace eso muestra un borde azul (o del color de los links).
%	
%	   Rev 1.143   28 Jun 2006 18:34:18   alevin-Yi
%	- En el gen_web_control_routine para blobs, cuando el blob esta vacio y
%	  se muestra inline, no se le pone link a la imagen de download.
%	
%	   Rev 1.142   27 Jun 2006 17:51:58   alevin-Yi
%	- En el gen_web_control_routine para blobs, si se tiene visible=0 se debe
%	  ocultar tambien el input file.
%	
%	   Rev 1.141   27 Jun 2006 10:11:56   alevin-Yi
%	- En el gen_web_control_routine para blobs, cuando un blob es vacio, se muestra
%	  "about:blank".
%	
%	   Rev 1.140   Jun 14 2006 20:30:08   DMendez-Yi
%	map_gxevent_to_jscode1:-
%		el js setevent ahora debe incluirse en el cabezal del 
%		doc porque debe estar disponible gxaddWCKeyListener al dibujar los components.
%	
%	   Rev 1.139   May 26 2006 12:53:36   DMendez-Yi
%	Se implemento soporte de jsevent en radios.
%	SAC# 20122
%	
%	   Rev 1.138   May 23 2006 20:01:10   DMendez-Yi
%	gen_web_control_routine( hidden...):-
%		Se genera name y no id porque no anduvo la rev anterior en .net. 
%		En java funciona de las dos formas.
%	
%	
%	   Rev 1.137   May 19 2006 19:25:48   DMendez-Yi
%	gen_web_control_routine( hidden...):-
%		No se manda name en hiddens para optimizar tamanio del html
%	
%	
%	   Rev 1.136   May 10 2006 20:16:16   DMendez-Yi
%	gen_web_control_routine( ...bitmap...):-
%		Se generaban varios att style para las imagenes tag <IMG>. 
%		Eso no es correcto y el FF no lo soporta (anda en IE).
%	
%	
%	   Rev 1.135   08 May 2006 15:56:20   CMurialdo-Yi
%	- Agrego el parametro callerpgm a la llamada a la rutina que dibuja los botones.
%	  (se habia agregado en las deficiones, pero faltaba agregarlo en esta llamada).
%	
%	   Rev 1.134   May 05 2006 18:08:18   DMendez-Yi
%	Se soportan tooltips en botones.
%	Se soporta access key en tooltips de botones e imagenes.
%	
%	   Rev 1.133   Apr 20 2006 11:01:14   DMendez-Yi
%	Cuando un radio/combo/listbox esta disabled se usa el script GXDisableCtrl para que se de de alta 
%	en una lista.
%	Antes de hacer el post se habilitan para que se manden sus valores al server.
%	
%	   Rev 1.132   Mar 28 2006 16:46:40   DMendez-Yi
%	Se generaba mal condicion para llamada a accesskeycaption
%	
%	   Rev 1.131   Mar 22 2006 17:01:52   DMendez-Yi
%	Error de casing en llamada a accesskey/accesskeycaption
%	
%	   Rev 1.130   Mar 21 2006 17:19:42   DMendez-Yi
%	Se calcula accesskey a partir del caption para botones.
%	Se elimina propiedad para bitmaps.
%	
%	   Rev 1.129   Feb 21 2006 16:44:32   DMendez-Yi
%	AccessKey se agrega para Imágenes también 
%	SAC #19731 
%	    
%	
%	   Rev 1.128   27 Dec 2005 16:14:16   alevin-Yi
%	- Cambio para que los single line edits nunca escapeen los enters.
%	  * Si el control esta enabled solo se escapean los caracteres html (<, >, etc..).
%	    Llama al: send_web_value_l
%	  * Si el control no esta enabled, depende de la property Format:
%	  	* Text: Solo se escapean los caracteres html (<, >, etc..).
%	  		Llama al: send_web_value_l
%	  	* Text w/Meaningfull spaces: Se escapean los espacios y los chars html.
%	  	  Llama al: send_web_value_space_l
%	  	* HTML: No se escapea nada.
%	  	  Llama al: send_web_string
%	  
%	
%	   Rev 1.127   Dec 21 2005 18:22:42   DMendez-Yi
%	send_web_value_enter_l:-
%		Compilacion condicional (ALevin).
%	gen_web_control_routine( blob...):-
%		El encoding 'multipart' se hace en runtime para soportar blobs dentro de webcomponets.
%	
%	
%	
%	   Rev 1.126   19 Dec 2005 18:06:08   alevin-Yi
%	- web_control_routine_def1: Agrego los parametros nWidthUnit y nHeightUnit
%	  para los Blobs.
%	  gen_web_control_routine: Se genera el style teniendo en cuenta estos
%	  parametros agregados, pasaba que no se podia poner, por ej.: width:100%.
%	
%	   Rev 1.125   16 Dec 2005 11:07:02   AGS_Yi
%	- Agrego send_web_value_enter_l para mandar la info del contenido de
%	  un editbox. Este predicado genera un metodo que encodea los enters (sino
%	  el browser los ignora). Esto soluciona el SAC19146 "No se mustran enters
%	  en grids de web panel"
%	
%	   Rev 1.124   06 Dec 2005 13:19:38   AGS_Yi
%	- Modifico generacion de labels por conflicto de la var style con variables
%	  predefinidas.
%	
%	   Rev 1.123   Dec 02 2005 16:28:50   DMendez-Yi
%	legacy_combos:-
%		Se hace una verificacion mas eficiente.
%		Si el combo esta disabled y ninguna rule o evento indica lo contrario se dibuja como span (legacy
%	).
%		Caso contrario se dibuja como combo readonly.
%	
%	   Rev 1.122   Nov 18 2005 19:13:32   DMendez-Yi
%	Por compatibilidad WEB_COMBOS_AS_SPAN=Y hace que los combos readonly se generen como span
%	
%	   Rev 1.121   Nov 18 2005 18:39:30   DMendez-Yi
%	Dibuja combo/listboxes de atributos en webpanels como spans por compatibilidad con el pasado.
%	En el resto de los casos dibujamos los combos readonly para poder habilitarlos con wcsv
%	
%	
%	   Rev 1.120   15 Nov 2005 18:28:06   alevin-Yi
%	- Al span de los ComboBox/ListBox readonly se le genera un id.
%	
%	   Rev 1.119   Oct 26 2005 12:47:48   DMendez-Yi
%	gen_web_control_routine:-
%		Para el dibujo de combobox se cambia trim por alltrim porque se estaba parado en un bug de 
%		los stdfiles. La trim hacia alltrim, ahora hace rtrim.
%		Con este arreglo dejaron de andar los combos con codigo numerico en IE. 
%	
%	   Rev 1.118   Oct 13 2005 17:26:34   DMendez-Yi
%	Error en el put anterior, el que devuelve false 
%	debe ser el handler del evento, no el prompt 
%	porque sino cuando se llama como link (HREF) devuelve una pagina con el valor false.
%	
%	   Rev 1.117   Oct 07 2005 21:08:30   DMendez-Yi
%	suffix_fix( 4,..):-
%		Para el evento 4 (select) se retorna los devuelto por el prompt (false) 
%		para evitar que el IE haga submit. SAC #15803
%		Corresponde a  Rev 1.91.1.10 en olimar
%	
%	%	
%	
%	
%	   Rev 1.116   Oct 07 2005 15:48:04   DMendez-Yi
%	gen_web_control_routine( blob...):-
%		Faltaba aplicar inline style en caso que se desplega como link, 
%		por ejemplo no tenia efecto la propiedad visible sobre el control en este caso.
%	
%	   Rev 1.115   Oct 07 2005 14:49:22   DMendez-Yi
%	La llamada al documento help con GX_HELP debe hacerse en minusculas.
%		SAC #18750
%	Para imagenes con el evento select asociado (4) no sebe hacerse el submit 
%		SAC #15803
%	
%	   Rev 1.114   Sep 28 2005 15:44:30   DMendez-Yi
%	web_control_routine_def1:-
%		Se calcula el codigo dinamico que corresponde a la llamada  
%		al evento select asociado a una imagen.
%		SAC 15803 Corresponde a Rev 1.91.1.7
%	
%	
%	   Rev 1.113   Sep 22 2005 14:57:48   DMendez-Yi
%	Arreglo al put anterior, hubo problemas porque el submit del js no llama a la onsubmit del form.
%	
%	   Rev 1.111   Sep 05 2005 14:33:46   DMendez-Yi
%	Se genera prefijo de class (CSS) 'Readonly' cuando corresponde para 
%	combo/checkbox/radio
%	
%	   Rev 1.110   Aug 23 2005 12:08:58   DMendez-Yi
%	Propiedad usemap para imagenes HTML <IMG>
%	
%	   Rev 1.109   Aug 18 2005 10:29:26   DMendez-Yi
%	gen_web_control_routine( edit....:-
%		Cuando en control edit es readonly <span> se mandan los stags porque 
%		son necesarios para el disparo de acciones (ajax en WCSV).
%	
%	
%	   Rev 1.108   Jul 22 2005 20:11:32   DMendez-Yi
%	Se genera clase segun temas para content e input del blob
%	
%	   Rev 1.107   15 Jul 2005 19:04:26   gusbro-Yi
%	- Agrego property Align a los bitmaps
%	
%	   Rev 1.106   Jun 17 2005 14:42:38   DMendez-Yi
%	gen_web_control_routine:-
%		Se evita la generacion de varios atributos "onchange" para el mismo control.
%		En IE anda pero no esta correcto del punto de vista del HTML. Mozilla no lo soporta.
%	
%	
%	   Rev 1.105   May 02 2005 14:44:26   DMendez-Yi
%	gen_web_control_routine:-
%		Propiedad Targetlink para controles blob.
%		Se unifico propiedad Inlinecontenttype con Contenttype.
%	
%	   Rev 1.104   Apr 22 2005 15:41:50   DMendez-Yi
%	gen_web_control_routine( label...):-
%		Se generaban mal las comillas (") para el att style.
%	
%	
%	   Rev 1.103   Apr 20 2005 19:40:46   DMendez-Yi
%	web_control_routine_def1( button...):-
%	gen_web_control_routine( button...):-
%		Se implemento la propiedad para botones AccessKey SAC # 16406
%	
%	
%	
%	
%	   Rev 1.102   Mar 30 2005 18:43:22   DMendez-Yi
%	gen_web_control_routine:-
%		Faltaba incluir tags adicionales parametro sTags en dibujo de controles blob.
%	
%	
%	   Rev 1.101   18 Jan 2005 14:23:38   AGS_Yi
%	- Agrego parametro con tipo del dato a rutina de render de combos para
%	  generar distinto el valor si es un numerico. (SAC17511).
%	
%	
%	   Rev 1.100   Jan 03 2005 15:16:24   DMendez-Yi
%	Se agrego parametro sJsCode para rutina de dibujo de botones.
%	
%	   Rev 1.99   28 Dec 2004 17:07:28   AGS_Yi
%	 - Vuelvo los combos a como estaba antes del arreglo de la 1.98 por
%	   compatibilidad con la 7.5.(Arreglo de Olimar:1.91.1.2)
%	
%	   Rev 1.98   Dec 13 2004 16:01:24   DMendez-Yi
%	Para combos y listbox se muestra el control disabled cuando 
%		enabled=0. 
%	Se estaba generando un span con el valor.
%	SAC# 16761
%	Corresponde a Rev 1.91.1.1 olimar
%	
%	   Rev 1.97   Nov 19 2004 15:08:16   DMendez-Yi
%	gen_web_control_routine:-
%		Faltaba considerar parametro Visible.
%	
%	   Rev 1.96   Nov 15 2004 18:02:50   DMendez-Yi
%	Se agrego parametro Visible a rutina de dibujo de control blob.
%	
%	   Rev 1.95   Oct 27 2004 16:40:06   dmendez-Yi
%	Soporte de atributos blob en el form
%	
%	   Rev 1.94   Oct 19 2004 15:57:34   dmendez-Yi
%	Se cambio visibility:hidden por display:none porque el primero deja el espacio 
%	que ocuparia el control oculto, lo cual es incomptible con los que haciamos antes 
%	WCSV que era no dibujar el control si no estaba visible.
%	
%	   Rev 1.93   Sep 06 2004 15:42:22   iroqueta-Yi
%	Se modifico la rutina del checkbox, para que envie el valor cuando el mismo esta readonly y esta c
%	hecked.
%	
%	   Rev 1.92   Jul 23 2004 17:59:58   dmendez-Yi
%	Se dibujan los controles no visibles como tales para que puedan ser habilitados usando CSV
%	
%	   Rev 1.91   Jul 01 2004 15:18:32   DMendez-Olimar
%	Propiedad enabled en checkbox
%	
%	   Rev 1.90   Jul 01 2004 13:57:10   DMendez-Olimar
%	gen_web_control_routine( edit, Routine):-
%		No andaban los eventos si el formato del control edit es raw HTML.
%		(SAC 16271)
%	
%	
%	   Rev 1.89   01 Jul 2004 13:40:22   AGS_Olimar
%	- Agrego propiedad visible del control button.
%	
%	   Rev 1.88   Jun 24 2004 11:38:44   DMendez-Olimar
%	Se llama a send_web_value_space_l cuando la property Format del control es "text with meaningful s
%	paces".
%	
%	
%	   Rev 1.87   23 Mar 2004 18:33:20   CMurialdo-Olimar
%	 - Arreglo al cambio anterior. Agrego inicializacion de la variable seventjscode,
%	   (no compila en c# usar la variable sin inicializarla en cualquier caso).	
%	
%	   Rev 1.86   Mar 23 2004 17:21:56   DMendez-Olimar
%	gen_web_control_routine( edit, Routine):-
%		Se escapean los valores del control edir value=.
%		No se estaban soportando valores con comillas.
%	Soporte de formato 2 Raw HTML en textblocks y edits
%	
%	
%	   Rev 1.85   Mar 18 2004 14:16:58   DMendez-Olimar
%	En el put anterior falto controlar que el sapan no este vacio.
%	
%	   Rev 1.84   Mar 11 2004 12:02:12   DMendez-Olimar
%	gen_web_control_routine( label, Routine):-
%		Para los textblocks se soporta un nuevo formato "auto" que incluye el <SPAN> 
%		solo si hay evento asociado o el caption no emprieza con "<", 
%		heurística que se usa para detectar contenido HTML.
%	
%	
%	   Rev 1.83   19 Feb 2004 14:40:06   AGS_Olimar
%	- Help en C# ponia path dos veces. Era porque el help_id se ponia con el path
%	  completo que ya se estaba mandando como la baseUrl.
%	
%	   Rev 1.82   Feb 19 2004 14:13:22   APC-Olimar
%	- Arreglos para browser pocketIE , el onclick de las 
%	  imagenes no funciona hay que usar submit
%	
%	
%	   Rev 1.81   04 Dec 2003 15:58:44   DMendez-Olimar
%	En los edits ademas de name se setea el control id porque es necesario 
%	para los jscripts como el datepicker
%	
%	   Rev 1.80   20 Nov 2003 16:38:08   DMendez-Olimar
%	Se solucionan problemas de compatibilidad con wap.
%	
%	   Rev 1.79   29 Oct 2003 13:45:22   DMendez-Olimar
%	map_gxevent_to_jscode:-
%		Faltaba parametro Lvl.
%	
%	   Rev 1.78   Aug 22 2003 17:57:00   DMendez-Olimar
%	Las imagenes sin class aparecian con border
%	
%	   Rev 1.77   Aug 08 2003 15:15:40   DMendez-Olimar
%	gen_web_control_routine( edit..:-
%	        Se agrega parametro bool HasTheme porque el prefijo de ReadOnly no
%	        debe aplicarse si el objeto no tiene tema.
%	        En ese caso la clase es interna del generador "Snn"
%	
%	   Rev 1.76   Jul 30 2003 16:28:46   DMendez-Olimar
%	web_control_routine_def1( edit, ... :
%		Se agrego parametro sROClassString para poder calcular en runtime la clase 
%		que corresponde a un edit en un grid cuando es RO.
%	
%	
%	   Rev 1.75   Jul 16 2003 15:18:28   AGS_Olimar
%	- Modifico rutina de render de bitmaps para que soporte el hspace y vspace en
%	  controles que estan enabled (solo se hacia render de estas propiedades si
%	  estaban enabled=0).
%	
%	   Rev 1.74   Jun 30 2003 17:37:16   DMendez-Olimar
%	Se cambia dibujo de radio verticales. 
%	La "class" se asocia a la tabla y no a cada celda porque quedaba mal el dibujo.
%	
%	   Rev 1.73   Jun 25 2003 16:38:52   DMendez-Olimar
%	Se estaba generando borde en imagenes siempre.
%	
%	   Rev 1.72   Jun 17 2003 12:09:26   AGS_Olimar
%	- Pongo public class_tok_2_ro_class_tok/2.
%	
%	   Rev 1.71   17 Jun 2003 11:53:10   gusbro-Olimar
%	- Cambio las llamadas a new_pgm_var por una declaracion + assign_to_var porque
%	  sino en Java no queda declarada la variable en el contexto de la funcion
%	
%	   Rev 1.70   Jun 17 2003 10:26:20   DMendez-Olimar
%	Tema readonly para atributos que no se aceptan en el primer nivel
%	
%	   Rev 1.69   Jun 16 2003 11:59:34   DMendez-Olimar
%	CAmbio en generacion de border para imagenes
%	
%	   Rev 1.68   Jun 13 2003 11:23:02   DMendez-Olimar
%	Error en put anterior, falto un (+)
%	
%	   Rev 1.67   Jun 13 2003 11:01:34   DMendez-Olimar
%	No se estaba mandando la clase de los text blocks (label) al html
%	
%	   Rev 1.66   12 Jun 2003 18:08:50   gusbro-Olimar
%	- Arreglo al put anterior
%	
%	   Rev 1.65   Jun 12 2003 17:12:28   DMendez-Olimar
%	Se saco la feature del tema readonly para poder cerrar el build.
%	Hay que pensar mas la implementacion porque esta metiendo readonly en la filas de los grids.
%	
%	   Rev 1.64   Jun 11 2003 17:56:56   DMendez-Olimar
%	Error en punt anterior en expresion iif
%	
%	   Rev 1.63   Jun 11 2003 11:28:38   DMendez-Olimar
%	Se separo el token del estilo y de la clase para poder hacer operaciones con la clase en el moment
%	o de dibujar.
%	Por ahora solo se usa para los controles edit cuando son readonly.
%	
%	   Rev 1.62   Jun 09 2003 16:09:42   DMendez-Olimar
%	Se genera ID para los span para poder soportar los prompts que retornan atributos inferidos.
%	
%	   Rev 1.61   Jun 03 2003 11:18:46   DMendez-Olimar
%	gen_generate_stdweb_routines para no usar compilacion condicional que despues 
%	es dificil de actualizar en todos los lugares que aparece.
%	
%	   Rev 1.60   May 23 2003 14:35:50   APC-Olimar
%	- Correccion a lo anterior. No se estaban generando todas las 
%	  rutinas.
%	
%	
%	   Rev 1.59   May 22 2003 15:38:14   APC-Olimar
%	- Correccion para generacion de wml funcions.
%	
%	
%	   Rev 1.58   Apr 08 2003 16:34:48   DMendez-Olimar
%	Para saber si se setea el alto y ancho de imagenes se compara contra el default (0).
%	Se estaba verificando contra la propiedad autoresize, pero en la spec esta propiedad 
%	para imagenes no se setea, siempre estaba en 0
%	
%	   Rev 1.57   19 Mar 2003 15:41:52   gusbro-Olimar
%	- Cambios para agregar la BaseURL a la url al llamar al help en Java
%	
%	   Rev 1.56   19 Mar 2003 14:23:48   gusbro-Olimar
%	- Estaba quedando 2 veces el parametro sCallerPgm en la web_control_routine_def
%	
%	   Rev 1.55   Mar 19 2003 10:33:06   DMendez-Olimar
%	Error en generacion de nombre de la url para el help.
%	Estaba pensado para generarse en cada fuente. 
%	Ahora que es global se le agrego el nombre del programa llamador como parámetro.
%	
%	   Rev 1.54   Mar 14 2003 10:07:44   DMendez-Olimar
%	Soporte de imagenes con link (evento onclick) para Netscape 
%	versiones menores a 5.
%	Corresponde a Rev 1.36.1.5 Solis
%	
%	   Rev 1.53   Mar 10 2003 18:21:04   DMendez-Olimar
%	Soporte de parametro Dsiplaymode en la rutina de dibujo  de messagelist.
%	
%	   Rev 1.52   21 Feb 2003 12:27:06   aaguiar-Olimar
%	- Se implemento la property AutoComplete para edits.
%	
%	   Rev 1.51   Feb 17 2003 15:09:48   DMendez-Olimar
%	Se cambio la generacion de tag span para controles radio.
%	Ahora se genera un span para cada opcion. 
%	Esto hace que propiedades (como width) de cada opcion no se compartan entre todas las opciones del
%	 radio.
%	
%	   Rev 1.50   12 Feb 2003 17:26:16   gusbro-Olimar
%	- Se agrego el parametro sJsDynCode a la gx_button_ctrl, que se utiliza en
%	  los generadores que usan las WebStandardFunctions para llamar al prompt 
%	  
%	
%	   Rev 1.49   Nov 29 2002 15:13:42   DMendez-Olimar
%	Se agregaron tags al la rutina de render html del los textlabels para poder inlcuir class y style
%	
%	   Rev 1.48   Oct 25 2002 16:02:52   APC-Olimar
%	- Agrego referncia a js_diosable en los post.
%	
%	
%	   Rev 1.47   Aug 27 2002 17:30:38   GProto-Olimar
%	-	Soporte de styles para bitmaps.
%	
%	   Rev 1.46   Aug 26 2002 14:08:02   GProto-Olimar
%	-	Agregado de Class a botones web.
%	
%	   Rev 1.45   Aug 23 2002 13:17:16   APC-Olimar
%	- Correccion del get button en los procs estandar
%	  no se estaba generando el Jscript de la setevent
%	
%	
%	   Rev 1.44   21 Aug 2002 12:15:56   gusbro-Olimar
%	- Cambio al generar las WebStandardFunctions para que no se 
%	  considere el form como readonly
%	
%	   Rev 1.43   Aug 21 2002 09:35:38   GProto-Olimar
%	-	"Emprolijamiento" del código html (comillas en los atributos,
%		etc.).
%	
%	   Rev 1.42   Aug 08 2002 12:09:22   APC-Olimar
%	- Correcciones a la generaciom de controles lista
%	   los indices deben arrancar de 1.
%	- Correcciones para agregar parametros en caso VBasic.
%	
%	
%	   Rev 1.41   Aug 07 2002 12:58:34   APC-Olimar
%	- Cambio la generate_web_standard_function a este fuente.
%	
%	
%	   Rev 1.40   25 Jul 2002 14:41:54   aaguiar-Olimar
%	- Cambios para generar las rutinas web estandar en un archivo separado
%	
%	   Rev 1.39   23 Jul 2002 11:57:10   aaguiar-Olimar
%	- Arreglo menor en la gx_label_ctrl
%	
%	   Rev 1.38   Jul 12 2002 18:01:20   GProto-Olimar
%	-	Propiedad Enabled para Text Blocks
%	
%	   Rev 1.37   May 22 2002 19:41:34   rpiaggio
%	- Cambios para lograr que al apretar la tecla ENTER en el browser se dispare el evento
%	  ENTER. Se achica codigo con esto, para setear el control _EventName no se lo hace
%	  mas directamente sino que se llama al javascript GX_setevent que esta en "setevent.js".
%	
%	   Rev 1.36   Apr 17 2002 18:03:44   rpiaggio
%	- Cambio en el manejo de los eventos. Ahora en vez de chequear el valor de cada control,
%	  se tiene un campo oculto _EventName y cada control en su evento click setea alli el
%	  nombre del evento a disparar.
%	
%	   Rev 1.35   Jan 22 2002 14:16:20   GProto-Solis
%	-	No mandaba bien el nombre de control de checkbox.
%	
%	   Rev 1.34   Jan 18 2002 19:38:22   DMendez-Solis
%	Al llamar a send_hidden_routine a veces se mandaba el tab "name=" y otras no.
%	Se saco en las llamadas y se puso en el llamado.
%	
%	   Rev 1.33   27 Dec 2001 12:51:08   aaguiar-Solis
%	-	Se volvio para atras el cambio anterior
%	
%	   Rev 1.32   27 Dec 2001 12:47:58   aaguiar-Solis
%	- En la get_event_num se cambio un $ GX_EVENT_GET por GX_EVENT_GET
%	
%	   Rev 1.31   Dec 26 2001 18:35:50   rpiaggio
%	- Saco el newline al cerrar el tag de una imagen (bitmap). Ocasionaba que se muestre
%	  un pequeño espacio despues de cada imagen y difiere con el comportamiento anterior.
%	
%	   Rev 1.30   Dec 21 2001 19:11:08   rpiaggio
%	- Vuelvo para atras la generacion de bitmaps con eventos, excepto para el evento Get.
%	  Se generan todas como <input type=image> y el Get como <a><img></a>.
%	
%	   Rev 1.29   Dec 21 2001 17:36:08   AGS
%	- Se puso una inicializacion de la sEventJsCode para bitmaps porque sino
%	  no compila en C#.
%	
%	   Rev 1.28   Dec 20 2001 17:11:08   rpiaggio
%	- Saco los _nl en la rutina start_js_anchor porque si viene una imagen inmediatamente
%	  despues en IE6 queda una rayita antes de la imagen.
%	- Cambios en la generacion de bitmaps. Si tienen evento asociado no se generan mas
%	  como input image sino como image dentro de un anchor, igual que los labels y edits.  
%	- Modifico la map_gxevent_to_jscode para unificar el agregado de return false cuando
%	  es necesario.
%	
%	   Rev 1.27   Dec 19 2001 15:55:28   rpiaggio
%	- Cambio llamado a prompt_link_to_js_code por prompt_link_to_js_code_select.
%	
%	   Rev 1.26   Dec 18 2001 19:30:26   GProto-Solis
%	-	Combo read only muestra el valor y no la descripción.
%	
%	   Rev 1.25   Dec 18 2001 17:34:10   GProto-Solis
%	-	El borde de las imagenes se pone siempre sin importar el browser
%		o si esta o no habilitada.
%	
%	   Rev 1.24   Dec 17 2001 12:11:18   rpiaggio
%	- Arreglo en la gen_web_control_routines. Pasa a ser recursiva porque al generar
%	  unas rutinas pueden assertarse la generación de nuevas. Incluyo mecanismo para
%	  que no genere duplicadas.
%	- Arreglo para que todas las rutinas al generarse llamen a
%	  declare_start_web_control_routine. Esto es necesario en VB ya que pasamos tambien
%	  si van de in, out o inout.
%	
%	  OJO: Asegurarse de que siempre se llame a este predicado al iniciar la generacion
%	  de una rutina standard.
%	
%	   Rev 1.23   Dec 17 2001 11:42:16   GProto-Solis
%	- Rutina onclick para los controles que faltaban (combobox, listbox, etc.).
%	
%	   Rev 1.22   Dec 14 2001 12:24:22   AGS
%	- Se agrego la link_start y link_end en la xref del label ya que este las usa.
%	- Se puso publico el init_jscode para los .Net controls.
%	
%	   Rev 1.21   Dec 13 2001 15:57:28   rpiaggio
%	- Faltaba una comilla en la map_clear_to_jscode.
%	- Lint.
%	
%	   Rev 1.20   Dec 13 2001 14:25:40   GProto-Solis
%	-	Implementación de los text blocks como funciones
%	
%	   Rev 1.19   Dec 13 2001 07:15:56   GProto-Solis
%	-	Implementación de la rutina de manejo de bitmaps
%		(imagenes y variables de tipo bits).
%	
%	-	Agregado de una rutina onclick que genera el codigo
%		del onclick considerando el código que pudo haber puesto
%		el usuario.
%	
%	-	Agregado de la rutina gx_onclick que genera el codigo
%		del onclick considerando el código que pudo haber puesto
%		el usuario.
%	
%	-	Modificacion de la rutina de generacion de botones para
%		considerar código Js que pueda haber incluido el usuario
%		para el evento onclick.
%	
%	-	Modificacion de la rutina de generacion de edits single
%		line considerar código Js que pueda haber incluido el usuario
%		para el evento onclick.
%	
%	
%	   Rev 1.18   Dec 12 2001 17:14:46   aaguiar-Solis
%	-	Error en el put anterior
%	
%	   Rev 1.17   Dec 12 2001 15:56:38   aaguiar-Solis
%	- 	En la dcl_web_control_routine_parms se llama a la dcl_routine_parms.
%	
%		
%	
%	   Rev 1.16   Dec 10 2001 15:33:30   rpiaggio
%	- Idem mi arreglo anterior para radios.
%	
%	   Rev 1.15   Dec 06 2001 15:30:52   APC-Solis
%	- Correccion en generacion de rutinas para los controles web,
%	  en VB necesito el inout de los parametros.
%	
%	
%	   Rev 1.14   Dec 05 2001 15:26:40   AGS
%	- En la rutina de render de checkboxes, se generaba un + de mas. Era porque
%	  el token del sCaption estaba como tipo=3 cuando debe estar como tipo=23
%	  para que el evaluador detecte el string y concatene en lugar de poner el +.
%	
%	   Rev 1.13   Dec 04 2001 18:09:30   rpiaggio
%	- Idem anterior en la de combos.
%	
%	   Rev 1.12   Dec 04 2001 17:21:52   rpiaggio
%	- Arreglo en la rutina del checkbox. Faltaban algunos t('+',5) en una expresión.
%	
%	   Rev 1.11   Dec 04 2001 01:12:06   GProto-Solis
%	-	Implementación de la propiedad Jsonclick para edits y
%		botones.
%	
%		. Agregado del parámetro sJSOnClickCode a la rutina de
%		  gx_single_line_edit.
%	
%		. Agregado del parámetro sJSOnClickCode a la rutina de
%		  gx_button.
%	
%	-	Modificación en web_ctrl_name_tag para que retorne como
%		expresión la propiedad JsControlName.
%	
%	   Rev 1.10   Nov 19 2001 16:49:32   AGS
%	- Se implementaron las rutinas para render de combo, list, check y radio.
%	- Se implementaron los controles .Net.
%	
%	   Rev 1.9   Oct 11 2001 14:48:58   GProto-Solis
%	-	Se pasaron algunos predicados de webgral para aquí por el
%		tamaño del webgral.
%	
%	   Rev 1.8   Oct 08 2001 14:24:32   rpiaggio
%	- Nuevo tipo "BUTTON" en botones web.
%	
%	   Rev 1.7   Aug 10 2001 15:41:52   aaguiar-Solis
%	-	Error en el put anterior.
%	
%	   Rev 1.6   Aug 10 2001 12:28:02   APC-Solis
%	- Objeto error view. Cambios de Propiedades que no funcionaban.
%	
%	   Rev 1.5   Jun 08 2001 11:03:32   GProto-Solis
%	-	Se renombró skip_line_l a send_web_newline_l porque se 
%		producen conflictos con los reportes web.
%	
%	   Rev 1.4   May 04 2001 18:16:46   GProto-Solis
%	-	Implementación de evento Click en Edits.
%	
%		Cambio en la rutina de manda los edits. Se le agregó un parámetro
%		que indica si tiene o no link.
%	
%	   Rev 1.3   Feb 28 2001 15:53:34   aaguiar-Solis
%	-	Se implemento una web_control_routine_prototype que devuelve el 
%		prototipo de una rutina web.
%	-	Se implemento un mecanismo para tener separada la definicion de 
%		los parametros de las rutinas web de la implementacion de las mismas.
%	
%	   Rev 1.2   Feb 22 2001 15:47:24   rpiaggio
%	- En la gen_web_control_routine cambio el chequeo de IsPassword, Visible y Enabled
%	  de "= 1" a "<> 0".
%	
%	   Rev 1.1   Feb 13 2001 15:12:12   APC-Solis
%	- Modificacion a los tipos de las properties que 
%	  daban problemas en vb
%	
%	   Rev 1.0   Feb 08 2001 17:06:42   GProto-Solis
%	-	Rutinas de controles HTML.
%
#include <Tokens.hi>
#include <Constants.hi>

:- public generate_web_standard_functions/1:far.
generate_web_standard_functions(Mod):-
	not(in_reorg),
	is_web_generator,
	generate_standard_program(Mod, webstandard),
	debug_msg('Generating Web Standard Functions....'),
	generate_web_standard_functions1(Mod),
	debug_msg('Generating Wml Standard Functions....'),
	generate_wap_functions(Mod),
	!.
generate_web_standard_functions(_):-
	!.
	
:-public generate_standard_program/2.
#if $objcgen
generate_standard_program(_, _):-
	!,
	fail.
#endif
#if ! $ruby
generate_standard_program(Mod, Program):-
	gxobject_to_langobject(Program, Name),
	lang( _, _, [ _, _ ,Ext|_]),
	concat(Name, Ext, File),
	is_gen_program( Mod, File),
	!,
	fail.
#else
generate_standard_program(_, _):-
	check_config($$, 'GENERATE_STD_WEB', 'Y'),
	!.
#endif
generate_standard_program(_, _):-
	!.

generate_wap_functions(Mod):-
	generate_wap_functions_l(Mod),
	start_wap_routine,
	generate_web_standard_functions1(Mod),
	end_wap_routine,
	!.	
generate_wap_functions(_):-
	!.

generate_web_standard_functions1(Mod):-
	assert(generating_web_routines_i),
	assert(force_ro_form_fail_i),	
	asserta(spec_i([wr, 0, 'GeneXus Standard Web Functions', Mod, Mod, Mod])),
	create_web_standard_functions_file_l(Mod),
	declare_all_web_control_routines,
	gen_web_control_routines,
	retract(spec_i(_)),
	abolish(force_ro_form_fail_i/0),
	abolish(generating_web_routines_i/0),
	finish_web_standard_functions_file_l(Mod),
	!.

:- public declare_all_web_control_routines/0.
declare_all_web_control_routines:-
  web_control_routine(Name, _),
	assert_web_control_routine_ref( Name),
	fail.
declare_all_web_control_routines:- !.


	
:- public web_control_routine_ref/2.
web_control_routine_ref( Name, ParmsI):-
	web_control_routine_ref(Name, ParmsI, y),	
	!.

:- public web_control_routine_ref/3.
web_control_routine_ref( Name, ParmsI, AppendCaller):-
	web_control_routine_stmt(Name, ParmsI, AppendCaller, Stmt),
	end_of_sentence(E),
	concat([Stmt, E], Stmt1),
	printfgl_str([Stmt1]),	
	!.

:- public web_control_routine_stmt/4.
web_control_routine_stmt( Name, ParmsI, AppendCaller, Stmt):-
	assert_web_control_routine_ref( Name),
	web_control_routine( Name, Routine),
	std_context_routine_params_l(Name, ParmsI, Parms1),
	ifthenelse(AppendCaller=y, web_control_routine_params(Name, Parms1, Parms), Parms=Parms1),
	concat_t( [Parms, [t(')',4)]], TParms),
	do_standard_routine_l(webstandard, Routine, TParms, Stmt),
	!.

:- public web_control_routine/2.
web_control_routine( Type, Name1):-
  	tag_languaje(wml),
  	web_control_routine1( Type,	Name),
	concat(Name,'_wml', Name1).
web_control_routine( Type, Name):-
  	not(tag_languaje(wml)),
  	web_control_routine1( Type, Name).
	
web_control_routine1( hidden,		'gx_hidden_field').
%edit0 Se deja por compatibildad en los X Ev1 Upg, para no requerir un rebuildall, se puede eliminar en nueva version de gx
web_control_routine1( edit0,		'gx_single_line_edit1').
web_control_routine1( edit,			'gx_single_line_edit').
web_control_routine1( blob,			'gx_blob_field').
web_control_routine1( link_start,	'gx_link_start').
web_control_routine1( link_end,		'gx_link_end').
web_control_routine1( button,		'gx_button_ctrl').
web_control_routine1( msglist,		'gx_msg_list').
web_control_routine1( combobox0,	'gx_combobox_ctrl').
web_control_routine1( combobox,		'gx_combobox_ctrl1').
web_control_routine1( listbox0,		'gx_listbox_ctrl').
web_control_routine1( listbox,		'gx_listbox_ctrl1').
web_control_routine1( radio,		'gx_radio_ctrl').
web_control_routine1( checkbox,		'gx_checkbox_ctrl').
web_control_routine1( bitmap,		'gx_bitmap').
web_control_routine1( bitmap_readonly, 'gx_bitmap_readonly').
web_control_routine1( multimedia_upload_start, 'gx_multimedia_upload_start').
web_control_routine1( multimedia_upload_end, 'gx_multimedia_upload_end').
web_control_routine1( video,		'gx_video').
web_control_routine1( audio,		'gx_audio').
web_control_routine1( on_js_event,	'gx_on_js_event').
web_control_routine1( custom_attribute,	'gx_ctrl_attribute').
web_control_routine1( label,		'gx_label_ctrl').
web_control_routine1( start_js_anchor,	'gx_start_js_anchor').
web_control_routine1( end_js_anchor,	'gx_end_js_anchor').
web_control_routine1( redirect,		'gx_redirect').
web_control_routine1( table_start,		'gx_table_start').
web_control_routine1( html_headers,		'gx_html_headers').
web_control_routine1( set_html_headers,	'set_html_headers').
web_control_routine1( html_textarea,	'gx_html_textarea').
web_control_routine1( geolocation,	'gx_geolocation').
web_control_routine1( div_start,	'gx_div_start').
web_control_routine1( embpage,	'gx_embedded_page').

web_control_routine1( style,		['Style', 'Attribute']).
web_control_routine1( class,		['Class', 'Attribute']).

web_control_routine_xref( edit, link_start).
web_control_routine_xref( edit, link_end).
web_control_routine_xref( bitmap, link_start).
web_control_routine_xref( bitmap, link_end).
web_control_routine_xref( bitmap, on_js_event).
web_control_routine_xref( button, on_js_event).
web_control_routine_xref( bitmap, custom_attribute).
web_control_routine_xref( button, custom_attribute).
web_control_routine_xref( label, start_js_anchor).
web_control_routine_xref( label, end_js_anchor).
web_control_routine_xref( combobox, on_js_event).
web_control_routine_xref( listbox, on_js_event).
web_control_routine_xref( combobox, custom_attribute).
web_control_routine_xref( listbox, custom_attribute).
web_control_routine_xref( start_js_anchor, link_start).
web_control_routine_xref( end_js_anchor, link_end).

assert_web_control_routine_ref( Name):-
	call( web_control_routine_i( Name)),
	!.
assert_web_control_routine_ref( Name):-
	call( generated_web_control_routine_i( Name)),
	!.
assert_web_control_routine_ref( Name):-
	assert( web_control_routine_i( Name)),
	web_control_routine_xref( Name, Name1),
	[!
		assert_web_control_routine_ref( Name1)
	!],
	fail.
assert_web_control_routine_ref( _):- !.

:- public gen_web_control_routines/0.
gen_web_control_routines:-
	%declare_all_web_control_routines, %Ya se hizo antes de llamar a gen_web_control_routines
	gen_web_control_routines1,
	!.

gen_web_control_routines1:-
	not( call( web_control_routine_i( _))),
	abolish( generated_web_control_routine_i/1),
	!.
gen_web_control_routines1:-
	retract( web_control_routine_i( Name)),
	[!
		asserta( generated_web_control_routine_i( Name)),
		web_control_routine( Name, Routine),
		gen_web_control_routine( Name, Routine)
	!],
	fail.
gen_web_control_routines1:-
	% Es necesario hacerlo asi porque se pueden haber assertado nuevas rutinas
	% mientras se generaban las otras.
	gen_web_control_routines1,
	!.

:- public web_control_routine_protoype/2.
web_control_routine_protoype(Routine, PDef):-
	string_lower(Routine, LRoutine),
	web_control_routine(Name, LRoutine),
	web_control_routine_parm_types( Name, PDef),			
	!.

web_control_routine_parm_types( Name, PList):-
	web_control_routine_def( Name, PDefMed),
	add_web_routine_parms_l(Name, PDefMed, PDef),
	findall(PType, on([_, PType|_], PDef), PList),
	!.

#if !$vbasic
web_control_routine_parm_names( Name, PList):-
	web_control_routine_def( Name, PDefMed),
	add_web_routine_parms_l(Name, PDefMed, PDef),
	findall(PName, on([PName|_], PDef), PList),
	!.
#endif

web_control_routine_use_caller( Name):-
	on_test( Name, [audio, video, edit, edit0, button, combobox, combobox0, listbox, listbox0, bitmap, label, group, blob, radio, html_textarea]), 
	!.

web_control_routine_params( Name, Parms1, Parms):-
	web_control_routine_use_caller( Name),
	get_html_help(ID),
	concat([ $"$, ID, $"$], PgmName),
	concat_l( Parms1, [t($,$,7), t(PgmName, 3)], Parms),
	!.
web_control_routine_params( _, Parms, Parms):-
	!.

get_html_help(ID):-
	get_html_help_id( x, _, ID),
	!.

web_control_routine_def( Name, Parms):-
	web_control_routine_use_caller( Name),
	web_control_routine_def1( Name, Parms1),
	concat_l( Parms1, [['sCallerPgm', [[char,1024, 0, 0], in]] ], Parms),
	!.
web_control_routine_def( Name, Parms):-
	web_control_routine_def1( Name, Parms),
	!.

web_control_routine_def1( redirect, []):-
	!.
web_control_routine_def1( table_start, [ ['sCtrlName', 	[[char, 256, 0, 0], in] ],
																			 ['sHTMLid', 	[[char, 256, 0, 0], in] ],
																			 ['sHTMLTags', 	[[char, 256, 0, 0], in] ],
																			 ['sClassString',  		[[char,1024, 0, 0], in] ],
																			 ['nBorder',  		[[int ,   5, 0, 0], in] ],
																			 ['sAlign',  				[[char ,   1024, 0, 0], in] ],
																			 ['sTooltiptext',  		[[char,1024, 0, 0], in] ],
																			 ['nCellpadding',  				[[int ,   5, 0, 0], in] ],
																			 ['nCellspacing',  				[[int ,   5, 0, 0], in] ],
																			 ['sStyleString',				[[char ,   1024, 0, 0], in] ],
																			 ['sRules',  		[[char,1024, 0, 0], in] ],
																			 ['nParentIsFreeStyle', [[int, 5, 0, 0], in] ]
																]):-

	!.
web_control_routine_def1( html_headers, [ ['nContentType', 	[[int, 5, 0, 0], in] ],	
																			 ['sCacheCtrl',  		[[char,1024, 0, 0], in] ],
																			 ['sCacheExp',  		[[char,1024, 0, 0], in] ],
																			 ['rMeta', 					[[obj(METANAMECTRLTYPE), 0, 0, 0], in]],
																			 ['rMetaequiv',					[[obj(METAHTTPEQUIVCTRLTYPE), 0, 0, 0], in]],
																			 ['sIEMode',					[[char ,  254, 0, 0], in]]
																]):-

	!.
web_control_routine_def1( style, [['sStyle',  		[[char,1024, 0, 0], in]]]):-
	!.
web_control_routine_def1( class, [['sClass',  		[[char,1024, 0, 0], in]]]):-
	!.
web_control_routine_def1( set_html_headers, [ ['nContentType', 	[[int, 5, 0, 0], in] ],	
																			 ['sCacheCtrl',  		[[char,1024, 0, 0], in] ],
																			 ['sCacheExp',  		[[char,1024, 0, 0], in] ]
																]):-

	!.
web_control_routine_def1( html_textarea, [  	['sCtrlName', 		[[char, 256, 0, 0], in] ],
												['sValue', 			[[char,1024, 0, 0], in] ],
												['sLinkURL', 		[[char,1024, 0, 0], in] ],
												['sTags', 			[[char,1024, 0, 0], in] ],
												['nFormat',  		[FormatType	  , in] ],
												['nVisible',  		[[int ,   5, 0, 0], in] ],
												['nEnabled',  		[[int ,   5, 0, 0], in] ],
												['nRTEnabled',  	[[int ,   5, 0, 0], in] ],
												['nWidth',			[[int ,   5, 0, 0], in] ],		  
												['sWidthUnit',		[[char,   256, 0, 0], in] ],
												['nHeight',			[[int ,   5, 0, 0], in] ],
												['sHeightUnit',		[[char,   256, 0, 0], in] ],
												['sStyleString',  	[[char,1024, 0, 0], in] ],
												['sClassString',  	[[char,1024, 0, 0], in] ],
												['sLength',  		[[char, 256, 0, 0], in] ],
												['nAutoResize',		[[int ,   5, 0, 0], in] ],																								
												['sLinkTarget', 	[[char,1024, 0, 0], in] ],
												['sPlaceholder',	[[char,1024, 0, 0], in] ],
												['nAutoCorrection', [[int ,   1, 0, 0], in] ],	
												['bSendHidden', [[boolean ,  1, 0, 0], in]],
												['sDomainType', 	[[char, 256, 0, 0], in] ]
									]):-
	property_type( $Format$, FormatType),
	!.
	
web_control_routine_def1( geolocation, Parms):-
	web_control_routine_def1( edit0, OldParms),
	concat_l( OldParms, [['sAlign', [[char ,  256, 0, 0], in]]], Parms),
	!.
web_control_routine_def1( edit, Parms):-
	web_control_routine_def1( edit0, OldParms),
	concat_l( OldParms, [['sAlign', [[char ,  256, 0, 0], in]]], Parms),
	!.
web_control_routine_def1( edit0, [  	['sCtrlName', 	[[char, 256, 0, 0], in] ],
										['sValue', 					[[char,1024, 0, 0], in] ],
										['sFormatedValue', 		[[char,1024, 0, 0], in] ],
										['sTags', 					[[char,1024, 0, 0], in] ],																														
										['sEventName',   			[[char,1024, 0, 0], in] ],
										['sLinkURL', 				[[char,1024, 0, 0], in] ],
										['sLinkTarget', 			[[char,1024, 0, 0], in] ],
										['sTooltipText',	[[char,1024, 0, 0], in] ],
										['sPlaceholder',	[[char,1024, 0, 0], in] ],
										['sUserOnClickCode',		[[char,1024, 0, 0], in] ],
										['nJScriptCode',			[[int ,   5, 0, 0], in] ],
										['sClassString',  		[[char,1024, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ],
										['sROClassString',  		[[char,1024, 0, 0], in] ],
										['nVisible',  				[[int ,   5, 0, 0], in] ],
										['nEnabled',  				[[int ,   5, 0, 0], in] ],
										['nRTEnabled',  			[[int ,   5, 0, 0], in] ],										
										['sType', 					[[char,256,	0, 0], in] ],
										['sStep', 					[[char,256,	0, 0], in] ],										
			                            ['nWidth',			[[int ,   5, 0, 0], in] ],		  
			                            ['nWidthUnit',		[[char,   256, 0, 0], in] ],
										['nHeight',			[[int ,   5, 0, 0], in] ],
			                            ['nHeightUnit',		[[char,   256, 0, 0], in] ],
										['nLength',  				[[int ,   9, 0, 0], in] ],										
										['nIsPassword', 			[IsPasswordType	  , in] ],
										['nFormat',  				[FormatType	  , in] ],																																																		
										['nParentId',   			[[int ,   5, 0, 0], in]],										
										['bHasTheme',   			[[int ,   1, 0, 0], in]],										
										['nAutoComplete',   		[AutoCompleteType, in]],
										['nAutoCorrection',   		[[int ,   1, 0, 0], in]],	
										['bSendHidden', [[boolean ,  1, 0, 0], in]],
										['sDomainType', 	[[char, 256, 0, 0], in] ]
									]):-
	property_type( $Ispassword$, IsPasswordType),
	property_type( $Format$, FormatType),
	property_type( $Autocomplete$, AutoCompleteType),
	!.
web_control_routine_def1( msglist, [		['sCtrlName', 			[[char, 254, 0, 0], in] ],
						['nDisplayMode', 		[[int ,   9, 0, 0], in] ],
						['sStyleString',   		[[char , 254, 0, 0], in] ],
						['sClassString',  		[[char,1024, 0, 0], in] ],
						['sCmpCtx',  			[[char,1024, 0, 0], in] ],
						['sInMaster',  			[[char,1024, 0, 0], in] ]]).
web_control_routine_def1( link_start, [['sLinkURL', 				[[char, 254, 0, 0], in] ],
																			['sTargetWnd', 		[[char, 254, 0, 0], in] ]
																		]).
web_control_routine_def1( hidden, [['sCtrlName', 			[[char,1024, 0, 0], in] ],
																	['sValue', 					[[char,1024, 0, 0], in] ]
																		]).
web_control_routine_def1( button, [	
									['sCtrlName',   	[[char, 254, 0, 0], in] ],
									['sJsCode',			[[char, 254, 0, 0], in] ],
									['sCaption',   		[[char, 254, 0, 0], in] ],
									['sUserOnClickCode',	[[char,1024, 0, 0], in] ],
									['nJScriptCode',	[[int ,   5, 0, 0], in] ],
									['sTooltipText',	[[char,1024, 0, 0], in] ],
									['sAccesskey',   	[[char, 254, 0, 0], in] ],
									['sStyleString',  	[[char,1024, 0, 0], in] ],
									['sClassString',  	[[char,1024, 0, 0], in] ],
									['nVisible',   		[[int, 9, 0, 0], in] ],
									['nEnabled',   		[[int, 9, 0, 0], in] ],
									['sBorderStyle',  	[[char,1024, 0, 0], in] ],
									['sEventName',   	[[char,1024, 0, 0], in] ],
									['sTags',   		[[char, 254, 0, 0], in] ],
									['sJsDynCode',		[[char, 254, 0, 0], in] ],
									['nReset', 			[[int,    9, 0, 0], in] ] %TypeExp
									]).
web_control_routine_def1( link_end, [['sLinkURL', 		[[char, 254, 0, 0], in] ]]).
web_control_routine_def1( OType, Parms):-
	on( [OType, OType0], [[combobox, combobox0], [listbox, listbox0]]),
	web_control_routine_def1( OType0, OldParms),
	concat_l( OldParms, [['bSendHidden', [[boolean ,  1, 0, 0], in]]], Parms),
	!.
web_control_routine_def1( OType, 	[	ParmObj,
									['sCtrlName', 		[[char, 256, 0, 0], in] ],
									['sValue', 			[[char,1024, 0, 0], in] ],
									['nRows',			[[int ,   5, 0, 0], in] ],
									['sUserOnClickCode',[[char,1024, 0, 0], in] ],
									['nJScriptCode',	[[int ,   5, 0, 0], in] ],									
									['sEventName',   	[[char,1024, 0, 0], in] ],
									['sType', 			[[char,1024, 0, 0], in] ],		
									['sTooltipText',	[[char,1024, 0, 0], in] ],									
									['nVisible',  		[[int ,   5, 0, 0], in] ],
									['nEnabled',  		[[int ,   5, 0, 0], in] ],
									['nRTEnabled',  	[[int ,   5, 0, 0], in] ],									
									['nFormat',  		[FormatType, in] ],
		                            ['nWidth',			[[int ,   5, 0, 0], in] ],
		                            ['nWidthUnit',		[[char,   256, 0, 0], in] ],
									['nHeight',			[[int ,   5, 0, 0], in] ],
		                            ['nHeightUnit',		[[char,   256, 0, 0], in] ],
									['sStyleString',  	[[char,1024, 0, 0], in] ],
									['sClassString',  	[[char,1024, 0, 0], in] ],
									['sTags', 			[[char,1024, 0, 0], in] ],
									['sFormatedValue',	[[char,1024, 0, 0], in] ]																
									]):-
	on( OType, [combobox0, listbox0]),
	obj_type_and_name( OType, ParmObj),
	property_type( $Format$, FormatType),
	!.
web_control_routine_def1( radio,	[['RObjCtrl',		[[obj(radio), 0, 0, 0], in] ],
									['sCtrlName', 		[[char, 256, 0, 0], in] ],
									['sValue', 			[[char,1024, 0, 0], in] ],
									['sTooltipText',	[[char,1024, 0, 0], in] ],
									['nVisible',  		[[int ,   5, 0, 0], in] ],
									['nEnabled',  		[[int ,   5, 0, 0], in] ],
									['nRadioColumns',	[[int ,   5, 0, 0], in] ],
									['nOrientation',	[[int ,   5, 0, 0], in] ],
									['sStyleString',  	[[char,1024, 0, 0], in] ],
									['sClassString',  	[[char,1024, 0, 0], in] ],
									['nJScriptCode',	[[int ,   5, 0, 0], in] ],
									['sUserOnClickCode',	[[char,1024, 0, 0], in] ],									
									['sEventName',   	[[char,1024, 0, 0], in] ],
									['sTags', 		[[char,1024, 0, 0], in] ]]):-
	!.
web_control_routine_def1( checkbox,	[['sCtrlName', 		[[char, 256, 0, 0], in] ],
									['sValue', 		[[char,1024, 0, 0], in] ],
									['sTooltipText',	[[char,1024, 0, 0], in] ],
									['nVisible',  		[[int ,   5, 0, 0], in] ],
									['nEnabled',  		[[int ,   5, 0, 0], in] ],
									['sCheked',  		[[char,1024, 0, 0], in] ],
									['sCaption',		[[char,1024, 0, 0], in] ],
									['sStyleString',  	[[char,1024, 0, 0], in] ],
									['sClassString',  	[[char,1024, 0, 0], in] ],
									['sTags', 		[[char,1024, 0, 0], in] ]]):-
	!.
web_control_routine_def1( bitmap,	[	['sInternalName', 		[[char, 256, 0, 0], in] ],										
										['sImageURL',			[[char,2048, 0, 0], in] ],
										['sLinkURL',			[[char,2048, 0, 0], in] ],
										['sLinkTarget',			[[char,2048, 0, 0], in] ],
										['sAccesskey',   		[[char, 254, 0, 0], in] ],
										['sThemeName',			[[char,2048, 0, 0], in] ],
										['nVisible',  			[[int ,   5, 0, 0], in] ],
										['nEnabled',  			[[int ,   5, 0, 0], in] ],
										['sAlternateText',		[[char,1024, 0, 0], in] ],
										['sTooltipText',		[[char,1024, 0, 0], in] ],
										['nBorderWidth',		[[int ,   5, 0, 0], in] ],
										['nAutoresize',			[[int ,   5, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],
										['nWidthUnit',			[[char,   2, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['nHeightUnit',			[[char,   2, 0, 0], in] ],
										['nVerticalSpace',		[[int ,   5, 0, 0], in] ],
										['nHorizontalSpace',	[[int ,   5, 0, 0], in] ],							
										['nJScriptCode',		[[int ,   5, 0, 0], in] ],
										['sUserOnClickCode',	[[char,1024, 0, 0], in] ],
										['sEventName',   		[[char,1024, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ],
										['sClassString',  		[[char,1024, 0, 0], in] ],
										['sAlign',  			[[char,1024, 0, 0], in] ],
										['sInputTags', 			[[char,1024, 0, 0], in] ],
										['sImageTags', 			[[char,1024, 0, 0], in] ],
										['sUseMap', 			[[char,1024, 0, 0], in] ],
										['sJsDynCode',			[[char, 254, 0, 0], in] ],
										['nReadOnly',  			[[int ,   5, 0, 0], in] ],
										['bIsBlob',				[[boolean,1, 0, 0], in] ],
										['bIsAttribute',		[[boolean,1, 0, 0], in] ] ]):-
	!.
web_control_routine_def1( bitmap_readonly,	[	['sInternalName', 		[[char, 256, 0, 0], in] ],										
										['sImageURL',			[[char,2048, 0, 0], in] ],
										['sLinkURL',			[[char,2048, 0, 0], in] ],
										['sLinkTarget',			[[char,2048, 0, 0], in] ],
										['sAccesskey',   		[[char, 254, 0, 0], in] ],
										['sThemeName',			[[char,2048, 0, 0], in] ],
										['nVisible',  			[[int ,   5, 0, 0], in] ],
										['nEnabled',  			[[int ,   5, 0, 0], in] ],
										['sAlternateText',		[[char,1024, 0, 0], in] ],
										['sTooltipText',		[[char,1024, 0, 0], in] ],
										['nBorderWidth',		[[int ,   5, 0, 0], in] ],
										['nAutoresize',			[[int ,   5, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],
										['nWidthUnit',			[[char,   2, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['nHeightUnit',			[[char,   2, 0, 0], in] ],
										['nVerticalSpace',		[[int ,   5, 0, 0], in] ],
										['nHorizontalSpace',	[[int ,   5, 0, 0], in] ],										
										['nJScriptCode',		[[int ,   5, 0, 0], in] ],
										['sUserOnClickCode',	[[char,1024, 0, 0], in] ],
										['sEventName',   		[[char,1024, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ],
										['sClassString',  		[[char,1024, 0, 0], in] ],
										['sAlign',  			[[char,1024, 0, 0], in] ],
										['sTags', 				[[char,1024, 0, 0], in] ],
										['sUseMap', 			[[char,1024, 0, 0], in] ],
										['sJsDynCode',			[[char, 254, 0, 0], in] ],
										['sCallerPgm',			[[char,1024, 0, 0], in] ] ]):-
	!.
web_control_routine_def1( multimedia_upload_start,	[	['sInternalName', 		[[char, 256, 0, 0], in] ],
										['nVisible',  			[[int ,   5, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ] ]):-
	!.
web_control_routine_def1( multimedia_upload_end,	[	['sInternalName', 		[[char, 256, 0, 0], in] ],
										['sMultimediaURL',		[[char,2048, 0, 0], in] ],
										['sTooltipText',		[[char,1024, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],
										['nWidthUnit',			[[char,   2, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['nHeightUnit',			[[char,   2, 0, 0], in] ],
										['sUserOnClickCode',	[[char,1024, 0, 0], in] ],
										['sEventName',   		[[char,1024, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ],
										['sClassString',  		[[char,1024, 0, 0], in] ],
										['sAlign',  			[[char,1024, 0, 0], in] ],
										['sInputTags', 			[[char,1024, 0, 0], in] ],
										['nReadOnly',  			[[int ,   5, 0, 0], in] ],
										['bIsBlob',				[[boolean,1, 0, 0], in] ],
										['sAccept', 			[[char,1024, 0, 0], in] ],
										['sCallerPgm',			[[char,1024, 0, 0], in] ] ]):-
	!.
web_control_routine_def1( Multimedia,[	['sInternalName', 		[[char, 256, 0, 0], in] ],
										['sMultimediaURL',		[[char,2048, 0, 0], in] ],
										['nDisplay',  			[[int ,   5, 0, 0], in] ],
										['nVisible',  			[[int ,   5, 0, 0], in] ],
										['nEnabled',  			[[int ,   5, 0, 0], in] ],
										['nAutoresize',			[[int ,   5, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],
										['nWidthUnit',			[[char,   2, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['nHeightUnit',			[[char,   2, 0, 0], in] ],
										['nJScriptCode',		[[int ,   5, 0, 0], in] ],
										['sUserOnClickCode',	[[char,1024, 0, 0], in] ],
										['sEventName',   		[[char,1024, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ],
										['sClassString',  		[[char,1024, 0, 0], in] ],
										['sInputTags', 			[[char,1024, 0, 0], in] ],
										['sMultimediaTags',		[[char,1024, 0, 0], in] ],
										['sJsDynCode',			[[char, 254, 0, 0], in] ],
										['nReadOnly',  			[[int ,   5, 0, 0], in] ],
										['bIsBlob',				[[boolean,1, 0, 0], in] ] ]):-
	Multimedia = audio; Multimedia = video,
	!.
web_control_routine_def1( blob,	[		['sInternalName', 		[[char, 256, 0, 0], in] ],
										['sValue', 				[[char,1024, 0, 0], in] ],
										['sURL',				[[char,2048, 0, 0], in] ],
										['sContenttype',		[[char,2048, 0, 0], in] ],
										['bHasFiletypeatt',		[[boolean,1, 0, 0], in] ],
										['sLinktarget',			[[char,2048, 0, 0], in] ],
										['sObjecttagparameters',[[char,2048, 0, 0], in] ],
										['nDisplay',  			[[int ,   5, 0, 0], in] ],
										['nEnabled',  			[[int ,   5, 0, 0], in] ],
										['nVisible',  			[[int ,   5, 0, 0], in] ],
										['sAlternateText',		[[char,1024, 0, 0], in] ],
										['sTooltipText',		[[char,1024, 0, 0], in] ],
										['nBorderWidth',		[[int ,   5, 0, 0], in] ],
										['nAutoresize',			[[int ,   5, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],
										['nWidthUnit',				[[char ,   2, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['nHeightUnit',				[[char ,   2, 0, 0], in] ],
										['nVerticalSpace',		[[int ,   5, 0, 0], in] ],
										['nHorizontalSpace',	[[int ,   5, 0, 0], in] ],
										['nJScriptCode',		[[int ,   5, 0, 0], in] ],
										['sUserOnClickCode',	[[char,1024, 0, 0], in] ],
										['sEventName',   		[[char,1024, 0, 0], in] ],
										['sStyleString',  		[[char,1024, 0, 0], in] ],
										['sClassString',  		[[char,1024, 0, 0], in] ],
										['sInputTags', 			[[char,1024, 0, 0], in] ],
										['sDisplayTags', 		[[char,1024, 0, 0], in] ],
										['sJsDynCode',		[[char, 254, 0, 0], in] ]]):-
	!.
web_control_routine_def1( on_js_event,
																	[	['sEventName',				[[char,256, 0, 0], in] ],
																		['sEventJsCode',			[[char,2048, 0, 0], in] ]
																	]):-
	!.
web_control_routine_def1( custom_attribute,
																	[	['sControlName',			[[char,2048, 0, 0], in] ],
																		['sAttName',				[[char,256, 0, 0], in] ],
																		['sAttValue',			[[char,2048, 0, 0], in] ],
																		['bCustomEvent',			[[boolean, 1, 0, 0], in] ]
																	]):-
	!.
web_control_routine_def1( label,		[	['sInternalName', 		[[char, 256, 0, 0], in] ],
							['sCaption',   			[[char, 254, 0, 0], in] ],
							['sLinkURL',			[[char,2048, 0, 0], in] ],
							['sLinkTarget',			[[char,2048, 0, 0], in] ],
							['sUserOnClickCode',		[[char,2048, 0, 0], in] ],
							['sEventName',   		[[char,1024, 0, 0], in] ],
							['sTags',   			[[char,1024, 0, 0], in] ],
							['sClassString',  		[[char,1024, 0, 0], in] ],
							['nJScriptCode',		[[int ,   5, 0, 0], in] ],
							['sTooltipText',		[[char,1024, 0, 0], in] ],
							['nVisible',  			[[int ,   5, 0, 0], in] ],
							['nEnabled',  			[[int ,   5, 0, 0], in] ],
							['nFormat',  			[FormatType		  , in] ]]):-
	property_type( $Format$, FormatType),
	!.
web_control_routine_def1( start_js_anchor,	[	%['sInternalName', 		[[char, 256, 0, 0], in] ],
																						['sGXOnClickCode',		[[char,2048, 0, 0], in] ],
																						['sUserOnClickCode',	[[char,2048, 0, 0], in] ],
																						['sLinkURL',					[[char,2048, 0, 0], in] ],
																						['sLinkTarget',				[[char,2048, 0, 0], in] ]
																					]):-
	!.
web_control_routine_def1( end_js_anchor,		[	['sGXOnClickCode',		[[char,2048, 0, 0], in] ],
																						['sUserOnClickCode',	[[char,2048, 0, 0], in] ],
																						['sLinkURL',					[[char,2048, 0, 0], in] ]
																					]):-
	!.
web_control_routine_def1( div_start, [	['sInternalName', 		[[char, 256, 0, 0], in] ],
										['nVisible',  		[[int ,   5, 0, 0], in] ],
										['nWid 8 th',				[[int ,   5, 0, 0], in] ],		  
										['sWidthUnit',			[[char,   256, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['sHeightUnit',			[[char,   256, 0, 0], in] ],
										['sClassString',		[[char,1024, 0, 0], in] ],
										['sTags',				[[char,1024, 0, 0], in] ]]):-
	!.
web_control_routine_def1( embpage, [	['sInternalName', 		[[char, 256, 0, 0], in] ],
										['sSrc',  		[[char, 256, 0, 0], in] ],
										['nVisible',  		[[int ,   5, 0, 0], in] ],
										['nWidth',				[[int ,   5, 0, 0], in] ],		  
										['sWidthUnit',			[[char,   256, 0, 0], in] ],
										['nHeight',				[[int ,   5, 0, 0], in] ],
										['sHeightUnit',			[[char,   256, 0, 0], in] ],
										['nBorderStyle',		[[int ,   5, 0, 0], in] ],
										['sAlign',		[[char ,   1024, 0, 0], in] ],
										['sTooltipText',  			[[char ,   1024, 0, 0], in] ],
										['sScroll',	[[char ,   2048, 0, 0], in] ]]):-
	!.
	
:- public obj_type_and_name/2.
obj_type_and_name( OType, ['CObjCtrl', 		[[obj(combo), 0, 0, 0], in] ]):-
	on_test( OType, [combobox, combobox0]),
	!.
obj_type_and_name( OType, ['LObjCtrl', 		[[obj(listbx), 0, 0, 0], in] ]):-
	on_test( OType, [listbox, listbox0]),
	!.

dcl_web_control_routine_parms(Name):-
	web_control_routine_def( Name, PListMed),
	add_web_routine_parms_l(Name, PListMed, PList),
	on([PName, [PType|_]], PList),
	[!
		dcl_routine_parm( PName, PType)
	!],
	fail.
dcl_web_control_routine_parms(_):-
	!.

:- public declare_start_web_control_routine/4.
declare_start_web_control_routine(Name, Routine, Return, LocalVars):-
	declare_start_web_control_routine(pg, Name, Routine, Return, LocalVars),
	!.

:- public declare_start_web_control_routine/5.
declare_start_web_control_routine(Type, Name, Routine, Return, LocalVars):-
	dcl_web_control_routine_parms(Name),
#if $vbasic
	web_control_routine_def( Name, PListMed),
	add_web_routine_parms_l(Name, PListMed, PList),
#else
	web_control_routine_parm_names( Name, PList),
#endif
	start_routine( Type, Routine, Return, PList, LocalVars),
	!.

:- public declare_start_web_control_routine/3.
declare_start_web_control_routine(Name, Routine, LocalVars):-
	declare_start_web_control_routine(Name, Routine, [], LocalVars),
	!.

:- public web_ctrl_name_tag/2.
web_ctrl_name_tag(Token, Tag):-
	web_ctrl_name_tag(Token, 0, Tag),
	!.

:- public web_ctrl_name_tag/3.
web_ctrl_name_tag(Token, _ /*SId*/, Tag):-
	name_tag_exp( [t([Token,t('Internalname',3)],29)], Tag),
	!.

:-public name_tag_exp/2:far.
name_tag_exp( NameToken, Tag):-
	concat_t( [ [t($' name="'$, 3), t($+$,5)], NameToken, [t($+$,5), t($'"'$,3)]  ], Tag),
	!.

:- public class_tok_2_ro_class_tok/2.
class_tok_2_ro_class_tok( Classtok, [t($'Readonly'$, 3), t('+',5), Classtok]):-
	!.
