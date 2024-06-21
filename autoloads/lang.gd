extends Node

var lang = "es"

var texts = {
	"ab_name_berserk_es": "Berserker es",
	"ab_desc_berserk_es": "Berserker: La furia se apodera de ti y haciendote capaz de vencer a quien sea que te enfrentes. Ganas +3@SW pero pierdes -1@HP.",
	
	"slat_SW_es": "ESPADA: Estos slats te permitirán superar desafios de combate y fuerza bruta.",
	"slat_GR_es": "MECANISMO: Estos slats te permitirán superar desafios mecanicos como abrir cerraduras y desactivar trampas.",
	"slat_EY_es": "OJO: Estos slats hacen referencia a la percepción, te permitirán superar desafios con los sentidos y encontrar cosas ocultas.",
	"slat_BT_es": "BOTA: Estos slats te permitirán moverte agilmente y ciertas habilidades como evadir daño.",
	"slat_SC_es": "PERGAMINO: Estos slats te permitirán manipular la magia para lanzar conjuros o superar trampas runicas.",
	"slat_SH_es": "ESCUDO: Estos slats te protegen del daño que puedas recibir.",
	"it_desc_short_sword_es": "ESPADA CORTA: Una pequeña espada bien afilada. Añade DOS ESPADA.",
}

var images = {
	"@SW":"[img=15]res://assets/bbimg/bb_SW.png[/img]",
	"@HP":"[img=15]res://assets/bbimg/bb_hp.png[/img]"
}

func get_text(code):
	var lang_code = code+"_"+lang
	if !lang_code in texts: return "<"+lang_code+">"
	else: 
		var tx = texts[lang_code]
		if "@" in tx: 
			for k in images.keys(): tx = tx.replace(k,images[k])
			return "[center]"+tx+"[/center]"
		else: return tx
