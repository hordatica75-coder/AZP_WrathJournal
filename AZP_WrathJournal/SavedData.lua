AZP = AZP or {}
AZP.WrathJournal = AZP.WrathJournal or {}

AZP.WrathJournal.Instances = {
    ["ICC"] = {
        name = "Ciudadela Corona de Hielo",
        encounters = {
            { id = 1, name = "Lord Tuétano" },
            { id = 2, name = "Lady Susurramuerte" },
            { id = 3, name = "Batalla Aérea" },
            { id = 4, name = "Libramorte Colmillosauro" },
            { id = 5, name = "Carapútrea" },
            { id = 6, name = "Panzachancro" },
            { id = 7, name = "Profesor Putricida" },
            { id = 8, name = "Consejo de Sangre" },
            { id = 9, name = "Reina de Sangre Lana'thel" },
            { id = 10, name = "Valithria Caminasueños" },
            { id = 11, name = "Sindragosa" },
            { id = 12, name = "El Rey Exánime" },
        }
    }
}

local TEXTURE_PATH = "Interface\\AddOns\\AZP_WrathJournal\\texture\\"

AZP.WrathJournal.RetailSectionData = {
    [1] = {
        name = "Lord Tuétano",
        image = TEXTURE_PATH .. "tuetano",
        description = "Primer jefe de ICC guardando la Aguja de Hielo.",
        abilities = {
            { name = "Tajo de Hueso", desc = "Cada 1.5s. Divide el 300% del daño de arma entre el Tanque Principal y los 2 jugadores más cercanos frente a él." },
            { name = "Púa de Hueso Empaladora", desc = "Cada 18s (fuera de Tormenta NM). Empala a 1 (10v) o 3 (25v) jugadores. Inflige 10% de vida máx. inicial + 10% por segundo hasta destruirla." },
            { name = "Llama Fría", desc = "Líneas azules que avanzan en cruz o línea recta desde el jefe. Infligen daño de Escarcha masivo por segundo a quien permanezca encima." },
            { name = "Tormenta de Huesos", desc = "CD: 90s. Dura 20s. Gira cargando a objetivos aleatorios, infligiendo daño físico continuo a toda la banda (reducido por distancia) y lanzando Llamas Frías." }
        },
        adds = nil,
        heroic = "• TORMENTA CON PÚAS: Lanza Púas de Hueso Empaladoras DURANTE la Tormenta de Huesos.\n• LLAMA FRÍA MORTAL: El daño de la Llama Fría es casi el doble de alto; quedarse parado más de 1s causa muerte instantánea.",
        strategy = "• TANQUES: Pegados estrictamente uno dentro del otro frente al jefe. JAMÁS girar al boss hacia la banda.\n• MELEE: Posicionados siempre en la espalda del jefe. Si una púa cae en melee, cambio de FOCUS DPS directo a la púa.\n• RANGOS/HEALERS: Agrupados a media distancia para concentrar el spawn de las Púas.\n• HEROICO EN TORMENTA: Si cae una Púa dentro del fuego azul durante la Tormenta, usar CDs defensivos en el empalado y mover la banda para romper la púa sin pisar Llama Fría."
    },
    [2] = {
        name = "Lady Susurramuerte",
        image = TEXTURE_PATH .. "ladysusurramuerte",
        description = "Líder del Culto de los Malditos.",
        abilities = {
            { name = "Barrera de Maná (Fase 1)", desc = "Protege a la jefa consumiendo su maná como salud. La Fase 1 termina únicamente cuando su maná llega a 0." },
            { name = "Descarga de Escarcha (Fase 2)", desc = "Casteo de 2s al objetivo con más amenaza. Inflige 25k-30k de daño de Escarcha (Interrumpible)." },
            { name = "Dominar Mente (MC)", desc = "Controla a 1 (10HC) o 3 (25HC) jugadores aumentando su daño 200% y sanación 500%." }
        },
        adds = {
            { name = "Espíritus Vengativos (Fase 2)", desc = "¡CRÍTICO ESQUIVAR! Fantasmas transparentes que aparecen cerca de jugadores aleatorios. Persiguen lentamente a su objetivo fijado y explotan al contacto haciendo 20k-25k de daño de Sombra en un área de 10 metros." },
            { name = "Fanático del Culto", desc = "Pega físico pesado. En P1 la jefa puede transformarlo en 'Fanático Reanimado' (Inmune a daño Físico) o 'Fanático Deformado' (Gana 300% daño)." },
            { name = "Adherente del Culto", desc = "Caster que lanza potentes descargas. En P1 puede convertirse en 'Adherente Reanimado' (Inmune a Magia) con Aura de Tormento." }
        },
        heroic = "• INMUNE A TAUNT: En Fase 2 la jefa NO se puede provocar (Taunt). Se debe generar agro a puro dps/amenaza previa.\n• ADDS CONSTANTES: Los Adds de la izquierda y derecha continúan saliendo en Fase 2 cada 45s.\n• DOMINAR MENTE ACTIVO EN P2: Continúa controlando a 3 jugadores en 25HC durante la Fase 2.",
        strategy = "• FASE 1: Rangos dps a la jefa para bajar maná. Melees recogen y matan Adds en los laterales (prioridad Adherentes y Reanimados).\n• CONTROL DE DOMINAR MENTE: Asignar CC instantáneo (Polimorfia, Miedo, Trampa de Hielo) de inmediato a los aliados controlados.\n• FASE 2 Y ESPÍRITUS: Asignar rotación estricta de interrupciones para Descarga de Escarcha. TODOS los jugadores deben alejarse inmediatamente si ven un Espíritu Vengativo nacer cerca de ellos. Si el espíritu te toca, wipeas al grupo melee o rango."
    },
    [3] = {
        name = "Batalla Aérea",
        image = TEXTURE_PATH .. "batalla",
        description = "Combate de naves de guerra entre la Alianza y la Horda.",
        abilities = {
            { name = "Cañón de la Nave", desc = "Acumula calor con Disparo de Cañón. Al llegar a 80-90 de calor, usar Chorro de Calentamiento para vaciar la barra y hacer DPS masivo." },
            { name = "Experiencia de la Tripulación", desc = "Los artilleros y soldados enemigos ganan acumulaciones de veterano si pasan demasiado tiempo vivos, aumentando su daño." }
        },
        adds = {
            { name = "Mago de Batalla Enemigo", desc = "Aparece periódicamente en la nave rival y castea 'Congelación Precipitada', inhabilitando los cañones de tu nave hasta morir." },
            { name = "Sargento / Capitán Enemigo", desc = "Permanecen en la nave rival. Gana acumulaciones de 'Ira Creciente' por cada segundo en combate melee." },
            { name = "Tiradores / Lanzadores de Hachas", desc = "Disparan constantemente a la cubierta de tu nave infligiendo daño continuo." }
        },
        heroic = "• DAÑO INCREMENTADO: Los Tiradores enemigos aplican un debuff acumulativo que aumenta el daño recibido en tu nave.\n• CAPITÁN MORTAL: El Capitán pega extremadamente duro al tanque durante cada abordaje.",
        strategy = "• CAÑONES: Disparar continuo. Tirar Chorro de Calentamiento a 90 de calor. Si llega a 100 calor se bloquea por sobrecalentamiento.\n• GRUPO DE ABORDAJE (Tanque + Melees): Equipar Camisa de Cohete. Al salir el Mago Enemigo, saltar de inmediato a la nave rival, matar al Mago y regresar inmediatamente antes de que el Capitán rival mate al tanque.\n• GRUPO DEFENSIVO (Rangos): Limpiar los tiradores de la nave enemiga desde la cubierta aliada."
    },
    [4] = {
        name = "Libramorte Colmillosauro",
        image = TEXTURE_PATH .. "libramorte",
        description = "El héroe caído de la Horda reanimado por el Rey Exánime.",
        abilities = {
            { name = "Poder de Sangre", desc = "Gana energía con el daño infligido por sus habilidades y Adds. Al llegar a 100 energía, aplica 'Marca del Campeón Caído'." },
            { name = "Marca del Campeón Caído", desc = "Debuff permanente que replica cada golpe que Colmillosauro le da al tanque sobre el marcado. Si el marcado muere, Colmillosauro se cura un 20% de su vida máxima." },
            { name = "Runa de Sangre", desc = "Aplica al tanque actual. Cada golpe cuerpo a cuerpo cura a Colmillosauro por 10 veces la cantidad de daño infligida." }
        },
        adds = {
            { name = "Bestias de Sangre", desc = "CD: 40s. Invoca 2 (10v) o 5 (25v) bestias. Cada golpe que asestan a un jugador otorga 5 de Poder de Sangre y curación al jefe." }
        },
        heroic = "• OLOR A SANGRE: Las Bestias de Sangre reducen la velocidad de movimiento de jugadores cercanos un 80% y reciben 90% MENOS daño de habilidades de área (AOE). Obliga a usar Single Target Focus DPS.",
        strategy = "• CAMBIO DE TANQUE: Intercambiar al jefe INMEDIATAMENTE cuando se aplique Runa de Sangre.\n• CONTROL DE BESTIAS (CD 40s): Ningún melee ni tanque debe tocar las bestias. Usar Cadenas de Hielo, Trampas de Cazador, Tifón, Sombra del Terror (Brujo) o Choque de Ola.\n• FOCUS DPS: Todos los casters y rangos cambian FUEGO RÁPIDO a las Bestias en cuanto spawnean.\n• HEALERS: Asignar sanación dedicada y directa a los jugadores con 'Marca del Campeón Caído'."
    },
    [5] = {
        name = "Carapútrea",
        image = TEXTURE_PATH .. "caraputrea",
        description = "Abominación de peste del Profesor Putricida.",
        abilities = {
            { name = "Infección Mutada", desc = "Cada 15s aplica a un jugador. Inflige daño de Naturaleza y reduce la sanación recibida un 50%. Al disiparse o expirar crea un Moco Pequeño." },
            { name = "Chorro de Babas", desc = "Se gira hacia un jugador aleatorio y lanza un cono de ácido continuo de 5s." }
        },
        adds = {
            { name = "Moco Pequeño", desc = "Aparece al disipar la Infección Mutada. Emite una aura de peste a su alrededor." },
            { name = "Moco Grande", desc = "Se crea al juntar 2 Mocos Pequeños. Pega extremadamente fuerte cuerpo a cuerpo. Absorbe otros mocos pequeños sumando cargas." },
            { name = "Moco Explotador", desc = "Al alcanzar 5 cargas, el Moco Grande se inmoviliza y tras 4s explota lanzando proyectiles de peste a toda la sala." }
        },
        heroic = "• GAS INUNDANTE: El Profesor Putricida inunda cuadrantes enteros de la sala con gas tóxico, obligando a toda la banda a estar dispersa y moverse en círculo continuamente.",
        strategy = "• OFFTANQUE: Su único trabajo es amasar y kitear el Moco Grande en círculos alrededor del borde exterior de la sala.\n• JUGADORES CON INFECCIÓN: Correr INMEDIATAMENTE a la espalda del Offtanque para disipar/fusionar su Moco Pequeño al Moco Grande y regresar a su posición.\n• BANDA: Evitar el frente del Chorro de Babas. Cuando el Moco Grande llegue a 5 cargas y explote, mirar al techo/suelo para esquivar los proyectiles."
    },
    [6] = {
        name = "Panzachancro",
        image = TEXTURE_PATH .. "panzachancro",
        description = "Abominación que inhala y exhala gas venenoso.",
        abilities = {
            { name = "Inhalar Añublo", desc = "Cada 30s inhala el gas de la sala (hasta 3 veces), aumentando su velocidad de ataque y daño físico un 30% por carga." },
            { name = "Añublo Acabrumador", desc = "Tras 3 Inhalaciones, expulsa todo el gas acumulado infligiendo 45k-50k de daño de Sombra a toda la banda si no están inoculados." },
            { name = "Espora de Gas", desc = "Cada 40s marca a jugadores. Explotan tras 12s otorgando la marca 'Inoculación' (reduce daño de Sombra un 25% por carga, acumulable hasta 3)." },
            { name = "Hinchazón Gástrica", desc = "Aplica al tanque. A las 10 cargas explota matando al tanque y causando un wipe instantáneo." }
        },
        adds = nil,
        heroic = "• MOCO MALEABLE: Putricida lanza Mocos Maleables desde el balcón cada 20s a los rangos. Si impacta, reduce la velocidad de casteo y ataque un 200% durante 20s.",
        strategy = "• TANQUES: Cambiar obligatoriamente de tanque a las 8 o 9 acumulaciones de Hinchazón Gástrica.\n• ESPORAS: Asignar 2 marcas (1 en melee, 1 en rango). Los marcados corren a sus marcas asignadas para otorgar las 3 capas de Inoculación antes del Añublo Acabrumador.\n• HEROICO: Rangos dispersos a 8m. Moverse DE INMEDIATO al ver la sombra verde del Moco Maleable en el suelo."
    },
    [7] = {
        name = "Profesor Putricida",
        image = TEXTURE_PATH .. "profesor",
        description = "La mente maestra detrás de las plagas de la Ciudadela.",
        abilities = {
            { name = "Charco de Babas", desc = "Lanza viales que crean charcos verdes crecientes en el suelo." },
            { name = "Bomba de Gas Puerco", desc = "Lanza viales naranjas que explotan infligiendo gran daño y reduciendo el índice de golpe un 75%." },
            { name = "Fuerza Mutada (Fase 3 - 35%)", desc = "Pega masivamente más rápido. Aplica debuff al tanque que aumenta el daño recibido por toda la banda." }
        },
        adds = {
            { name = "Moco Volátil (Verde)", desc = "Fija a un objetivo imprevisto. Requiere que toda la banda se amontone con el fijado para compartir el daño de la explosión." },
            { name = "Moco Gasífero (Naranja)", desc = "Fija a un objetivo aplicando Gas Hincha. El jugador marcado debe kitearlo activamente mientras los DPS a distancia lo matan." },
            { name = "Abominación Mutada (Vehículo)", desc = "Un tanque la controla: su tarea es comerse los charcos verdes del suelo para ganar energía y lanzar mocos ralentizantes a los Adds." }
        },
        heroic = "• PESTE DESATADA: Debuff con daño creciente por segundo. Debe pasarse a otro jugador cada 5-6s chocando contra él.\n• TRANSICIONES SOBRECARGADAS (80% y 35%): Invoca el Moco Verde Y el Moco Naranja AL MISMO TIEMPO durante el cambio de fase.",
        strategy = "• ABOMINACIÓN: Comer charcos verdes sin descanso. Usar la ralentización en el Moco Naranja y Verde.\n• TRANSICIONES: Guardar CDs de dps. Focus prioritario al Moco Verde (juntarse con él), luego destruir el Moco Naranja antes de golpear al boss.\n• FASE 3 (35%): Tirar Heroísmo/Ansia de Sangre. Tanques rotar a las 2 cargas de Fuerza Mutada. Quemar al boss antes de quedarse sin espacio en la sala."
    },
    [8] = {
        name = "Consejo de Sangre",
        image = TEXTURE_PATH .. "consejos",
        description = "Trío de príncipes San'layn resucitados.",
        abilities = {
            { name = "Invocación de Sangre", desc = "Otorga 99,999 de vida al príncipe activo. Los otros dos quedan en 1 de vida e inmunes al daño real." },
            { name = "Centella Oscura Potenciada (Taldaram)", desc = "Lanza una bola de fuego gigante persiguiendo a un jugador. Debe ser amortiguada por otros jugadores en su trayectoria para reducir su daño mortal antes del impacto." },
            { name = "Vórtice de Choque Potenciado (Valanar)", desc = "Crea vórtices de aire cerca de todos los jugadores que empujan violentamente y dañan si están a menos de 12 metros." },
            { name = "Núcleos Oscuros (Keleseth)", desc = "Orbes negros flotantes. El Tanque de Keleseth (Ej. Brujo) debe agarrear múltiples núcleos para amortiguar el daño de Sombra de Lanzada de Sombras Potenciada." }
        },
        adds = nil,
        heroic = "• PRISIÓN DE SOMBRAS: Moverse otorga un debuff acumulativo que inflige daño de Sombra creciente por cada paso dado.",
        strategy = "• DPS: Cambiar inmediatamente de objetivo al Príncipe que tenga la Invocación de Sangre activa.\n• TANQUE KELESETH (BRUJO): Mantener mínimo 3-4 Núcleos Oscuros orbitando para no morir de un solo golpe.\n• VALANAR POTENCIADO: Toda la raid debe dispersarse a MÁS DE 12 METROS al instante.\n• HEROICO: Moverse estrictamente con pasos cortos solo cuando sea necesario para evitar acumular Prisión de Sombras."
    },
    [9] = {
        name = "Reina de Sangre Lana'thel",
        image = TEXTURE_PATH .. "reina",
        description = "Líder de los vampiros San'layn.",
        abilities = {
            { name = "Esencia de la Reina de Sangre", desc = "Aumenta el daño infligido un 100%. Tras 60s obliga al jugador a morder a un compañero no mordido en menos de 10s o caer bajo Control Mental." },
            { name = "Sombras Enjambres", desc = "Fuego morado persigue a un jugador dejando rastros en el suelo." },
            { name = "Peste de Sangre Caída (Fase Aérea)", desc = "Al 75% y 50% vuela al centro, castea Miedo masivo y lanza proyectiles de área a toda la sala durante 6s." }
        },
        adds = nil,
        heroic = "• DAÑO DE AURA ELEVADO: El pulso continuo de daño de Sombra en toda la sala es drásticamente más alto, exigiendo curación constante.",
        strategy = "• CADENA DE MORDISCOS (1->2->4->8->16): Los DPS top muerden primero. Seguir una lista estricta de morder para no repetir objetivos.\n• SOMBRAS ENJAMBRES: El jugador marcado corre de inmediato pegado a las paredes exteriores de la sala.\n• FASE AÉREA: Al volar la jefa, separarse a más de 6 metros entre todos los jugadores. Healers usar Sacrificio Divino / Maestría en Auras."
    },
    [10] = {
        name = "Valithria Caminasueños",
        image = TEXTURE_PATH .. "valithria",
        description = "Dragón Verde capturado que debe ser sanado en lugar de derrotado.",
        abilities = {
            { name = "Portales de Pesadilla", desc = "Abre portales verdes. Permiten a los healers entrar al Mundo del Sueño y juntar nubes verdes para ganar 'Vigor Esmeralda' (aumenta sanación y regen de maná)." }
        },
        adds = {
            { name = "Supresores", desc = "¡FOCUS PRIORITARIO! Salen en hordas grandes y reducen la sanación recibida por Valithria un 10% por cada supresor vivo." },
            { name = "Esqueleto de Abotagamiento", desc = "Lanza Machacar Casco y Vaciado de Salud (AOE de fuego pesado a la raid)." },
            { name = "Zombie Pululante", desc = "Aplica daño físico extremo y al morir explota soltando Gusanos de Ácido." },
            { name = "Archimago de la Plaga", desc = "Crea Columnas de Escarcha que lanzan por los aires a los jugadores." }
        },
        heroic = "• MENOS PORTALES: Solo aparecen 3 Portales de Pesadilla en 25HC.\n• DAÑO ELEVADO DE ADDS: Los Esqueletos y Archimagos matan a la banda si no se controlan de inmediato.",
        strategy = "• HEALERS DE PORTAL: Entrar a portales, coger la mayor cantidad de nubes volando, salir y tirar todos los CDs defensivos/sanación directamente en Valithria.\n• PRIORIDAD DPS: Supresores (FOCUS ABSOLUTO) > Esqueletos de Abotagamiento > Archimagos > Zombies.\n• TANQUES: Agarrar Zombies lejos del grupo principal y aplicar stuns continuos a los Esqueletos."
    },
    [11] = {
        name = "Sindragosa",
        image = TEXTURE_PATH .. "sindragosa",
        description = "La antigua reina de los Dragones de Hielo.",
        abilities = {
            { name = "Helada Desencadenada", desc = "Debuff a casters/healers. Lanzar hechizos acumula 'Frenesí'. Al expirar causa una explosión Arcana que daña a los aliados cercanos." },
            { name = "Frío Virulento", desc = "Atracción masiva a la posición de la jefa seguida de un casteo de 5s que inflige 35k de daño en un radio de 25 metros." },
            { name = "Tumba de Hielo (Fase Aérea y P3)", desc = "Marca a jugadores y los encierra en bloques de hielo asfixiantes." }
        },
        adds = nil,
        heroic = "• SACUDIDA MÍSTICA CONSTANTE EN P3: En Fase 3 (35%), el debuff de aumento de daño mágico se aplica a TODA la raid continuamente y solo se resetea al ocultarse tras una Tumba de Hielo.",
        strategy = "• CASTERS: Detener el casteo al llegar a 4-5 acumulaciones de Helada Desencadenada hasta que se borre el debuff.\n• FRÍO VIRULENTO: Al ser atraídos, girar 180° y correr fuera del radio de 25 metros de inmediato.\n• FASE 3 (35%): Colocar a los marcados con Tumba de Hielo en la espalda del boss de manera ordenada. Toda la raid debe ocultarse detrás de la tumba para reiniciar las acumulaciones de Sacudida Mística cada 2 marcas."
    },
    [12] = {
        name = "El Rey Exánime",
        image = TEXTURE_PATH .. "exanime",
        description = "Señor Supremo de la Plaga en el Trono de Hielo.",
        abilities = {
            { name = "Peste Necrótica (Fase 1)", desc = "Debuff que inflige gran daño por segundo. Al disiparse o morir el portador, salta al objetivo más cercano aumentando su daño acumulativamente. Se usa para exterminar a los Ghouls." },
            { name = "Infestar (Fase 1 y 2)", desc = "CD: 20s. Daño masivo de Sombra a toda la raid. El daño ticking solo se detiene si la salud del jugador supera el 90%." },
            { name = "Profanar (Fase 2 y 3)", desc = "CD: 35s. Charco negro en el suelo bajo un jugador. Crece exponencialmente en tamaño y daño cada milisegundo que alguien permanezca dentro." }
        },
        adds = {
            { name = "Espíritus Malvados (Fase 3)", desc = "¡MECÁNICA CRÍTICA! En P3 (40%), invoca 10-15 espíritus flotantes en el aire. Tras unos segundos bajan hacia la raid y explotan infligiendo daño masivo en área. Se deben ralentizar/matar en el aire o absorber con Inmunidades." },
            { name = "Val'kyr Guardiana (Fase 2)", desc = "CD: 45s. Agarra a jugadores y los lleva al borde de la plataforma para tirarlos al vacío. En Heroico, al llegar al 50% de vida sueltan al jugador." },
            { name = "Trampa de Sombras (P1 Heroico)", desc = "Estructura invisible/morada en el suelo. Si alguien la pisa, explota lanzando a volar a todos los jugadores cercanos fuera de la plataforma." },
            { name = "Drácolich / Ghouls (Fase 1)", desc = "Adds acumulados por el Tanque Secundario para traspasarles la Peste Necrótica." }
        },
        heroic = "• TRAMPA DE SOMBRAS EN P1: Requiere atención absoluta para no pisarla.\n• VAL'KYRS RESISTENTES: Tienen mucha más vida; al llegar al 50% sueltan al jugador.\n• ESPÍRITUS MALVADOS EN P3: Explotan matando instantáneamente a quien toquen si no se coordinan las inmunidades.",
        strategy = "• FASE 1: Disipar Peste Necrótica cerca de los Ghouls. Esquivar la Trampa de Sombras.\n• FASE 2 (70%): JUNTAR A LA RAID 5s antes del DBM de Val'kyrs para meter Stuns masivos (Choque de Ola, Martillo de Justicia, Espiral). Al salir Profanar (35s CD), el marcado corre INMEDIATAMENTE fuera de la raid.\n• FASE 3 (40%): Limpiar los Espíritus Malvados en el aire con dps a distancia o inmunidades (Escudo Divino de Paladín / Capa de Sombras de Pícaro) antes de que toquen el suelo."
    }
}