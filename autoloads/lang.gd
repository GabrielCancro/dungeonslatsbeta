extends Node

var lang = "es"

var texts = {
	"ab_desc_direct_attack_es": "Ataque Directo: Consume 2xESPADA para dañar 1xVIDA a un enemigo.",
	"ab_desc_power_attack_es": "Ataque Poderoso: Consume 3xESPADA para dañar 2xVIDA a un enemigo.",
	"ab_desc_unlock_es": "Destrabar Mecanismo: Consume 2xMANO para resolver 1xENGRANAJE de un mecanismo.",
	
	"slat_SW_es": "ESPADA: Estos slats te permitirán superar desafios de combate y fuerza bruta.",
	"slat_GR_es": "MECANISMO: Estos slats te permitirán superar desafios mecanicos como abrir cerraduras y desactivar trampas.",
	"slat_EY_es": "OJO: Estos slats hacen referencia a la percepción, te permitirán superar desafios con los sentidos y encontrar cosas ocultas.",
	"slat_BT_es": "BOTA: Estos slats te permitirán moverte agilmente y ciertas habilidades como evadir daño.",
	"slat_SC_es": "PERGAMINO: Estos slats te permitirán manipular la magia para lanzar conjuros o superar trampas runicas.",
	"slat_SH_es": "ESCUDO: Estos slats te protegen del daño que puedas recibir.",
	"it_desc_short_sword_es": "ESPADA CORTA: Una pequeña espada bien afilada. Añade DOS ESPADA.",
}

var images = {
	"@SW":"[img=15]res://assets/slats/SW.png[/img]",
	"@HP":"[img=15]res://assets/bbimg/bb_hp.png[/img]",
	"@GR":"[img=15]res://assets/slats/GR.png[/img]",
	"@MC":"[img=15]res://assets/bbimg/gear.png[/img]"
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
